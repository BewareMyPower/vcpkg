if (NOT TARGET pulsar::pulsar)
    get_filename_component(VCPKG_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" PATH)
    get_filename_component(VCPKG_IMPORT_PREFIX "${VCPKG_IMPORT_PREFIX}" PATH)
    get_filename_component(VCPKG_IMPORT_PREFIX "${VCPKG_IMPORT_PREFIX}" PATH)

    find_path(_pulsar_include_dir NAMES "pulsar/Client.h" PATH ${VCPKG_IMPORT_PREFIX})

    set(_cmake_find_library_suffixes ${CMAKE_FIND_LIBRARY_SUFFIXES})
    set(CMAKE_FIND_LIBRARY_SUFFIXES ".a" ".lib")
    find_library(_pulsar_library NAMES pulsar PATH ${VCPKG_IMPORT_PREFIX})
    if (NOT _pulsar_include_dir OR NOT _pulsar_library)
        message(FATAL_ERROR "Broken installation of vcpkg port pulsar-client-cpp")
    endif ()

    # Find 3rd party dependencies
    find_library(_ssl_library NAMES ssl PATH ${VCPKG_IMPORT_PREFIX})
    find_library(_crypto_library NAMES crypto PATH ${VCPKG_IMPORT_PREFIX})
    if (NOT _ssl_library OR NOT _crypto_library)
        message(FATAL_ERROR "Broken installation of vcpkg port openssl")
    endif ()

    find_library(_curl_library NAMES curl PATH ${VCPKG_IMPORT_PREFIX})
    if (NOT _curl_library)
        message(FATAL_ERROR "Broken installation of vcpkg port curl")
    endif ()

    find_library(_protobuf_library NAMES protobuf PATH ${VCPKG_IMPORT_PREFIX})
    if (NOT _protobuf_library)
        message(FATAL_ERROR "Broken installation of vcpkg port protobuf")
    endif ()

    find_library(_zlib_library NAMES z zlib PATH ${VCPKG_IMPORT_PREFIX})
    if (NOT _zlib_library)
        message(FATAL_ERROR "Broken installation of vcpkg port zlib")
    endif ()

    find_library(_zstd_library NAMES zstd PATH ${VCPKG_IMPORT_PREFIX})
    if (NOT _zstd_library)
        message(FATAL_ERROR "Broken installation of vcpkg port zstd")
    endif ()

    find_library(_snappy_library NAMES snappy PATH ${VCPKG_IMPORT_PREFIX})
    if (NOT _snappy_library)
        message(FATAL_ERROR "Broken installation of vcpkg port zstd")
    endif ()

    add_library(pulsar::pulsar STATIC IMPORTED)
    set_target_properties(pulsar::pulsar PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${_pulsar_include_dir}"
        IMPORTED_LOCATION "${_pulsar_library}")
    target_link_libraries(pulsar::pulsar INTERFACE
        ${_curl_library}
        ${_protobuf_library}
        ${_zlib_library}
        ${_zstd_library}
        ${_snappy_library}
        ${_ssl_library}
        ${_crypto_library}
        )
    if (APPLE)
        target_link_libraries(pulsar::pulsar INTERFACE
            "-framework Security"
            "-framework CoreFoundation"
            "-framework SystemConfiguration")
    endif ()
    set(CMAKE_FIND_LIBRARY_SUFFIXES ${_cmake_find_library_suffixes})
    unset(_cmake_find_library_suffixes)
    unset(_ssl_library)
    unset(_crypto_library)
    unset(_curl_library)
    unset(_protobuf_library)
    unset(_zlib_library)
    unset(_zstd_library)
    unset(_snappy_library)
    unset(_pulsar_library)
endif ()
unset(_pulsar_include_dir)
