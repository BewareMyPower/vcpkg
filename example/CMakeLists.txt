cmake_minimum_required(VERSION 3.14)

set(CMAKE_TOOLCHAIN_FILE "${CMAKE_SOURCE_DIR}/../scripts/buildsystems/vcpkg.cmake")
project(PulsarDemo CXX)

set(CMAKE_CXX_STANDARD 11)

find_package(unofficial-pulsar CONFIG)
add_executable(main main.cc)
target_link_libraries(main PRIVATE unofficial::pulsar::pulsar)
