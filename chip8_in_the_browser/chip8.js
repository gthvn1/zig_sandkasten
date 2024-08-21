var wasm = undefined;
var memory = undefined;
var chip8Mem = undefined;

document.getElementById('romFile').addEventListener('change', function(event) {
  // Get the selected file
  const file = event.target.files[0];

  if (wasm) {
    if (file) {
      const reader = new FileReader();

      // We want to write the contents of the ROM into chip8 memory
      const chip8MemStartAddr = wasm.instance.exports.get_chip8_mem();
      const chip8MemSize = 4096;

      // The program is loaded at 0x200
      chip8Mem = new Uint8Array(memory.buffer, chip8MemStartAddr + 0x200, chip8MemSize - 0x200);

      reader.onload = function(e) {
        const arrayBuffer = e.target.result;
        // Create a temporary Uint8Array to hold the file data
        const tempUint8Array = new Uint8Array(arrayBuffer);
        // Now we can copy the content to the chip8 mem
        chip8Mem.set(tempUint8Array);
        console.log(chip8Mem);

        wasm.instance.exports.chip8_run();
      };

      reader.readAsArrayBuffer(file);
    } else {
      document.getElementById('fileContent').textContent = "ROM not loaded";
    }
  } else {
    document.getElementById('fileContent').textContent = "wasm not loaded";
  }
});

function loggme(sptr, slen) {
  const buf = new Uint8Array(memory.buffer, sptr, slen);
  const str = new TextDecoder("utf8").decode(buf);
  console.log(str);
}

const imports = {
  env: {
    loggme
  },
};

WebAssembly.instantiateStreaming(fetch("./zig-out/bin/chip8.wasm"), imports).then(
  (w) => {
    wasm = w;
    memory = w.instance.exports.memory;
  });
