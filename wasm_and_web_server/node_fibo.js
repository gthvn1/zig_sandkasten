const fs = require('fs');

const wasmModule = fs.readFileSync('./zig-out/bin/fibo.wasm');
var memory; // We need access to memory to read data like logs

function loggme(sptr, slen) {
  const buf = new Uint8Array(memory.buffer, sptr, slen);
  const str = new TextDecoder("utf8").decode(buf);
  console.log(str);
}

const imports = {
  loggme,
};

WebAssembly
  .instantiate(wasmModule, { env: imports })
  .then((obj) => {
    memory = obj.instance.exports["memory"];
    for (let i = 0; i <= 10; i++) {
      console.log(obj.instance.exports.fibo(i));
    }
  });
