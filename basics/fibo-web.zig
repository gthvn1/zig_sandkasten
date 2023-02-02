export fn fibo(a: i32) i32 {
    if (a <= 1) {
        return 1;
    }
    return fibo(a - 1) + fibo(a - 2);
}
