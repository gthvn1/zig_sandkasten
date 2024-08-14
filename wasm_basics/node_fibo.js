const fs = require('fs');
const wasmModule = fs.readFileSync('./fibo.wasm');

const env = {
  loggme: () => console.log("TODO"),
};

WebAssembly
  .instantiate(wasmModule, {env: env,})
  .then((obj) => {
    for (let i = 0; i < 10; i++) {
      console.log(obj.instance.exports.fibo(i));
    }
  });
