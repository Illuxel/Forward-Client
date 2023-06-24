import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import forward.ui as Client
import forward.client as Client

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

    //! [orientation]
    readonly property bool inPortrait: app.width < app.height
    //! [orientation]

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

    Client.Settings {
        id: appSettings
    }

    MouseArea {
        anchors.fill: parent
        anchors.top: app.menuBar
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

    Client.SystemTray {
        id: appTray

        iconTray: ":/forward/logo_64.png"
        iconMsg: ":/forward/logo_64.png"

        menu: Client.TrayMenu {
            title: app.title
            icon: ":/forward/logo_64.png"

            Client.TrayMenuItem { 
                text: qsTr("Sing out") 

                onClicked: {}
            }
            Client.TrayMenuItem { 
                text: qsTr("Quit Forward")

                onClicked: app.close()     
            }
        }

        onMessageClicked: app.show()

        onTrayContext: menu.popup(Client.CursorPosition.pos())
        onTrayDoubleClicked: app.show()
    }

    Menu {
        id: titleMenu
        MenuItem { 
            text: qsTr("New account")
            onTriggered: {}
        } 
    }

    menuBar: Client.TitleBar {
        id: appTitleBar
        height: 30
        border: borderSize

        title: app.title
        icon: "qrc:/forward/logo_16.png"

        onBarDragged: (active)=> {
            if (active) app.startSystemMove() 
        }

        onBarClicked: (mouse)=> {
            if (mouse.button == Qt.LeftButton)
                return
            titleMenu.popup(Client.CursorPosition.pos())
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

        initialItem: "qrc:/imports/forward/Start.qml"
        
        anchors.fill: parent
        anchors.leftMargin: borderSize
        anchors.rightMargin: borderSize
        anchors.bottomMargin: borderSize
    }

    Component.onCompleted: {

        var lang;

        if (appSettings.isValueAt("lang")) {
        
            lang = appSettings.valueAt("lang")

        } else {

            lang = Client.Localization.currentLocale()

            appSettings.addValue("lang", lang)
            appSettings.save()
        }

        console.log("Lang change to " + lang)

        Client.Localization.changeLocale(lang)
    }
}