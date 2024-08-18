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
    \\        function loggme(sptr, slen) {
    \\          const buf = new Uint8Array(memory.buffer, sptr, slen);
    \\          const str = new TextDecoder("utf8").decode(buf);
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
