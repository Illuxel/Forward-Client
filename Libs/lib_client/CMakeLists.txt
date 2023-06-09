qt6_add_library(ForwardClientLib STATIC)

message(STATUS "Building Forward.Client.Lib")

set_target_properties(ForwardClientLib PROPERTIES AUTOMOC ON)
target_link_libraries(ForwardClientLib 
PUBLIC 
    Qt6::Core 
    Qt6::Sql
    Qt6::Qml
)
target_include_directories(ForwardClientLib
PUBLIC 
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/forward/client>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/forward/client>
)

set(FLCLIENT_SOURCE 
    forward/client/Style.cpp
    forward/client/Style.hpp
    forward/client/Localisation.cpp
    forward/client/Localisation.hpp
)

qt6_add_qml_module(ForwardClientLib
    URI forward.client
    RESOURCE_PREFIX /imports
)
