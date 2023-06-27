cmake_minimum_required(VERSION 3.24 FATAL_ERROR)

project(ForwardDesktop
    VERSION 0.0.4
    LANGUAGES CXX
    DESCRIPTION "Forward Desktop Client based on Qt"
)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

if (NOT DEFINED CMAKE_INSTALL_LIBDIR)
  set(CMAKE_INSTALL_LIBDIR "lib")
endif()
if (NOT DEFINED CMAKE_INSTALL_BINDIR)
  set(CMAKE_INSTALL_BINDIR "bin")
endif()
if (NOT DEFINED CMAKE_INSTALL_INCLUDEDIR)
  set(CMAKE_INSTALL_INCLUDEDIR "include")
endif()

if(ANDROID)
    # Set Android-specific build settings

    # Set the target ABI (e.g., armeabi-v7a, arm64-v8a, x86, x86_64)
    set(CMAKE_ANDROID_ARCH_ABI armeabi-v7a)

    # Set the STL type (e.g., c++_shared, c++_static)
    set(CMAKE_ANDROID_STL_TYPE c++_shared)

    # Set the minimum required Android API level
    set(CMAKE_ANDROID_API_MIN 21)

    # Set the Android platform
    set(CMAKE_ANDROID_PLATFORM android-21)

    # Set the Android NDK directory
    set(ANDROID_NDK <path_to_android_ndk>)

    # Set the Android toolchain file
    set(CMAKE_TOOLCHAIN_FILE ${ANDROID_NDK}/build/cmake/android.toolchain.cmake)

    set_target_properties(MyQtApp PROPERTIES
        QT_ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}"
        QT_ANDROID_APK_DIR "${CMAKE_CURRENT_BINARY_DIR}/android-build"
        QT_ANDROID_LIBDIR_HINTS "${CMAKE_CURRENT_BINARY_DIR}/android-build/libs/${ANDROID_ABI}"
    )
elseif(WIN32)
elseif(UNIX)
endif()

if (NOT Qt6)
    find_package(Qt6 COMPONENTS Core Gui Widgets Qml Quick QuickControls2 LinguistTools REQUIRED)
endif()

include(cmake/cxx-common.cmake)
include(CMAKE/path.cmake)

add_subdirectory(Libs)
add_subdirectory(Forward)