add_library(marshmallow STATIC)
add_library(NXModLibs::marshmallow ALIAS marshmallow)

target_include_directories(marshmallow
    PUBLIC
        # Current source dir when building the lib and lib include dir when using the lib
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
    PRIVATE
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/NintendoSDK>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/NintendoSDK>
)

target_sources(marshmallow
    PRIVATE
        mallow/alloc.hpp
        mallow/config.cpp
        mallow/exception/abort.cpp
        mallow/exception/handler.cpp
        mallow/exception/handler.hpp
        mallow/exception/handler.s
        mallow/init/init.cpp
        mallow/init/initLogging.cpp
        mallow/init/initArgs.hpp
        mallow/init/crt0.s
        mallow/logging/debug.hpp
        mallow/logging/logger.cpp
        mallow/logging/logger.hpp
        mallow/logging/logSinks.cpp
        mallow/logging/logSinks.hpp
        mallow/net/socket.cpp
)

target_link_libraries(marshmallow PUBLIC NXModLibs::exlaunch)

install(
  TARGETS marshmallow
  EXPORT NXModLibsTargets
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

# Included from ../cmake/Utils.cmake
install_headers_recursive(mallow)

install(FILES ArduinoJson.hpp DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
