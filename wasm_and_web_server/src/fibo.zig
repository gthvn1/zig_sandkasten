const std = @import("std");

// Note that we don't want to use any libc stuff because at the end we want to
// be able to produce a simple WASM file.
//
// F(0) 0
// F(1) 1
// F(n) = F(n-1) + F(n-2)

// we want to be able to use a log function provided by another object file.
// As we don't want to allocate buffer we will used fixed sized buffer.
extern fn loggme(sptr: [*]const u8, slen: usize) void;

pub export fn fibo(n: i32) i32 {
    var logbuf: [1024]u8 = undefined;

    if (std.fmt.bufPrint(&logbuf, "Computed fibo({})", .{n})) |log| {
        loggme(log.ptr, log.len);
    } else |_| {
        const err: []const u8 = "Failed to print log";
        loggme(err.ptr, err.len);
    }

    if (n == 0)
        return 0;

    if (n == 1)
        return 1;

    var f_n: i32 = undefined; // Will be computed in the loop
    var f_n1: i32 = 1; // F(n-1) is F1
    var f_n2: i32 = 0; // F(n-2) is F0

    for (2..@intCast(n + 1)) |_| {
        f_n = f_n1 + f_n2;
        f_n2 = f_n1;
        f_n1 = f_n;
    }

    return f_n;
}
