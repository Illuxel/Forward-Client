import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import forward.ui as Client
import forward.client as Client

Page {
    id: mainPage

    RowLayout {
        spacing: 0
        anchors.fill: parent

        ToolBar {

            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.maximumWidth: 64

            RowLayout {
                anchors.fill: parent

                ToolButton {

                    icon.width: 32
                    icon.height: 32
                    icon.source: "qrc:/forward/menu.svg"

                    Material.roundedScale: Material.NotRounded

                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignTop | Qt.AlignVCenter
                     
                    onClicked: drawer.open()
                }
            }
        }

        ColumnLayout {

            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.maximumWidth: 350

            Client.ChatList {
                id: chatList
            
                clip: true
                interactive: false
                spacing: 0

                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.maximumWidth: 350

                model: ListModel {
                    ListElement {
                        userName: "Illia"
                        userAvatar: "qrc:/forward/friend.svg"
                        lastMessage: "Hello from Forward! Testing text really big text to make overflow..."
                        timestamp: "12:30 PM"
                    }
                    ListElement {
                        userName: "Roman"
                        userAvatar: "qrc:/forward/friend.svg"
                        lastMessage: "Do you want play games!?"
                        timestamp: "15:10 PM"
                    }
                    ListElement {
                        userName: "Illia 2"
                        userAvatar: "qrc:/forward/friend.svg"
                        lastMessage: "Testing"
                        timestamp: "8:30 AM"
                    }
                }

                onItemClicked: index => {
                    console.log(index)

                    conversationPage.push(
                        'qrc:/imports/forward/Conversation.qml',  
                        { 
                            inConversationWith: chatList.model.get(index).userName 
                        }
                    )
                }
            }
        }

        StackView {
            id: conversationPage

            clip: true

            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

    Drawer {
        id: drawer

        width: app.width / 3
        height: app.height

        background: Pane {

            Material.accent: Material.Pink
        }

        ListView {
            id: drawerListView
            spacing: 0
            clip: true
            interactive: false

            anchors.fill: parent

            header: Pane {
                id: userDataArea
                width: parent.width
                height: 150

                Material.background: Material.Indigo

                ColumnLayout {
                    spacing: 5

                    anchors.fill: parent
                
                    RowLayout {
                        spacing: 10

                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignTop

                        Image {
                            id: logo
                            width: 64
                            height: 64
                            source: "qrc:/forward/friend.svg"
                            
                            fillMode: Image.PreserveAspectFit
                            Layout.alignment: Qt.AlignCenter
                        }

                        Label {
                            text: "Test"
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignCenter
                        }
                    }
                }   

                MenuSeparator {
                    width: parent.width
                    anchors.verticalCenter: parent.bottom
                    visible: !drawerListView.atYBeginning
                }
            }

            model: ListModel {
                ListElement {
                    option: qsTr("Friend List")
                    iconSource: "qrc:/forward/friend.svg"
                    // dialog: friendListDialog
                }
                ListElement {
                    option: qsTr("Add Friend")
                    iconSource: "qrc:/forward/friend_add.svg"
                    // dialog: addFriendDialog
                }
                ListElement {
                    option: qsTr("Create Group")
                    iconSource: "qrc:/forward/group_add.svg"
                    // dialog: addGroupDialog
                }
            }

            delegate: ItemDelegate {
                text: option

                width: parent.width
                icon.width: 32
                icon.height: 32
                icon.source: iconSource

                display: AbstractButton.TextBesideIcon

                onClicked: {
                    
                    if (index === 0)
                        friendListDialog.open()

                    if (index === 1)
                        addFriendDialog.open()

                    if (index === 2)
                        addGroupDialog.open()
                }
            }

            footer: ItemDelegate {
                text: qsTr("Settings")

                width: parent.width
                icon.width: 32
                icon.height: 32
                icon.source: "qrc:/forward/settings.svg"
                
                display: AbstractButton.TextBesideIcon

                MenuSeparator {
                    parent: parent
                    width: parent.width
                    anchors.verticalCenter: parent.top
                }

                onClicked: settingsDialog.open()
            }
            
            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }

    Dialog {
        id: settingsDialog
    
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2

        width: parent.width * 0.4

        parent: Overlay.overlay

        focus: true
        modal: true
        standardButtons: Dialog.Ok | Dialog.Cancel

        ColumnLayout {
            id: layout

            spacing: 20
            anchors.fill: parent

            ComboBox {
                id: language
                focus: true
                currentIndex: -1
                model: Client.Localization.localeList()

                Layout.fillWidth: true
                Layout.alignment: Qt.AlignTop

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

                Layout.fillWidth: true
                Layout.alignment: Qt.AlignTop

                model: Client.Style.supportedStyles()

                Component.onCompleted: {
                    const styleName = settings.valueAt("style")
                    const index = indexOfValue(styleName)

                    currentIndex = index
                }
                onActivated: (index) => {
                    const theme = textAt(index)

                    settings.addValue("style", theme)
                    restartDialog.open()
                }
            }

            Item { Layout.fillHeight: true }
        }

        onAccepted: settings.save()
    }

    Client.DialogInfo {
        id: restartDialog

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2

        title: qsTr("Info")
        message: qsTr("Style will be changed after restarting application")
    }

    Dialog {
        id: friendListDialog
    
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2

        width: 400
        height: parent.height * 0.5

        parent: Overlay.overlay

        focus: true
        modal: true
        standardButtons: Dialog.Ok | Dialog.Cancel

        ListView {
            id: friendList

            model: 10

            delegate: ItemDelegate {

                width: friendList.width
                height: 64

                RowLayout {
                    id: row
                    spacing: 8
                    
                    anchors.fill: parent

                    Image { 
                        id: avatar

                        width: 64
                        height: 64

                        source: "qrc:/forward/friend.svg" //userAvatar 

                        fillMode: Image.PreserveAspectFit

                        Layout.minimumWidth: 64
                        Layout.margins: 5
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    }

                    Label { 
                        clip: true
                        text: "userName" 
                        elide: Text.ElideRight
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignLeft
                    }
                }

                onClicked: {
                    
                }
            }
        }
    }

    Dialog {
        id: addFriendDialog
    
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2

        width: parent.width * 0.4
        height: parent.height * 0.5

        parent: Overlay.overlay

        focus: true
        modal: true
        standardButtons: Dialog.Ok | Dialog.Cancel

        ColumnLayout {
            spacing: 0
            anchors.fill: parent
            
            Label {
                text: qsTr("Enter friend tag to add to friend list")
                Layout.fillWidth: true
            } 

            TextField  {
                id: friendTag
                placeholderText: "Enter here..."
                Layout.fillWidth: true
            }
        }

        onAccepted: {
            var currentDate = new Date();
            var currentTime = currentDate.toLocaleTimeString();

            chatList.model.append({
                                      userName: friendTag.text,
                                      userAvatar: "qrc:/forward/friend.svg",
                                      lastMessage: "Empty...",
                                      timestamp: currentTime
                                  })
        }
    }

    Dialog {
        id: addGroupDialog
    
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2

        width: parent.width * 0.4
        height: parent.height * 0.5

        parent: Overlay.overlay

        focus: true
        modal: true
        standardButtons: Dialog.Ok | Dialog.Cancel

        ColumnLayout {
            spacing: 0
            anchors.fill: parent
                  
            Label {
                text: qsTr("Enter group name to create it")
                Layout.fillWidth: true
            }

            TextField  {
                id: groupName
                placeholderText: "Enter here..."
                Layout.fillWidth: true
            }
        }

        onAccepted: {

            var currentDate = new Date();
            var currentTime = currentDate.toLocaleTimeString();

            chatList.model.append({
                                      userName: groupName.text,
                                      userAvatar: "qrc:/forward/group_add.svg",
                                      lastMessage: "Empty...",
                                      timestamp: currentTime
                                  })
        }
    }
}   
