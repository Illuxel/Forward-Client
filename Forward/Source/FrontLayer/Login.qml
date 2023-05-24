import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Page {
    id: loginPage

    ColumnLayout {
        anchors.centerIn: parent
        height: 450 
        width: 300
        spacing: 10

        Item { Layout.fillHeight: true }

        ComboBox {
            id: country
            model: ["Ukraine", "Amerima", "Black pencil"]

            Layout.fillWidth: true
        }
        TextField {
            id: usernameField
            placeholderText: "Phone number"
            inputMask: "99-999-9999"  // Формат ввода для номера телефона
            inputMethodHints: Qt.ImhDialableCharactersOnly

            Layout.fillWidth: true
        }
        TextField {
            id: passwordField
            placeholderText: "Password"
            echoMode: TextInput.Password

            Layout.fillWidth: true
        }
        Button {
            text: "Login"
            Layout.fillWidth: true
            onClicked: {
                var username = usernameField.text
                var password = passwordField.text
                console.log("Username: " + username)
                console.log("Password: " + password)

                mainView.push("qrc:/forward/pages/Main.qml")
            }
        }

        Item { Layout.fillHeight: true }
    }
}
