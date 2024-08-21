const std = @import("std");

pub fn build(b: *std.Build) void {
    const wasm = b.addExecutable(.{
        .name = "chip8",
        .root_source_file = b.path("./chip8.zig"),
        .target = b.resolveTargetQuery(.{
            .cpu_arch = .wasm32,
            .os_tag = .freestanding,
        }),
        .optimize = .ReleaseSmall,
    });
    wasm.rdynamic = true;
    wasm.entry = .disabled;

    b.installArtifact(wasm);
}
