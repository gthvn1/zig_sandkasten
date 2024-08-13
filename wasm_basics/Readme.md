# Wasm Basics

Let's play with [Zig](https://ziglang.org/) (version 0.13.0) and [Wasm](https://webassembly.org/). 
- Try to build a wasm file and also use it in a standalone application.

## Zig standalone

- Build using: `zig build-exe app.zig`
- And run it: `./app`

## Zig to wasm

- Generate the wasm file: `zig build-exe  -target wasm32-freestanding -O ReleaseSmall -fno-entry -rdynamic fibo.zig`
- And run it: `node index.js`

## Add a Makefile

- What is interesting here is that both application are using the same library `fibo.zig`...
```
❯ make all
zig build-exe app.zig
zig build-exe \
        -target wasm32-freestanding \
        -O ReleaseSmall \
        -fno-entry \
        -rdynamic \
        fibo.zig

❯ ./app
fibo(0) == 0
fibo(1) == 1
fibo(2) == 1
fibo(3) == 2
fibo(4) == 3
fibo(5) == 5
fibo(6) == 8
fibo(7) == 13
fibo(8) == 21
fibo(9) == 34

❯ node ./index.js
fibo(0) = 0
fibo(1) = 1
fibo(2) = 1
fibo(3) = 2
fibo(4) = 3
fibo(5) = 5
fibo(6) = 8
fibo(7) = 13
fibo(8) = 21
fibo(9) = 34
```
