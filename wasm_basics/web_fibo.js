const imports = {
  loggme: () => console.log("Todo"),
};

WebAssembly
  .instantiateStreaming(fetch("./fibo.wasm"), {env: imports})
  .then((obj) => {
    console.log(obj.instance.exports.fibo(10));
  });
