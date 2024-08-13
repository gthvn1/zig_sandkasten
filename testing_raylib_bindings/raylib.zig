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

pub fn set_target_fps(fps: usize) void {
    const c_fps: c_int = @intCast(fps);
    return raylib.SetTargetFPS(c_fps);
}

pub fn get_frame_time() f32 {
    return raylib.GetFrameTime();
}

pub fn is_space_pressed() bool {
    return raylib.IsKeyPressed(raylib.KEY_SPACE);
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

pub fn draw_text(text: [:0]const u8, pos: Vector2) void {
    const pos_x: c_int = @intFromFloat(pos[0]);
    const pos_y: c_int = @intFromFloat(pos[1]);
    const fs: c_int = 12;

    raylib.DrawText(text.ptr, pos_x, pos_y, fs, raylib.WHITE);
}

pub fn draw_circle_v(center: Vector2, radius: f32, color: Color) void {
    const c = raylib.Vector2{ .x = center[0], .y = center[1] };
    const col = raylib.Color{ .r = color.r, .g = color.g, .b = color.b, .a = color.a };
    raylib.DrawCircleV(c, radius, col);
}
