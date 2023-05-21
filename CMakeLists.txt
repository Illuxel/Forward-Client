cmake_minimum_required(VERSION 3.24 FATAL_ERROR)

project(Forward.Desktop
    VERSION 0.0.1
    LANGUAGES CXX
    DESCRIPTION "Qt based Messenger Client")

set(CMAKE_INCLUDE_CURRENT_DIR ON)

include(cmake/cxx-common.cmake)
include(cmake/qt-common.cmake)

add_subdirectory(Forward)
add_subdirectory(vendor)