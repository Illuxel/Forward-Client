import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import forward.ui as Fl
import forward.client as FlClient

ApplicationWindow {
    id: app
    visible: true
    width: 850
    height: 550
    minimumWidth: 500
    minimumHeight: 450

    color: Qt.transparent
    title: "Forward Desktop"
    flags: Qt.FramelessWindowHint | Qt.Window

    property var borderSize: 2
    property var edgeOffest: 5

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

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton

        property int edges: 0;

        function setEdges(x, y) {
            edges = 0
            if(x < edgeOffest) edges |= Qt.LeftEdge
            if(x > (width - edgeOffest))  edges |= Qt.RightEdge
            if(y < edgeOffest) edges |= Qt.TopEdge
            if(y > (height - edgeOffest)) edges |= Qt.BottomEdge
        }

        cursorShape: {
            return !containsMouse ? Qt.ArrowCursor:
                   edges == 3 || edges == 12 ? Qt.SizeFDiagCursor :
                   edges == 5 || edges == 10 ? Qt.SizeBDiagCursor :
                   edges & 9 ? Qt.SizeVerCursor :
                   edges & 6 ? Qt.SizeHorCursor : Qt.ArrowCursor;
        }

        onPositionChanged: (mouse)=> setEdges(mouse.x, mouse.y)
        onPressed: (mouse)=> {
            setEdges(mouse.x, mouse.y)
            if(edges && containsMouse) 
                startSystemResize(edges)
        }
    }

    Fl.SystemTray {
        id: appTray

        iconTray: ":/forward/logo_64.png"
        iconMsg: ":/forward/logo_64.png"

        menu: Fl.TrayMenu {
            title: app.title
            icon: ":/forward/logo_64.png"

            Fl.TrayMenuItem { 
                text: qsTr("Sing out") 

                onClicked: {}
            }
            Fl.TrayMenuItem { 
                text: qsTr("Quit Forward")

                onClicked: app.close()     
            }
        }

        onMessageClicked: app.show()

        onTrayContext: menu.popup(Fl.CursorPosition.pos())
        onTrayDoubleClicked: app.show()
    }

    Menu {
        id: titleMenu
        MenuItem { 
            text: qsTr("New account")
            onTriggered: {}
        } 
    }

    header: Fl.TitleBar {

        title: app.title
        icon: "qrc:/forward/logo_16.png"
        
        height: 30
        border: borderSize

        onBarDragged: (active)=> {
            if (active) app.startSystemMove() 
        }

        onBarClicked: (mouse)=> {
            if (mouse.button == Qt.LeftButton)
                return
            titleMenu.popup(Fl.CursorPosition.pos())
        }
        onBarDoubleClicked: (mouse)=> {
            if (mouse.button == Qt.RightButton)
                return
            showMaxOrNormal()
        }

        onHideBtnClicked: {
            app.hide()
            appTray.showMessage(app.title, qsTr("Program was minimized into tray. Click to open again"))
        }
        onMaximizeBtnClicked: showMaxOrNormal()
        onCloseBtnClicked: app.close()
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