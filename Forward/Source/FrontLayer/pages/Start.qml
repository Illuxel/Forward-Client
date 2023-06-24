import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import forward.ui as Client
import forward.client as Client

Page {
    id: startPage

    GroupBox {

        title: qsTr("Choose language and style")

        width: app.width * 0.4
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
                    const lang = settings.valueAt("lang", Client.Localization.currentLocale())
                    const index = indexOfValue(lang)

                    currentIndex = index
                }
                onActivated: (index) => {
                    const lang = textAt(index)
                    settings.addValue("lang", lang)
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
                    const styleName = settings.valueAt("style")
                    const index = indexOfValue(styleName)

                    currentIndex = index
                }
                onActivated: (index) => {
                    const theme = textAt(index)

                    settings.addValue("style", theme)
                    infoDialog.open()
                }
                
                Client.DialogInfo {
                    id: infoDialog

                    title: qsTr("Info")
                    message: qsTr("Style will be changed after restarting application")
                }
            }

            Button {
                text: qsTr("Start messaging")

                Material.roundedScale: Material.ExtraSmallScale
                Layout.fillWidth: true

                onClicked: {
                    settings.save()

                    mainView.push("qrc:/imports/forward/Login.qml")
                }
            }
        }
    }
}   