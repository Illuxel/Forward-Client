import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import forward.ui as Client

Page {
    property string inConversationWith

    Keys.onPressed: event => {
		if (event.key === Qt.Key_Escape)
			conversationPage.pop(conversationPage.currentItem)
	}

    header: ToolBar {

        RowLayout {
            spacing: 0
            anchors.fill: parent
            
            ToolButton {

                icon.source: "qrc:/forward/back.svg"

                Layout.alignment: Qt.AlignLeft

                onClicked: conversationPage.clear()
            }

            Label {
                id: chatTitle
                text: inConversationWith
                font.pixelSize: 26
                elide: Text.ElideRight

                Layout.fillWidth: true
                Layout.alignment: Qt.AlignCenter
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        
        Client.MessageList {
            id: messageList

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.margins: pane.leftPadding + messageField.leftPadding

            displayMarginBeginning: 20
            displayMarginEnd: 20
            verticalLayoutDirection: ListView.TopToBottom

            spacing: 0

            model: ListModel {
                ListElement {
                    userAvatar: "qrc:/forward/friend.svg"
                    userName: "Illia"
                    message: "Привіт, як в тебе справи?"
                    timestamp: "12:20:30 12.20.12"
                }
                ListElement {
                    userAvatar: "qrc:/forward/friend.svg"
                    userName: "Me"
                    message: "Ку, нормально. А в тебе як?"
                    timestamp: "12:20:30 12.20.12"
                }
                ListElement {
                    userAvatar: "qrc:/forward/friend.svg"
                    userName: "Illia"
                    message: "Теж все COOL!"
                    timestamp: "12:20:30 12.20.12"
                }
                ListElement {
                    userAvatar: "qrc:/forward/friend.svg"
                    userName: "Illia"
                    message: "Го на вулицю?"
                    timestamp: "12:20:30 12.20.12"
                }
                ListElement {
                    userAvatar: "qrc:/forward/friend.svg"
                    userName: "Me"
                    message: "Так, пішли гуляти!"
                    timestamp: "12:20:30 12.20.12"
                }
            }

            ScrollBar.vertical: ScrollBar {}
        }

        Pane {
            id: pane
            Layout.fillWidth: true

            RowLayout {
                width: parent.width

                TextArea {
                    id: messageField
                    Layout.fillWidth: true
                    placeholderText: qsTr("Send message here...")
                    wrapMode: TextArea.Wrap
                }

                Button {
                    id: sendButton
                    text: qsTr("Send")
                    enabled: messageField.length > 0
                    Material.roundedScale: Material.ExtraSmallScale
                    onClicked: {

                        var currentDate = new Date();
                        var currentTime = currentDate.toLocaleTimeString();

                        messageList.model.append({
                                               userAvatar: "qrc:/forward/friend.svg",
                                               userName: "Me",
                                               message: messageField.text,
                                               timestamp: currentTime
                                           })

                        // messageList.model.sendMessage(inConversationWith, messageField.text);
                        messageField.text = "";
                    }
                }
            }
        }
    }

}
