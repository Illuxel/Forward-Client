import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import forward.ui as Client
import forward.client as Client

Page {
    id: startPage

    Frame {
        width: 300
        anchors.centerIn: parent

        ColumnLayout {
            spacing: 10
          
            anchors.fill: parent
            // Language
            ComboBox {
                id: language
                focus: true
                currentIndex: -1
                displayText: currentIndex === -1 ? qsTr("Select Language...") : currentText
                model: Client.Localization.localeList()

                Layout.fillWidth: true

                Component.onCompleted: {
                    const lang = appSettings.valueAt("lang", Client.Localization.currentLocale())
                    const index = indexOfValue(lang)

                    console.log("Current language: " + lang)
                    
                    currentIndex = index
                }
                onActivated: (index) => {
                    const lang = textAt(index)

                    appSettings.addValue("lang", lang)
                    appSettings.save()

                    Client.Localization.changeLocale(lang)
                }
            }
            // Theme
            ComboBox {
                id: theme
                displayText: currentIndex === -1 ? qsTr("Select Theme...") : currentText

                Layout.fillWidth: true

                model: Client.Style.supportedStyles()

                Component.onCompleted: {
                    const styleName = appSettings.valueAt("style")
                    const index = indexOfValue(styleName)

                    console.log("Current style: " + styleName)
                    
                    currentIndex = index
                }
                onActivated: (index) => {
                    const theme = textAt(index)

                    appSettings.addValue("style", theme)
                    appSettings.save()

                    infoDialog.open()
                }
                
                Client.DialogInfo {
                    id: infoDialog

                    title: qsTr("Info")
                    message: qsTr("Style will be changed after restarting application")
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