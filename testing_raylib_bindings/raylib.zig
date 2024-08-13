const raylib = @cImport({
    @cInclude("raylib.h");
});

pub const Vector2 = @Vector(2, f32);

pub const Color = struct {
    r: u8,
    g: u8,
    b: u8,
    a: u8,
};

pub fn get_frame_time() f32 {
    return raylib.GetFrameTime();
}

pub fn init_window(width: isize, height: isize, title: [:0]const u8) void {
    const w: c_int = @intCast(width);
    const h: c_int = @intCast(height);

    raylib.InitWindow(w, h, title.ptr);
}

pub fn close_window() void {
    raylib.CloseWindow();
}

pub fn clear_background(color: Color) void {
    const col = raylib.Color{ .r = color.r, .g = color.g, .b = color.b, .a = color.a };
    raylib.ClearBackground(col);
}

pub fn window_should_close() bool {
    return raylib.WindowShouldClose();
}

pub fn begin_drawing() void {
    raylib.BeginDrawing();
}

pub fn end_drawing() void {
    raylib.EndDrawing();
}

pub fn draw_circle_v(center: Vector2, radius: f32, color: Color) void {
    const c = raylib.Vector2{ .x = center[0], .y = center[1] };
    const col = raylib.Color{ .r = color.r, .g = color.g, .b = color.b, .a = color.a };
    raylib.DrawCircleV(c, radius, col);
}
