const std = @import("std");
const html_errors = @import("web_pages/html_errors.zig");

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

pub fn main() !void {
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

            // We only need the method (GET, POST, ...) and the path
            std.debug.print("method: {}\n", .{req.head.method});
            std.debug.print("path: {s}\n", .{req.head.target});

            if (req.head.method == std.http.Method.GET) {
                switch (Paths.stringtoPaths(req.head.target)) {
                    .game => std.debug.print("GAME", .{}),
                    .data => std.debug.print("DATA", .{}),
                    .unknown => std.debug.print("OTHER", .{}),
                }
            }
            // Answer not implemented for now
            try req.respond(html_errors.not_implemented, .{
                .status = std.http.Status.not_implemented,
            });
        } else |err| {
            std.debug.print("Failed to receive the header: {}\n", .{err});
        }
    } else |err| {
        std.debug.print("failed to accept connection: {}\n", .{err});
    }
}
