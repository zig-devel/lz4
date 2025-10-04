const std = @import("std");

const lz4 = @cImport({
    @cInclude("lz4.h");
});

// Just a smoke test to make sure the library is linked correctly.
test {
    const version = lz4.LZ4_versionString();

    try std.testing.expectEqualStrings(std.mem.span(version), "1.10.0");
}
