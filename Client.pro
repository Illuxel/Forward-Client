TEMPLATE = app
TARGET = Client

QT += core network qml quick widgets

CONFIG += debug
CONFIG -= flat

HEADERS += \

SOURCES += \
    src/back/main.cpp \

RESOURCES += \
    src/front/client.qrc \

DISTFILES += \
