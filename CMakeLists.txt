project(NXModLibs)

include(cmake/Utils.cmake)
include(GNUInstallDirs)

set_compiler_and_flags()

add_subdirectory(exlaunch)
add_subdirectory(marshmallow)

install(
  EXPORT NXModLibsTargets
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/NXModLibs
  NAMESPACE NXModLibs::
  FILE NXModLibsTargets.cmake
)

include(CMakePackageConfigHelpers)
configure_package_config_file( 
  "cmake/Config.cmake.in"
  "NXModLibsConfig.cmake"
  INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/NXModLibs
  PATH_VARS
    CMAKE_INSTALL_LIBDIR
)

install(
  FILES "${CMAKE_CURRENT_BINARY_DIR}/NXModLibsConfig.cmake"
	#"${CMAKE_CURRENT_BINARY_DIR}/MyPackConfigVersion.cmake"
  DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/NXModLibs"
)

