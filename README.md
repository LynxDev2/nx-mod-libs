# nx-mod-libs

A collection of libraries for making mods for Nintendo Switch games.
Note: This is still very WIP and I plan on adding releases with prebuilt libs and tools for multiple platforms in the future

## Building and installing

First configure the project with:
```shell
cmake -S . -B build -G Ninja -DCLANG_DIR=/path/to/clang/toolchain
```

Then build the libraries with:
```shell
ninja -C build
```

And finally, install the lib with:
```shell
cmake --install build
```
