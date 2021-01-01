set(CPACK_PACKAGE_NAME ${PROJECT_NAME}
    CACHE STRING "The resulting package name"
)

if(NXML_BUNDLE_FULL)
    set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "A bundle with libraries, binaries and a clang toolchain for making code mods for Nintendo Switch games")

else()
    set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "A collection of libraries for making code mods for Nintendo Switch games")
endif()
set(CPACK_PACKAGE_VENDOR "JMNSEM (Just make Nintendo Switch exefs mods)")

set(CPACK_VERBATIM_VARIABLES YES)

set(CPACK_PACKAGE_INSTALL_DIRECTORY ${CPACK_PACKAGE_NAME})
SET(CPACK_OUTPUT_FILE_PREFIX "${CMAKE_SOURCE_DIR}/_packages")

# https://unix.stackexchange.com/a/11552/254512
set(CPACK_PACKAGING_INSTALL_PREFIX "/usr/local")

set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})

set(CPACK_PACKAGE_CONTACT "128722393+LynxDev2@users.noreply.github.com")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "LynxDev2")

#set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")
set(CPACK_RESOURCE_FILE_README "${CMAKE_CURRENT_SOURCE_DIR}/README.md")

set(CPACK_COMPONENTS_GROUPING ALL_COMPONENTS_IN_ONE)
# without this you won't be able to pack only specified component
set(CPACK_DEB_COMPONENT_INSTALL YES)

include(CPack)
