## Wasm Basics

Let's play with zig and wasm. Try to build a wasm file and also use it in a standalone application.

## Zig standalone

- Build using: `zig build-exe app.zig`
- And run it: `./app`

## Zig to wasm

To generate wasm file:
- `zig build-lib fibo-web.zig -target wasm32-freestanding -dynamic`
Note: without dynamic it generates a ".a" file.

To run it you can use the index.js
- `node index.js`
