import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import forward.ui as Client
import forward.client as Client

Page {
	id: loginPage

	Keys.onPressed: event => {
		if (event.key === Qt.Key_Escape)
			mainView.pop();
	}

	GroupBox {

		title: qsTr("Please enter the credentials")

        width: app.width * 0.4
		anchors.centerIn: parent

		ColumnLayout {
			spacing: 10

			anchors.fill: parent

			ComboBox {
				id: country
				focus: true
				currentIndex: -1
				displayText: currentIndex === -1 ? qsTr("Choose Country...") : currentText
				model: Client.Localization.countryList()

				Layout.fillWidth: true

				onActivated: index => {}
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
						inputMask = "99-999-9999";
				}
			}

			TextField {
				id: passwordField
				placeholderText: qsTr("Password")
				echoMode: TextInput.Password
				inputMethodHints: Qt.ImhSensitiveData | Qt.ImhHiddenText

				Layout.fillWidth: true
			}

			Button {
				text: qsTr("Create account")
				
				Material.roundedScale: Material.ExtraSmallScale
				Layout.fillWidth: true

				onClicked: {
					const email = emailField.text;
					const phone = phoneField.text;
					const password = passwordField.text;

					// Client.

					mainView.push("qrc:/imports/forward/Main.qml");
				}

				Client.DialogInfo {
					id: badInput
					title: qsTr("Error")
					message: qsTr("Error")
				}
			}
		}
	}
}
