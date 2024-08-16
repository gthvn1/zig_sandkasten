const std = @import("std");
const whelp = @import("web_pages/help.zig");
const wgame = @import("web_pages/game.zig");
const wfibo = @import("web_pages/fibo.zig");

const Paths = enum {
    root,
    data,
    fibo,
    fibo_wasm,
    help,
    game,
    unknown,

    pub fn stringtoPaths(s: []const u8) Paths {
        const Lookup = struct {
            path: []const u8,
            path_e: Paths,
        };

        const lookup = [_]Lookup{
            .{ .path = "/", .path_e = .root },
            .{ .path = "/data", .path_e = .data },
            .{ .path = "/fibo", .path_e = .fibo },
            .{ .path = "/fibo.wasm", .path_e = .fibo_wasm },
            .{ .path = "/game", .path_e = .game },
            .{ .path = "/help", .path_e = .help },
        };

        inline for (lookup) |e| {
            if (std.mem.eql(u8, s, e.path)) return e.path_e;
        }

        return .unknown;
    }
};

fn game_respond(req: *std.http.Server.Request) !void {
    try req.respond(wgame.index, .{
        .status = .ok,
        .extra_headers = &.{
            .{ .name = "Content-Type", .value = "text/html" },
        },
    });
}

fn data_respond(req: *std.http.Server.Request) !void {
    const Game = struct {
        weight: u32,
        height: u32,
    };

    const game = Game{ .weight = 800, .height = 600 };
    var buf: [128]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buf);
    var string = std.ArrayList(u8).init(fba.allocator());
    defer string.deinit();

    std.json.stringify(game, .{}, string.writer()) catch |err| {
        // 128 bytes should be ok to hold the structure. If not we just need to
        // reset the string and report an error instead of crashing the server.
        std.debug.print("ERROR: data_respond: {}\n", .{err});
        string.resize(0) catch unreachable;
        std.json.stringify("Server error", .{}, string.writer()) catch unreachable;
    };

    try req.respond(string.items, .{
        .status = .ok,
        .extra_headers = &.{
            .{ .name = "Content-Type", .value = "application/json" },
        },
    });
}

fn fibo_respond(req: *std.http.Server.Request) !void {
    // Answer not implemented and print help
    try req.respond(wfibo.index, .{
        .status = .ok,
        .extra_headers = &.{
            .{ .name = "Content-Type", .value = "text/html" },
        },
    });
}

// Request for downloading a file
fn fibo_wasm_respond(req: *std.http.Server.Request) !void {
    const allocator = std.heap.page_allocator;

    var file = try std.fs.cwd().openFile("./fibo.wasm", .{});
    defer file.close();

    const file_size = try file.getEndPos();
    const file_contents = try allocator.alloc(u8, file_size);
    defer allocator.free(file_contents);

    const carlu = try file.readAll(file_contents);
    std.debug.print("read {} bytes for fibo.wasm\n", .{carlu});

    try req.respond(file_contents, .{
        .status = .ok,
        .extra_headers = &.{
            .{ .name = "Content-Type", .value = "application/wasm" },
        },
    });
}

fn unknown_respond(req: *std.http.Server.Request) !void {
    // Answer not implemented and print help
    try req.respond(whelp.index, .{
        .status = .not_implemented,
        .extra_headers = &.{
            .{ .name = "Content-Type", .value = "text/html" },
        },
    });
}

fn help_respond(req: *std.http.Server.Request) !void {
    // Answer not implemented for now
    try req.respond(whelp.index, .{
        .status = .ok,
        .extra_headers = &.{
            .{ .name = "Content-Type", .value = "text/html" },
        },
    });
}

fn start_server() !void {
    const listen_addr = try std.net.Address.parseIp4("0.0.0.0", 8000);
    var listener = try listen_addr.listen(.{
        .reuse_port = true,
    });
    defer listener.deinit();

    std.debug.print("Listening on {}\n", .{listen_addr});
    while (listener.accept()) |conn| {
        defer conn.stream.close();

        // Init the server to respond to the connection.
        // We only expect GET with path.
        const max_req_len = 512;
        var buffer = [_]u8{0} ** max_req_len;
        var server = std.http.Server.init(conn, buffer[0..]);

        // Try to get the request. 512 bytes should be enough but in case instead
        // of crashing we catch the error. It will reset the connection but we will
        // be able to serve another connection.
        if (server.receiveHead()) |request| {
            var req = request; // request is a const

            if (req.head.method == std.http.Method.GET) {
                std.debug.print("Trying to serve {s}\n", .{req.head.target});
                try switch (Paths.stringtoPaths(req.head.target)) {
                    .data => data_respond(&req),
                    .fibo => fibo_respond(&req),
                    .fibo_wasm => fibo_wasm_respond(&req),
                    .game => game_respond(&req),
                    .help => help_respond(&req),
                    .root => help_respond(&req),
                    .unknown => unknown_respond(&req),
                };
            } else {
                // Only GET is supported
                try unknown_respond(&req);
            }
        } else |err| {
            std.debug.print("Failed to receive the header: {}\n", .{err});
        }
    } else |err| {
        std.debug.print("failed to accept connection: {}\n", .{err});
    }
}

pub fn main() !void {
    try start_server();
}
