set(FORWARD_RESOURCE
    Resources/qrc/forward.qrc
    Resources/qrc/pages.qrc
)
set(FORWARD_QML_SOURCE
    Source/FrontLayer/App.qml
    Source/FrontLayer/Main.qml
    Source/FrontLayer/Login.qml
)
set(FORWARD_SOURCE
    Source/LogicLayer/main.cpp
)

qt_add_executable(Forward WIN32
    ${FORWARD_RESOURCE}
    ${FORWARD_SOURCE}
)

target_link_libraries(Forward
PRIVATE 
    Forward.UI
)