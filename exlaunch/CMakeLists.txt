add_library(exlaunch STATIC)
add_library(NXModLibs::exlaunch ALIAS exlaunch)

target_sources(exlaunch
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/exl/module.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/exl/diag/abort.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/exl/hook/nx64/hook_impl.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/exl/hook/nx64/inline_asm.s
        ${CMAKE_CURRENT_SOURCE_DIR}/exl/hook/nx64/inline_impl.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/exl/nx/arm/cache.s
        ${CMAKE_CURRENT_SOURCE_DIR}/exl/nx/kernel/svc.s
        ${CMAKE_CURRENT_SOURCE_DIR}/exl/nx/kernel/virtmem.c
        ${CMAKE_CURRENT_SOURCE_DIR}/exl/reloc/elf.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/exl/reloc/rtld/ld.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/exl/reloc/rtld/ModuleObject.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/exl/reloc/rtld/utils.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/exl/util/sys/cur_proc_handle.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/exl/util/sys/mem_layout.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/exl/util/sys/rw_pages.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/exl/util/random.cpp
)

target_include_directories(exlaunch
    PUBLIC
        # Current source dir for projects that come with the lib and the library include dir for projects that use an installed lib
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

install( 
  TARGETS exlaunch
  EXPORT NXModLibsTargets
  COMPONENT exlaunch
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

# Included from ../cmake/Utils.cmake
install_headers_recursive(exl)

