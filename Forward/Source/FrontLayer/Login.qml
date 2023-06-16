import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import forward.ui
import forward.client as Client

Page {
    id: loginPage

    Keys.onPressed: (event)=> {
        if (event.key === Qt.Key_Escape)
            mainView.pop()
    }

    Frame {
        anchors.centerIn: parent
        width: 300

        ColumnLayout {
            spacing: 10

            anchors.fill: parent

            ComboBox {
                id: country
                focus: true
                currentIndex: -1
                displayText: currentIndex === -1 ? qsTr("Choose Country...") : currentText
                model: Client.Localisation.countries()

                Layout.fillWidth: true

                onActivated: (index) => {
                    
                }
            }
            TextField {
                id: phoneField
                placeholderText: qsTr("Phone number")
                inputMask: "99-999-9999" 
                inputMethodHints: Qt.ImhDialableCharactersOnly

                Layout.fillWidth: true
            }
            TextField {
                id: passwordField
                placeholderText: qsTr("Password")
                echoMode: TextInput.Password

                Layout.fillWidth: true
            }

            Item { Layout.fillWidth: true }

            Button {
                text: qsTr("Login")

                Layout.fillWidth: true

                onClicked: {
                    var phone = phoneField.text
                    var password = passwordField.text

                    if (phone.length < 2 &
                        password.lenth < 6)
                        return

                    mainView.push("qrc:/imports/forward/Main.qml")
                }
            }

            Item { Layout.fillHeight: true }
        }
    }
}
