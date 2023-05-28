import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import forward.ui as Fl
import forward.client as FlClient

Page {
    id: mainPage

    Row {
        Button {
            text: "Button"
            height: 100
            width: 150

            onClicked: { 
                drawer.open()
            }
        }
        Button {
            text: "Message"
            height: 100
            width: 150

            onClicked: { 
                appTray.showMessage("Title", "Hello world!")
            }
        }
    }

    RowLayout {
        anchors.fill: parent
    }

    Drawer {
        id: drawer
        dim: false;

        y: parent.y - app.header.y
        x: app.borderSize
        height: parent.height - app.header.height
        width: parent.width * 0.3 - app.borderSize * 2

        leftInset: app.borderSize
        rightInset: app.borderSize
        bottomInset: app.borderSize
    }
}   