function(install_headers_recursive src_dir)
    file(GLOB_RECURSE PUBLIC_HEADERS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} ${src_dir}/*.h ${src_dir}/*.hpp)

    foreach(file ${PUBLIC_HEADERS})
        get_filename_component(file_dir ${file} DIRECTORY)
	install(FILES ${file} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${file_dir})
    endforeach()
endfunction()

function(set_compiler_clang clang_path)
    set(CMAKE_C_COMPILER "${clang_path}${EXE_EXT}" PARENT_SCOPE)
    set(CMAKE_CXX_COMPILER "${clang_path}++${EXE_EXT}" PARENT_SCOPE)
    set(CMAKE_ASM_COMPILER "${clang_path}${EXE_EXT}" PARENT_SCOPE)
endfunction()
