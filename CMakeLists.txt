cmake_minimum_required(VERSION 3.24 FATAL_ERROR)

project(ForwardDesktop
    VERSION 0.0.1
    LANGUAGES CXX
    DESCRIPTION "Forward Desktop Client based on Qt")

set(CMAKE_INCLUDE_CURRENT_DIR ON)

include(cmake/cxx-common.cmake)
include(cmake/qt-common.cmake)

include(CMAKE/path.cmake)

add_subdirectory(Libs)
add_subdirectory(Forward)