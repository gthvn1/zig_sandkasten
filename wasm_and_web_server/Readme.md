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

## Build
- build with: `zig build`

## Run
- *TODO*: add a run step in `build.zig`.
- To run the server: `(cd ./zig-out/bin && ./web_fibo )`
    - and open http://localhost:8000/fibo
- To run the standalone application: `(cd ./zig-out/bin && ./app_fibo )`
- You can also run the web app without starting the server: `node ./node_fibo.js`
