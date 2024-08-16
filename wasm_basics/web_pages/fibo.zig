pub const index =
    \\<!DOCTYPE html>
    \\<html lang="en">
    \\<head>
    \\    <meta charset="UTF-8" />
    \\    <title>Fibonacci</title></head>
    \\<body>
    \\    <p>check console output</p>
    \\    <script>
    \\        const imports = {
    \\            loggme: () => console.log("Todo"),
    \\        };
    \\
    \\        WebAssembly
    \\            .instantiateStreaming(fetch("./fibo.wasm"), {env: imports})
    \\            .then((obj) => {
    \\                console.log(obj.instance.exports.fibo(10));
    \\            });
    \\    </script>
    \\</body>
    \\</html>
;
