const fs = require('fs');
const wasmModule = fs.readFileSync('./fibo.wasm');

WebAssembly
	.instantiate(wasmModule)
	.then(obj => {
		for (let i = 0; i < 10; i++) {
			console.log("fibo(" + i + ") = " + obj.instance.exports.fibo(i));
		}
	});
