var wasm = undefined;
var memory = undefined;

document.getElementById('romFile').addEventListener('change', function(event) {
  // Get the selected file
  const file = event.target.files[0];

  if (wasm) {

    // Display the filename in the fileContent
    if (file) {
      document.getElementById('fileContent').textContent = file.name;
      // TODO: read the file content instead of printing its name
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
    w.instance.exports.chip8_init();
  });
