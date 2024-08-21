const std = @import("std");

extern fn loggme(sptr: [*]const u8, slen: usize) void;

const chip8_memory: [4096]u8 = [_]u8{0} ** 4096;

pub export fn get_chip8_mem() [*]const u8 {
    return &chip8_memory;
}

pub export fn chip8_run() void {
    var logbuf: [1024]u8 = undefined;

    const msg = std.fmt.bufPrint(&logbuf, "Running Chip8 emulation", .{}) catch unreachable;
    loggme(msg.ptr, msg.len);
}
