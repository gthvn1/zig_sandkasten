const std = @import("std");

// Note that we don't want to use any libc stuff because at the end we want to
// be able to produce a simple WASM file.
//
// F(0) 0
// F(1) 1
// F(n) = F(n-1) + F(n-2)

// we want to be able to use a log function provided by another object file.
// As we don't want to allocate buffer we will used fixed sized buffer.
extern fn loggme(msg: [*:0]const u8) void;

pub export fn fibo(n: i32) i32 {
    const LOGBUFSIZE = 64;
    var logbuf = [_]u8{0} ** LOGBUFSIZE;

    const msg = std.fmt.bufPrintZ(logbuf[0..LOGBUFSIZE], "DEBUG: Compute fibo for {}\n", .{n}) catch unreachable;
    loggme(msg);

    if (n == 0)
        return 0;

    if (n == 1)
        return 1;

    var f_n: i32 = undefined; // Will be compute in the loop
    var f_n1: i32 = 1; // F(n-1) is F1
    var f_n2: i32 = 0; // F(n-2) is F0

    for (2..@intCast(n + 1)) |_| {
        f_n = f_n1 + f_n2;
        f_n2 = f_n1;
        f_n1 = f_n;
    }

    return f_n;
}
