## First try

Let's play with zig

## Zig to wasm

To generate wasm file:
- `zig build-lib fibo-web.zig -target wasm32-freestanding -dynamic`
Note: without dynamic it generates a ".a" file.

To run it you can use the index.js
- `node index.js`
