import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import forward.ui as Fl
import forward.client as FlClient

ApplicationWindow {
    id: app
    visible: true
    height: 550
    width: 850
    minimumHeight: 300
    minimumWidth: 450

    color: Qt.transparent
    title: "Forward Desktop"
    flags: Qt.FramelessWindowHint | Qt.Window

    property var borderSize: 2

    function showFullSceenOrNormal() {
        if (app.visibility === Window.Windowed)
            app.showFullScreen();
        else if (app.visibility === Window.FullScreen)
            app.showNormal();
        else 
            return
    }   

    function showMaxOrNormal() {
        if (app.visibility === Window.Maximized)
            app.showNormal();
        else if (app.visibility === Window.Windowed)
            app.showMaximized();
        else 
            return
    }

    // client object

    Fl.SystemTray {
        id: appTray

        iconTray: ":/forward/logo_64.png"
        iconMsg: ":/forward/logo_64.png"

        menu: Fl.TrayMenu {
            icon: ":/forward/logo_64.png"

            Fl.TrayMenuItem { 
                text: qsTr("Sing out") 

                onClicked: {

                }
            }
            Fl.TrayMenuItem { 
                text: qsTr("Quit Forward")

                onClicked: {
                    app.close()      //
                }
            }
        }

        onTrayDoubleClicked: {
            app.show()
        }
        onTrayContext: {
            const pos = Fl.CursorPosition.pos()
            menu.popup(pos)
        }
        onMessageClicked: { 
            console.log("msg clicked!")
        }
    }

    Menu {
        id: titleMenu

        MenuItem { 
            text: qsTr("New account")

            onTriggered: {
               
            }
        }
        MenuItem { 
            text: qsTr("Sing out") 

            onTriggered: {
                
            }
        }
        MenuItem { 
            text: qsTr("Quit Forward")
            onTriggered: {
                app.close()    // 
            }
        }   
    }

    header: ToolBar {
        height: 30
        topPadding: borderSize
        leftPadding: borderSize
        rightPadding: borderSize

        // Area for moving app
        MouseArea {
            id: toolBarArea
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            pressAndHoldInterval: 300

            anchors.fill: parent

            property var clickPos: Qt.point(1, 1)
            property var appStartPos: Qt.point(1, 1)

            onPressed: (mouse)=> { 

                if (mouse.buttons & Qt.RightButton)
                    return

                if (app.visibility == Window.Maximized) 
                    app.showNormal(); // BUG: After moving toolbar position sets to center.

                clickPos = Fl.CursorPosition.pos()
                appStartPos = { x: app.x, y: app.y }
            }
            onPositionChanged: (mouse)=> {

                if (mouse.buttons & Qt.RightButton)
                    return

                var newPos = Fl.CursorPosition.pos()
                var delta = { x: newPos.x - clickPos.x, y: newPos.y - clickPos.y }

                app.x = appStartPos.x + delta.x;
                app.y = appStartPos.y + delta.y;
            }
            onClicked: (mouse)=> {
                if (mouse.button == Qt.LeftButton)
                    return

                titleMenu.popup(Fl.CursorPosition.pos())
            }
            onDoubleClicked: (mouse)=> {
                if (mouse.button == Qt.RightButton)
                    return

                showMaxOrNormal()
            }
        }

        // Content
        Item {
            anchors.fill: parent

            RowLayout {
                id: windowButtons
                spacing: 0

                anchors.fill: parent

                Item { Layout.fillWidth: true }

                Item {
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                    RowLayout {
                        anchors.fill: parent
                        Image {
                            id: appIcon
                            asynchronous: true
                            source: "qrc:/forward/logo_16.png"
                            Layout.alignment: Qt.AlignVCenter
                        }
                        Text {
                            id: appTitle
                            text: app.title
                            Layout.alignment: Qt.AlignVCenter
                        }            
                    }
                }

                Item { Layout.fillWidth: true }

                ToolButton {
                    text: "━"
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignRight
                    
                    onClicked: {
                        app.hide()
                        titleMenu.showMessage(app.title, qsTr("Program was minimized into tray.\nClick to open again"))
                    }
                }
                ToolButton {
                    text: "⊠"
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignRight

                    onClicked: showMaxOrNormal()
                }
                ToolButton {
                    text: "✕"
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignRight

                    onClicked: app.close()
                }
            }
        }
    }

    StackView {
        id: mainView
        clip: true
        initialItem: "qrc:/imports/forward/Start.qml"
        anchors.fill: parent
        anchors.leftMargin: borderSize
        anchors.rightMargin: borderSize
        anchors.bottomMargin: borderSize
    }
}