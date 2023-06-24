import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import forward.ui as Client
import forward.client as Client

ApplicationWindow {
    id: app
    visible: true
    width: 850
    height: 550
    minimumWidth: 500
    minimumHeight: 450

    title: "Forward Desktop"

    Material.theme: Material.Dark
    Material.accent: Material.Purple

    //! [orientation]
    readonly property bool inPortrait: app.width < app.height
    //! [orientation]

    // client object

    Client.Settings {
        id: settings
    }

    Client.SystemTray {
        id: appTray

        iconTray: "qrc:/forward/logo.ico"
        iconMsg: "qrc:/forward/logo.ico"

        menu: Client.TrayMenu {
            title: app.title
            icon: "qrc:/forward/logo.ico"

            Client.TrayMenuItem { 
                text: qsTr("Sing out") 

                onClicked: {}
            }
            Client.TrayMenuItem { 
                text: qsTr("Quit Forward")

                onClicked: app.close()     
            }
        }

        onMessageClicked: app.show()

        onTrayContext: menu.popup(Client.CursorPosition.pos())
        onTrayDoubleClicked: app.show()
    }

    StackView {
        id: mainView

        initialItem: "qrc:/imports/forward/Start.qml"
        
        anchors.fill: parent
    }

    Component.onCompleted: {

        var lang;

        if (settings.isValueAt("lang")) {
        
            lang = settings.valueAt("lang")

        } else {

            lang = Client.Localization.currentLocale()

            settings.addValue("lang", lang)
            settings.save()
        }

        console.log("Lang change to " + lang)

        Client.Localization.changeLocale(lang)
    }
}
