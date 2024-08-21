const std = @import("std");

extern fn loggme(sptr: [*]const u8, slen: usize) void;

pub export fn chip8_init() void {
    var logbuf: [1024]u8 = undefined;

    const msg = std.fmt.bufPrint(&logbuf, "Chip8 init called", .{}) catch unreachable;
    loggme(msg.ptr, msg.len);
}
