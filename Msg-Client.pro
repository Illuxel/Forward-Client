TARGET = Client

QT += core network qml quick widgets

CONFIG += qmltypes metatypes c++17 ordered
CONFIG -= flat

Release:DESTDIR = ../Compiles/Msg-Client/2.0/Release
Release:OBJECTS_DIR = Build/Release/obj/
Release:MOC_DIR = Build/Release/moc/
Release:RCC_DIR = Build/Release/rcc/
Release:UI_DIR = Build/Release/ui/

Debug:DESTDIR = ../Compiles/Msg-Client/2.0/Debug
Debug:OBJECTS_DIR = Build/Debug/obj/
Debug:MOC_DIR = Build/Debug/moc/
Debug:RCC_DIR = Build/Debug/rcc/
Debug:UI_DIR = Build/Debug/ui/

SOURCES += main.cpp 
HEADERS += 

RESOURCES = rc/images.qrc \ 
    rc/pages.qrc

QML_IMPORT_NAME = Client
QML_IMPORT_VERSION = 1.0.0