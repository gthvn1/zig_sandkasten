const std = @import("std");
const not_implemented = @import("web_pages/not_implemented.zig");
const ze_game = @import("web_pages/ze_game.zig");

const Paths = enum {
    game,
    data,
    unknown,

    pub fn stringtoPaths(s: []const u8) Paths {
        if (std.mem.eql(u8, s, "/game")) {
            return .game;
        }

        if (std.mem.eql(u8, s, "/data")) {
            return .data;
        }

        return .unknown;
    }
};

fn game_respond(req: *std.http.Server.Request) !void {
    try req.respond(ze_game.index, .{
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

fn help_respond(req: *std.http.Server.Request) !void {
    // Answer not implemented for now
    try req.respond(not_implemented.index, .{
        .status = .not_implemented,
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
                try switch (Paths.stringtoPaths(req.head.target)) {
                    .game => game_respond(&req),
                    .data => data_respond(&req),
                    .unknown => help_respond(&req),
                };
            } else {
                // Only GET is supported
                try help_respond(&req);
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
