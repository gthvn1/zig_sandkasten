const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "main",
        .root_source_file = b.path("main.zig"),
        .target = b.standardTargetOptions(.{}),
    });

    // link with C
    exe.linkLibC();
    // Add Raylib library
    exe.addObjectFile(b.path("raylib-5.0_linux_amd64/lib/libraylib.a"));
    // Add include path
    exe.addIncludePath(b.path("raylib-5.0_linux_amd64/include"));

    b.installArtifact(exe);
}
