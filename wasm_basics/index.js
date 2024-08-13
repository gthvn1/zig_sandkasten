const fs = require('fs');
const wasmBuffer = fs.readFileSync('./fibo-web.wasm');

WebAssembly
	.instantiate(wasmBuffer)
	.then(wasmModule => {
		for (let i = 0; i < 50; i++) {
			console.log("fibo(" + i + ") = " + wasmModule.instance.exports.fibo(i));
		}
	});
