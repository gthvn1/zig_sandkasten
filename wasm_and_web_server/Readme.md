# What we want to achieve...

- We want to provide a set of functions that can be used from web and also from standalone application.
- Let's start by providing a fibonacci function.

# Steps

- [x] the first step is to have it working as a standalone application
- [x] then try to run into into web
- [x] and adds imports functions as well...

# Conclusion

- We have:
    - `fibo.zig`: is the naive implementation of fibonacci sequence in Zig
    - This file can be compiled as an object file and called from either:
        - `app_fibo.zig`: a standalone application in Zig
        - `node_fibo.js`: that loads the `fibo.wasm` file generated from the same `fibo.zig` code.

# Test it

*TODO*: add a run step in `build.zig`. Until we add it you have three ways to test fibo:
- run the server: `(zig build && cd ./zig-out/bin && ./web_fibo )`
    - and open http://localhost:8000/fibo
- run the standalone application: `(zig build && cd ./zig-out/bin && ./app_fibo )`
- run the web app without starting the server: `zig build && node ./node_fibo.js`
