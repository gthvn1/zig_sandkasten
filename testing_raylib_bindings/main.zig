const std = @import("std");
const rl = @import("raylib.zig");

const Vector2 = rl.Vector2;

pub fn main() void {
    const title = "Testing Zig & Raylib";
    const win_width: isize = 800;
    const win_height: isize = 600;

    var ball_pos = Vector2{ win_width / 2, 20 };
    const ball_size: f32 = 10.0;
    var velocity = Vector2{ 0, 500 };
    const gravity = Vector2{ 0, 0.1 };

    const pink: rl.Color = .{
        .r = 0xFF,
        .g = 0x00,
        .b = 0xFF,
        .a = 0xFF,
    };

    std.debug.print("Hello, Sailor!", .{});
    rl.init_window(win_width, win_height, title);
    defer rl.close_window();

    while (!rl.window_should_close()) {
        // Update
        const dt: f32 = rl.get_frame_time();

        ball_pos += velocity * Vector2{ dt, dt };
        velocity += gravity;

        if (ball_size >= ball_pos[1] or ball_pos[1] >= win_height - ball_size) {
            // We hit the top or the ground so inverse y velocity
            // Each time we hit something we are loosing energy
            velocity *= Vector2{ 1, -0.9 };
        }

        if (ball_size >= ball_pos[0] or ball_pos[0] >= win_width - ball_size) {
            // We hit the left or right so inverse x velocity
            velocity *= Vector2{ -0.9, 1 };
        }

        // Draw
        rl.begin_drawing();
        rl.clear_background(rl.Color{ .r = 0x0, .g = 0x00, .b = 0x00, .a = 0xFF });
        rl.draw_circle_v(ball_pos, 10.0, pink);
        rl.end_drawing();
    }
}
