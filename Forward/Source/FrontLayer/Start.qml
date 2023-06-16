import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import forward.ui as Client
import forward.client as Client

Page {
    id: startPage

    Frame {
        anchors.centerIn: parent
        width: 300

        ColumnLayout {
            spacing: 10
          
            anchors.fill: parent
            
            // Language
            ComboBox {
                id: language
                focus: true
                currentIndex: -1
                displayText: currentIndex === -1 ? qsTr("Select Language...") : currentText
                model: FlClient.Localisation.locales()

                Layout.fillWidth: true

                onActivated: (index) => {
                    
                }
            }
            // Theme
            ComboBox {
                id: theme
                currentIndex: -1
                displayText: currentIndex === -1 ? qsTr("Select Theme...") : currentText

                Layout.fillWidth: true

                onActivated: (index) => {

                }
            }

            Item { Layout.fillWidth: true }

            Button {
                text: qsTr("Start messaging")

                height: 200
                Layout.fillWidth: true

                onClicked: {
                    mainView.push("qrc:/imports/forward/Login.qml")
                }
            }
        }
    }


}   