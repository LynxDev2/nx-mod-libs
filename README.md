# nx-mod-libs

A collection of libraries for making mods for Nintendo Switch games.
Note: This is still very WIP and I plan on adding releases with prebuilt libs and tools for multiple platforms in the future

## Configuring the project

The base command for configuring the project is:
```shell
cmake -S . -B build -G Ninja --toolchain=cmake/toolchain.cmake
```

After that you can configure the compiler with one of these three additions to the end of the command:

1. (Reccomended) Download a embedded clang toolchain like [this one](https://github.com/ARM-software/LLVM-embedded-toolchain-for-Arm/releases/tag/release-17.0.1) and add `-DEMBEDDED_CLANG_TOOLCHAIN_DIR=/absolute/path/to/toolchain`

2. If you already have a version of clang that supports the `aarch64-none-elf` target installed you can use `-DCOMPILER_CLANG_PATH` which will set the C compiler and the assembler to the given path and the C++ compiler to the same path with `++` appended to it. For example if you have `clang` and `clang++` in your path you can use `-DCOMPILER_CLANG_PATH=clang`, if instead you have `aarch64-none-elf-clang` and `aarch64-none-elf-clang++` in `~/.local/bin/`, you can use `-DCOMPILER_CLANG_PATH=$HOME/.local/bin/aarch64-none-elf-clang+`

3. (Not reccomended) You can also set the C and C++ compiler and assembler manually with `-DCMAKE_{C, CXX, ASM}_COMPILER`. Please note that the only supported compiler is `clang`

Example of configuring the project to use the embedded clang toolchain
```shell
cmake -S . -B build -G Ninja --toolchain=cmake/toolchain.cmake -DEMBEDDED_CLANG_TOOLCHAIN_DIR=$HOME/LLVMEmbeddedToolchainForArm-17.0.1-Linux-x86_64
```

## Building and installing

First build the libraries with:
```shell
ninja -C build
```

Then install the lib with:
```shell
cmake --install build
```
