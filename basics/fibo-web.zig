export fn fibo(x: u32) u32 {
    if (x <= 1) {
        return x;
    }

    // It overflows at 47
    if (x >= 47) {
        return 0;
    }

    var a: u32 = 0; // f0
    var b: u32 = 1; // f1
    var i: u32 = 1; // index

    while (x > i) {
        var temp = a;

        a = b;
        b += temp;
        i += 1;
    }

    return b;
}
