const std = @import("std");

fn fibo(x: i32) i32 {
    if (x <= 1) {
        return x;
    }

    // It overflows at 47
    if (x >= 47) {
        return 0;
    }

    var a: i32 = 0; // f0
    var b: i32 = 1; // f1
    var i: i32 = 1; // index

    while (x > i) {
        var temp = a;

        a = b;
        b += temp;
        i += 1;
    }

    return b;
}

pub fn main() void {
    var i: i32 = 0;

    while (i < 10) {
        std.debug.print("fibo({}) == {}\n", .{ i, fibo(i) });
        i += 1;
    }
}
