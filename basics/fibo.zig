const std = @import("std");

fn fibo(a: i32) i32 {
    if (a <= 1) {
        return 1;
    }
    return fibo(a - 1) + fibo(a - 2);
}

pub fn main() void {
    var i: i32 = 0;

    while (i < 10) {
        std.debug.print("fibo({}) == {}\n", .{ i, fibo(i) });
        i += 1;
    }
}
