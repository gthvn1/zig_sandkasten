const fs = require('fs');
const wasmBuffer = fs.readFileSync('./fibo-web.wasm');

WebAssembly
	.instantiate(wasmBuffer)
	.then(wasmModule => {
		console.log(wasmModule.instance.exports.fibo(5));
	});
