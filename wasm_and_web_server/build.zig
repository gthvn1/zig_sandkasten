const std = @import("std");

const Exe = struct {
    name: []const u8,
    source: []const u8,
};

pub fn build(b: *std.Build) void {
    const t = b.standardTargetOptions(.{});
    const executables = [_]Exe{
        .{ .name = "app_fibo", .source = "src/app_fibo.zig" },
        .{ .name = "web_fibo", .source = "src/web_fibo.zig" },
    };

    inline for (executables) |e| {
        const exe = b.addExecutable(.{
            .name = e.name,
            .root_source_file = b.path(e.source),
            .target = t,
        });

        b.installArtifact(exe);
    }

    // We also need to cross compile our fibo.zig to fibo.wasm...
    // https://github.com/daneelsan/minimal-zig-wasm-canvas/blob/master/build.zig
    const wasm = b.addExecutable(.{
        .name = "fibo",
        .root_source_file = b.path("./src/fibo.zig"),
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
