import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ApplicationWindow {
    id: app
    visible: true
    title: "Forward Desktop"

    height: 350
    width: 650
    minimumHeight: 300
    minimumWidth: 450

    flags: Qt.FramelessWindowHint | Qt.Window

    header: ToolBar {
        height: 30
        RowLayout {
            anchors.fill: parent
            spacing: 0

            Item { Layout.fillWidth: true }

            Item { 
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                RowLayout {
                    anchors.fill: parent
                    Image {
                        asynchronous: true
                        source: "qrc:/forward/logo_16.png"
                        Layout.alignment: Qt.AlignVCenter
                    }
                    Text {
                        text: app.title
                        Layout.alignment: Qt.AlignVCenter
                    }            
                }    
            }

            Item { Layout.fillWidth: true }

            ToolButton {
                text: "━"
                // onClicked: app.hide()
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignRight
            }
            ToolButton {
                text: "□"
                // onClicked:
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignRight
            }
            ToolButton {
                text: "✕"
                onClicked: app.close()
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignRight
            }
        }
    }

    StackView {
        id: mainView
        anchors.fill: parent

        initialItem: "qrc:/forward/pages/Login.qml"
    }
}