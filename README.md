# [lz4](https://www.lz4.org)@v1.10.0 [![Build and test library](https://github.com/zig-devel/lz4/actions/workflows/library.yml/badge.svg)](https://github.com/zig-devel/lz4/actions/workflows/library.yml)

Extremely fast compression algorithm

## Usage

Install library:

```sh
zig fetch --save https://github.com/zig-devel/lz4/archive/refs/tags/1.10.0-0.tar.gz
```

Statically link with `mod` module:

```zig
const lz4 = b.dependency("lz4", .{
    .target = target,
    .optimize = optimize,
});

mod.linkLibrary(lz4.artifact("lz4"));
```

## License

All code in this repo is dual-licensed under [0BSD](./LICENSES/0BSD.txt) OR [GPL-2.0-or-later](./LICENSES/GPL-2.0-or-later.txt).
