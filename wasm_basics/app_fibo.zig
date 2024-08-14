const std = @import("std");
const f = @import("fibo.zig");

export fn loggme(msg: [*:0]const u8) void {
    // Msg is null terminated so we can find its len
    const len = std.mem.len(msg);

    std.debug.print("{s}", .{msg[0..len]});
}

pub fn main() void {
    for (0..10) |v| {
        std.debug.print("fibo({}) = {}\n", .{ v, f.fibo(@intCast(v)) });
    }
}
