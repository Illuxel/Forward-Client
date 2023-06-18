import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import forward.ui as Client
import forward.client as Client

Page {
    id: mainPage

    RowLayout {
        spacing: 1
        anchors.fill: parent

        Client.ChatList {
            id: chatList
        
            clip: true
            spacing: 2

            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignLeft

            model: ListModel {
                ListElement {
                    userName: "Illia"
                    userAvatar: "qrc:/forward/logo_16.png"
                    lastMessage: "Hello from Forward!"
                }
                ListElement {
                    userName: "Roman"
                    userAvatar: "qrc:/forward/logo_16.png"
                    lastMessage: "Do you want play games!?"
                }
            }
        }

        StackView {
            id: msgPages

            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignRight

            pushEnter: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 0
                    to:1
                    duration: 200
                }
            }
            pushExit: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 1
                    to:0
                    duration: 200
                }
            }
            popEnter: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 0
                    to:1
                    duration: 200
                }
            }
            popExit: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 1
                    to:0
                    duration: 200
                }
            }

        }
    }

    Drawer {
        id: drawer

        x: app.borderSize + 100
        y: app.menuBar.height
        width: app.width * 0.3
        height: app.height - app.menuBar.height - app.borderSize

        ListView {
            id: listView

            spacing: 10

            anchors.fill: parent

            headerPositioning: ListView.OverlayHeader
            header: Pane {
                id: header
                width: parent.width

                contentHeight: logo.height

                Image {
                    id: logo
                    width: parent.width
                    source: "" // image for avatar
                    fillMode: implicitWidth > width ? Image.PreserveAspectFit : Image.Pad
                }

                MenuSeparator {
                    parent: header
                    width: parent.width
                    anchors.verticalCenter: parent.bottom
                    visible: !listView.atYBeginning
                }
            }

            footer: ItemDelegate {
                id: footer
                text: qsTr("Footer")
                width: parent.width

                MenuSeparator {
                    parent: footer
                    width: parent.width
                    anchors.verticalCenter: parent.top
                }
            }
            
            delegate: ItemDelegate {
                text: qsTr("Title %1").arg(index + 1)
                width: listView.width
            }

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }
}   