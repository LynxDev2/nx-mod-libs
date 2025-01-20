function(install_headers_recursive src_dir)
    file(GLOB_RECURSE PUBLIC_HEADERS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} ${src_dir}/*.h ${src_dir}/*.hpp)

    foreach(file ${PUBLIC_HEADERS})
	install(FILES ${file} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${file})
    endforeach()
endfunction()

function(set_compiler_and_flags)

    if(NOT EXISTS ${CLANG_DIR})
	message(FATAL_ERROR "Clang toolchain location not set, please set it with -DCLANG_DIR=/path/to/toolchain")
    endif()

    set(SWITCH TRUE PARENT_SCOPE)
    set(CMAKE_C_STANDARD 17 PARENT_SCOPE)
    set(CMAKE_CXX_STANDARD 23 PARENT_SCOPE)
    set(CMAKE_EXECUTABLE_SUFFIX ".elf" PARENT_SCOPE)
    set_property(GLOBAL PROPERTY TARGET_SUPPORTS_SHARED_LIBS FALSE)

    if(CMAKE_HOST_WIN32)
	set(EXE_EXT ".exe")
    endif()

    set(CMAKE_C_COMPILER "${CLANG_DIR}/bin/clang${EXE_EXT}" PARENT_SCOPE)
    set(CMAKE_CXX_COMPILER "${CLANG_DIR}/bin/clang++${EXE_EXT}" PARENT_SCOPE)
    set(CMAKE_ASM_COMPILER "${CLANG_DIR}/bin/clang${EXE_EXT}" PARENT_SCOPE)
    set(CMAKE_LINKER "${CLANG_DIR}/clang/bin/ld.lld${EXE_EXT}" PARENT_SCOPE)

    set(CMAKE_C_COMPILER_WORKS true PARENT_SCOPE)
    set(CMAKE_CXX_COMPILER_WORKS true PARENT_SCOPE)
    set(CMAKE_ASM_COMPILER_WORKS true PARENT_SCOPE)

    set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} -x assembler-with-cpp -Wl,-z,norelro -g" PARENT_SCOPE)

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
endfunction()
