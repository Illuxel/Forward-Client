import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import forward.ui as Client
import forward.client as Client

Page {
    id: loginPage

    Keys.onPressed: (event)=> {
        if (event.key === Qt.Key_Escape)
            mainView.pop()
    }

    GroupBox {
        anchors.centerIn: parent
        width: 300

        title: qsTr("Please enter the credentials")

        ColumnLayout {
            spacing: 15

            anchors.fill: parent

            ComboBox {
                id: country
                focus: true
                currentIndex: -1
                displayText: currentIndex === -1 ? qsTr("Choose Country...") : currentText
                model: Client.Localization.countryList()

                Layout.fillWidth: true

                onActivated: (index) => {
                    
                }
            }
            TextField {
                id: emailField
                placeholderText: qsTr("Email adress")

                Layout.fillWidth: true

                onTextEdited: {

                    if (inputMask === "")
                        inputMask = "99-999-9999"
                    
                }
            }
            TextField {
                id: phoneField
                placeholderText: qsTr("Phone number")
                
                inputMethodHints: Qt.ImhDialableCharactersOnly

                Layout.fillWidth: true

                onTextEdited: {

                    if (inputMask === "")
                        inputMask = "99-999-9999"
                    

                }
            }
            TextField {
                id: passwordField
                placeholderText: qsTr("Password")
                echoMode: TextInput.Password
                inputMethodHints: Qt.ImhSensitiveData | Qt.ImhHiddenText

                Layout.fillWidth: true
            }

            Item { Layout.fillWidth: true }

            Button {
                text: qsTr("Create account")

                Layout.fillWidth: true

                onClicked: {
                    const email = emailField.text
                    const phone = phoneField.text
                    const password = passwordField.text

                    console.log(phone.length)
                    console.log(email.length)
                    console.log(password.length)

                    mainView.push("qrc:/imports/forward/Main.qml")
                }

                Client.DialogInfo {
                    id: badInput
                    title: qsTr("Error")
                    message: qsTr("Error")
                }
            }

            Item { Layout.fillHeight: true }
        }
    }
}
