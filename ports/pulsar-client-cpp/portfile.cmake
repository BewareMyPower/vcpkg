vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO apache/pulsar-client-cpp
    REF "v${VERSION}"
    SHA512 ab257f5e82d3815a232dd73297c6ff032536de3d9e5adec6c53fa0276fc02efb1a84e153278f21881de1d3a786e26c4d4d2aff78c1d3fbf932f4d5b6e8cae9dc
    HEAD_REF main
    PATCHES
      0001-protobuf-generate.patch
      0002-macos-framework.patch
)


vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DLATEST_PROTOBUF=TRUE
        -DBUILD_TESTS=OFF
)

vcpkg_cmake_install()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

configure_file("${SOURCE_PATH}/LICENSE" "${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright" COPYONLY)
configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)

file(COPY "${CURRENT_PORT_DIR}/pulsar-config.cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")

vcpkg_copy_pdbs()
