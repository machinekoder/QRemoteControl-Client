import QtQuick 2.0
import "MyComponents"

Item {
    signal continueClicked

    id: main
    width: 400
    height: 800

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
                             enabled: master.state == "socialState"
                             NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                         }
            Behavior on height {
                             enabled: master.state == "socialState"
                             NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                         }

            Flickable {
                id: flickable
                flickableDirection: Flickable.VerticalFlick
                clip: true
                contentWidth: parent.width - master.generalMargin*6
                contentHeight: aboutText.height + moreText.height + 60

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

                Text {
                    id: aboutText
                    anchors {

                        top: parent.top
                        left: parent.left
                        right: parent.right
                    }
                    text: qsTr("Support Us") + client.emptyString
                    horizontalAlignment: Text.AlignHCenter
                    color: theme.primaryColor
                    height: main.height * 0.05
                    font {
                        pixelSize: theme.fontSizeMedium
                        bold: theme.buttonFontBold
                         }
                }

                Text {
                    id: moreText
                    anchors {
                        top: aboutText.bottom
                        left: parent.left
                        right: parent.right
                        topMargin: master.generalMargin
                    }
                    text: "<html><head><style>a:link{color:" + theme.highlightColor + "} a:visited{color:" + theme.highlightColor + "}</style></head><body>" +
                          qsTr("If you like like this application please support us and share it with your friends.") +
                          client.emptyString + "</body></html>"


                    wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                    color: theme.primaryColor

                    font {
                        pixelSize:theme.fontSizeSmall
                    }

                    onLinkActivated : Qt.openUrlExternally(link);
                }

                Button {
                        id: facebookButton
                        height: master.buttonHeight
                        anchors.right: parent.right
                        anchors.left: parent.left
                        anchors.top: moreText.bottom
                        anchors.margins: master.generalMargin
                        text: qsTr("Follow on facebook") + client.emptyString
                        icon: ""
                        onClicked: Qt.openUrlExternally("https://www.facebook.com/QRemote")

                        Image {
                            id: facebookIcon
                            width: height
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            anchors.margins: master.generalMargin
                            source: "images/social/facebook.png"
                        }
                }

                Button {
                        id: twitterButton
                        height: master.buttonHeight
                        anchors.right: parent.right
                        anchors.left: parent.left
                        anchors.top: facebookButton.bottom
                        anchors.margins: master.generalMargin
                        text: qsTr("Follow on Twitter") + client.emptyString
                        icon: ""
                        onClicked: Qt.openUrlExternally("https://twitter.com/qremote")
                        Image {
                            id: twitterIcon
                            width: height
                            fillMode: Image.PreserveAspectFit
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            anchors.margins: master.generalMargin
                            source: "images/social/twitter.png"
                        }
                }

                Button {
                        id: googlePlusButton
                        height: master.buttonHeight
                        anchors.right: parent.right
                        anchors.left: parent.left
                        anchors.top: twitterButton.bottom
                        anchors.margins: master.generalMargin
                        text: qsTr("Follow on Google+") + client.emptyString
                        icon: ""
                        onClicked: Qt.openUrlExternally("https://plus.google.com/102137581087459890216/posts")

                        Image {
                            id: googlePlusIcon
                            width: height
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            anchors.margins: master.generalMargin
                            source: "images/social/google+.png"
                        }
                }

                Button {
                        id: flattrButton
                        height: master.buttonHeight
                        anchors.right: parent.right
                        anchors.left: parent.left
                        anchors.top: googlePlusButton.bottom
                        anchors.margins: master.generalMargin
                        text: qsTr("Donate using Flattr") + client.emptyString
                        icon: ""
                        onClicked: Qt.openUrlExternally("https://flattr.com/profile/qremote")

                        Image {
                            id: flattrIcon
                            width: height
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            anchors.margins: master.generalMargin
                            source: "images/social/flattr.png"
                        }
                }

                Button {
                        id: donateButton
                        height: master.buttonHeight
                        anchors.right: parent.right
                        anchors.left: parent.left
                        anchors.top: flattrButton.bottom
                        anchors.margins: master.generalMargin
                        text: qsTr("Donate using PayPal") + client.emptyString
                        icon: ""
                        onClicked: Qt.openUrlExternally("https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=K6HPZGJE7NLRE")

                        Image {
                            id: donateImage
                            width: height
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            anchors.margins: master.generalMargin
                            source: "images/social/paypal.png"
                        }
                }

                Button {
                        id: bitcoinButton
                        height: master.buttonHeight
                        anchors.right: parent.right
                        anchors.left: parent.left
                        anchors.top: donateButton.bottom
                        anchors.margins: master.generalMargin
                        text: qsTr("Donate using Bitcoin") + client.emptyString
                        icon: ""
                        onClicked: Qt.openUrlExternally("bitcoin:1KtaYL2cywgpx6np2R9xXhfzAaFnP8jbnA")

                        Image {
                            id: bitcoinImage
                            width: height
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            anchors.margins: master.generalMargin
                            source: "images/social/bitcoin.png"
                        }
                }




            }
            Button {
                    id: exitButton
                    height: master.buttonHeight * 0.8
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.margins: master.generalMargin
                    text: qsTr("Continue") + client.emptyString
                    icon: ""
                    onClicked: continueClicked()
                }
        }
    }
}
