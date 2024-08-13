const std = @import("std");
const f = @import("fibo.zig");

pub fn main() void {
    var i: u32 = 0;

    while (i < 10) {
        std.debug.print("fibo({}) == {}\n", .{ i, f.fibo(i) });
        i += 1;
    }
}
