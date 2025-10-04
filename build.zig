const std = @import("std");

const headers = [_][]const u8{
    "lz4.h",
    "lz4file.h",
    "lz4frame.h",
    "lz4frame_static.h",
    "lz4hc.h",
    "xxhash.h",
};

const sources = [_][]const u8{
    "lib/lz4.c",
    "lib/lz4.c",
    "lib/lz4file.c",
    "lib/lz4frame.c",
    "lib/lz4hc.c",
    "lib/xxhash.c",
};

const defines = [_][]const u8{
    "-DXXH_NAMESPACE=LZ4_",
};

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const upstream = b.dependency("lz4", .{});

    const lib = b.addLibrary(.{
        .name = "lz4",
        .linkage = .static,
        .root_module = b.createModule(.{
            .link_libc = true,
            .target = target,
            .optimize = optimize,
        }),
    });
    lib.installHeadersDirectory(upstream.path("lib/"), "", .{
        .include_extensions = &headers,
    });
    lib.addCSourceFiles(.{
        .root = upstream.path(""),
        .files = &sources,
        .flags = &defines,
    });

    b.installArtifact(lib);

    // Smoke unit test
    const mod = b.addModule("test", .{
        .root_source_file = b.path("tests.zig"),
        .target = target,
        .optimize = optimize,
    });
    mod.linkLibrary(lib);

    const run_mod_tests = b.addRunArtifact(b.addTest(.{ .root_module = mod }));

    const test_step = b.step("test", "Run tests");
    test_step.dependOn(&run_mod_tests.step);
}
