include(${CMAKE_CURRENT_LIST_DIR}/Utils.cmake)

# The first two checks are there to avoid warnings from the function from being displayed multiple times
if(CMAKE_TOOLCHAIN_FILE AND NOT CMAKE_SYSTEM_NAME AND NOT TOOLCHAIN_DISABLE_MOD_CHECKS)
    find_utils_for_mods()
endif()


set(CMAKE_SYSTEM_NAME Generic-ELF)
set(CMAKE_SYSTEM_PROCESSOR aarch64)
set(CMAKE_CROSSCOMPILING 1)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(SWITCH TRUE)
set(CMAKE_C_STANDARD 17)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_EXECUTABLE_SUFFIX ".elf")
set_property(GLOBAL PROPERTY TARGET_SUPPORTS_SHARED_LIBS FALSE)

if(CMAKE_HOST_WIN32)
    set(EXE_EXT ".exe")
endif()
if(DEFINED EMBEDDED_CLANG_TOOLCHAIN_DIR)
    set_compiler_clang("${EMBEDDED_CLANG_TOOLCHAIN_DIR}/bin/clang")
    set(CMAKE_LINKER "${CLANG_DIR}/bin/ld.lld${EXE_EXT}")
elseif(DEFINED COMPILER_CLANG_PATH)
    set_compiler_clang("${COMPILER_CLANG_PATH}")
elseif(CMAKE_TOOLCHAIN_FILE AND NOT "${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang" AND NOT CMAKE_CXX_COMPILER MATCHES "^.*clang.*$")
    message(FATAL_ERROR "Non clang compilers aren't supported please either use -DEMBEDDED_CLANG_TOOLCHAIN_DIR, -DCOMPILER_CLANG_PATH or manually set the C and C++ compilers to a clang compiler with -DCMAKE_{C, CXX}_COMPILER")
endif()


set(CMAKE_C_COMPILER_WORKS true)
set(CMAKE_CXX_COMPILER_WORKS true)
set(CMAKE_ASM_COMPILER_WORKS true)

set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} -x assembler-with-cpp -Wl,-z,norelro -g")

add_compile_options(--target=aarch64-none-elf)
add_compile_options(-mcpu=cortex-a57+fp+simd+crypto+crc)
add_compile_options(-mno-implicit-float)
add_compile_options(-stdlib=libc++)
add_compile_options(-fPIC)
add_compile_options(-fstandalone-debug)
add_compile_options(-v -Wall -O3 -nodefaultlibs -nostdlib -ffunction-sections -fdata-sections)
add_compile_options(-Werror=return-type)
add_compile_options(-fno-rtti -fno-asynchronous-unwind-tables -fno-unwind-tables)
add_compile_definitions(ARDUINOJSON_ENABLE_COMMENTS SWITCH)
add_link_options(-shared -ffunction-sections -fdata-sections)
add_link_options(-stdlib=libc++ -nodefaultlibs -nostdlib)
