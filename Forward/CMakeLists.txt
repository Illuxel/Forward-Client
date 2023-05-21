set(APP_RESOURCES 
    Resources/qrc/app.qrc
)
set(APP_QML_SOURCE
    Source/FrontLayer/App.qml
    Source/FrontLayer/Main.qml
    Source/FrontLayer/Login.qml
)
set(APP_SOURCE
    Source/LogicLayer/main.cpp
)

add_subdirectory(ForwardUI)

qt_add_executable(Forward WIN32
    ${APP_SOURCE} 
    ${APP_RESOURCES}
)

qt_add_qml_module(Forward URI Forward VERSION 0.1
RESOURCE_PREFIX 
    "/app/pages"
QML_FILES 
    ${APP_QML_SOURCE}
RESOURCES
    ${APP_RESOURCES}
NO_PLUGIN
)

target_link_libraries(Forward
PRIVATE 
    Qt6::Core
    Qt6::Gui
    Qt6::Quick
    Qt6::Qml
)