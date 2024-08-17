pub const index =
    \\<!DOCTYPE html>
    \\<html lang="en">
    \\<head>
    \\    <meta charset="UTF-8" />
    \\    <title>Ze Game</title></head>
    \\<body>
    \\<p>
    \\Ze Game will be available soon
    \\</p>
    \\    <canvas id="canvas" width="800" height="600"></canvas>
    \\    <script>
    \\        var canvas = document.getElementById("canvas");
    \\        var ctx = canvas.getContext("2d");
    \\
    \\        ctx.beginPath();            // Begin the path
    \\        ctx.rect(20, 20, 150, 100);
    \\        ctx.stroke();               // Draw the path
    \\
    \\        ctx.beginPath();            // Begin a new Path
    \\        ctx.strokeStyle = "purple";
    \\        ctx.moveTo(50, 0);
    \\        ctx.lineTo(150, 130);
    \\        ctx.stroke();               // Draw the newpath
    \\    </script>
    \\</body>
    \\</html>
;
