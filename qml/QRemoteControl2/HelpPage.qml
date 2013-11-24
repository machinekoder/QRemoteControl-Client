// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0
import "MyComponents/"

Rectangle {
    signal continueClicked

    id: rectangle1
    width: 360
    height: 640
    color: "#00000000"

    Item {
        id: wrapper
        anchors.fill: parent

        Item {
            id: rotator
            rotation:       master.screenRotation
            width:          ((rotation === 0) || (rotation === 180)) ? parent.width : parent.height
            height:         ((rotation === 0) || (rotation === 180)) ? parent.height : parent.width
            anchors.centerIn: parent

            Behavior on width {
                             enabled: master.state == "helpState"
                             NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                         }
            Behavior on height {
                             enabled: master.state == "helpState"
                             NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                         }

            Flickable {
                id: flickable
                flickableDirection: Flickable.VerticalFlick
                clip: true
                contentWidth: parent.width - master.generalMargin*6
                contentHeight: aboutContainer.height + moreText.height + 60

                anchors {
                    left: parent.left
                    leftMargin: master.generalMargin*2
                    rightMargin: master.generalMargin*2
                    right: parent.right
                    top: parent.top
                    topMargin: master.generalMargin*2
                    bottom: exitButton.top
                    bottomMargin: master.generalMargin
                }

                Item {
                    width: parent.width

                    id: aboutContainer

                    Text {
                        text: qsTr("Quick Guide") + client.emptyString
                        id: aboutText
                        color: theme.primaryTextColor
                        anchors {
                            top: parent.top
                            horizontalCenter: parent.horizontalCenter
                        }

                        font {
                            pixelSize: theme.buttonFontSize
                            bold: theme.buttonFontBold
                             }
                    }
                }

                Text {
                    id: moreText
                    text: "<html><head><style>a:link{color:" + theme.linkTextColor + "} a:visited{color:" + theme.linkTextColor + "}</style></head><body>" +
                          qsTr("<br><b>Before Starting</b><br>") +
                          qsTr("Make shure you have the server software installed on the computer you want to remote control. You can download the software at: <a href=\"http://qremote.org/download.php#Download\">qremote.org</a> <br> <br>") +
                          qsTr("<b>Connecting</b><br>") +
                          qsTr("- Connect your smart phone and your computer to a wireless network. <br>") +
                          qsTr("- Start the server software on your computer.<br>") +
                          qsTr("- Click \"Search Servers\" on you smart phone to discover the servers on your network.<br>") +
                          qsTr("- Sometimes the client can not find the server automatically, you have to type in the IP-address manually in the advanced tab.<br>") +
                          qsTr("- Click on the server you want to use.<br>") +
                          qsTr("- Start using QRemoteControl.<br>") +
                          qsTr("- If the connection does not work, try to open port 5487 for UDP and TCP protocol on your firewall.<br>") + client.emptyString + "</body></html>"

                    anchors {
                        top: aboutContainer.bottom
                        topMargin: 20
                        horizontalCenter: parent.horizontalCenter
                    }
                    wrapMode: Text.WordWrap
                    width: parent.width
                    textFormat: Text.RichText
                    color: theme.primaryTextColor

                    font {
                        pixelSize: theme.labelFontSize//aboutPage.width * 0.025
                    }

                    onLinkActivated : Qt.openUrlExternally(link);
                }
            }

            Button {
                    id: exitButton
                    height: master.buttonHeight * 0.8
                    text: qsTr("Continue") + client.emptyString
                    anchors.right: parent.right
                    anchors.rightMargin: master.generalMargin
                    anchors.left: parent.left
                    anchors.leftMargin: master.generalMargin
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: master.generalMargin
                    icon: ""
                    onClicked: continueClicked()
                }
        }
    }
}

