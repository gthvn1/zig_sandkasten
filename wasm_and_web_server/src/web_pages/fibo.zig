pub const index =
    \\<!DOCTYPE html>
    \\<html lang="en">
    \\<head>
    \\    <meta charset="UTF-8" />
    \\    <title>Fibonacci</title></head>
    \\<body>
    \\    <p>check console output</p>
    \\    <script>
    \\        var memory; // We need access to memory to read data like logs
    \\
    \\        function strlen(ptr) {
    \\          let len = 0;
    \\          // We don't expect string to have len greater than 1024 chars
    \\          while (memory[ptr] != 0 && len < 1024) {
    \\            len++;
    \\            ptr++;
    \\          }
    \\
    \\          return len;
    \\        }
    \\
    \\        function loggme(ptr) {
    \\          const len = strlen(ptr);
    \\          console.log(len);
    \\
    \\          const buf = new Uint8Array(memory.buffer, ptr, len);
    \\          //const str = new TextDecoder("utf8").decode(buf);
    \\          const str = String.fromCharCode(...buf);
    \\          console.log(str);
    \\        }
    \\
    \\        const imports = {
    \\            loggme,
    \\        };
    \\
    \\        WebAssembly
    \\            .instantiateStreaming(fetch("./fibo.wasm"), {env: imports})
    \\            .then((obj) => {
    \\                memory = obj.instance.exports["memory"];
    \\                console.log(obj.instance.exports.fibo(10));
    \\            });
    \\    </script>
    \\</body>
    \\</html>
;
