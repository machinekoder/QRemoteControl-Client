import QtQuick 2.0
import "MyComponents/"

Item {
    signal continueClicked

    id: aboutPage
    width: 360
    height: 640

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
                             enabled: master.state == "aboutState"
                             NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                         }
            Behavior on height {
                             enabled: master.state == "aboutState"
                             NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                         }

            Flickable {
                id: flickable

                width: aboutPage.width
                height: aboutPage.height - master.generalMargin*4
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
                    anchors.left: parent.left; anchors.right: parent.right
                    height: width * 0.3

                    id: aboutContainer

                    Image {
                        id: logoImg
                        source: client.trialVersion?"images/qrc_trial.png":"images/qrc.png"
                        smooth: true
                        width: parent.width*0.2
                        height: width
                        sourceSize.width: width
                        sourceSize.height: height
                        fillMode: Image.PreserveAspectFit
                    }

                    Text {
                        text: client.trialVersion?(qsTr("About QRemoteControl Trial") + client.emptyString):(qsTr("About QRemoteControl") + client.emptyString)
style: Text.Raised
id: aboutText
                        color: theme.primaryColor
                        anchors {
                            left: logoImg.right
                            leftMargin: master.generalMargin*2
                            top: parent.top
                        }

                        font {
                            pixelSize: theme.fontSizeMedium
                            bold: theme.buttonFontBold
                        }
                    }

                    Text {
                        textFormat: Text.RichText
                        text: qsTr("Copyright 2012-2014<br>by Alexander Rössler<br>Version: ") + client.version + client.emptyString
                        color: theme.primaryColor
                        anchors {
                            left: logoImg.right
                            leftMargin: master.generalMargin*2
                            top: aboutText.bottom
                        }

                        font {
                            pixelSize: theme.fontSizeSmall
                        }
                    }
                }

                Text {
                    id: moreText
                    anchors {
                        top: aboutContainer.bottom
                        topMargin: master.generalMargin
                        left: parent.left
                        right: parent.right
                    }
                    text: "<html><head><style>a:link{color:" + theme.highlightColor + "} a:visited{color:" + theme.highlightColor + "}</style></head> <body>" +
                          qsTr("If you find bugs and errors or want to give feedback please contact: <a href=\"mailto:support@qremote.org\">support@qremote.org</a><br>") +
                          qsTr("or visit <a href=\"http://qremote.org\">qremote.org</a> <br> <br>") +
                          qsTr("If you find this application useful please show it to your friends and vote for it.<br>") + client.emptyString + "</body></html>"
                    wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                    color: theme.primaryColor

                    font {
                        pixelSize: theme.fontSizeSmall
                    }

                    onLinkActivated : Qt.openUrlExternally(link);
                }

                Text {
                    id: trialText
                    anchors {
                        top: moreText.bottom
                        topMargin: master.generalMargin*2
                        left: parent.left
                        right: parent.right
                    }
                    text: client.trialVersion?qsTr("This trial version expires at: ") + Qt.formatDateTime(client.trialExpirationTime,"ddd dd.MM.yy hh:mmAP") + client.emptyString:""
                    wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                    color: theme.primaryColor
                    font {
                        pixelSize: theme.fontSizeMedium
                    }

                    onLinkActivated : Qt.openUrlExternally(link);
                }

                Button {
                        id: websiteButton
                        height: master.buttonHeight
                        anchors.right: parent.right
                        anchors.left: parent.left
                        anchors.top: moreText.bottom
                        anchors.margins: master.generalMargin
                        text: qsTr("Visit website") + client.emptyString
                        icon: ""
                        onClicked: Qt.openUrlExternally("http://qremote.org/")

                        Image {
                            id: websiteImage
                            width: height
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            anchors.margins: master.generalMargin
                            source: "images/qrc.png"
                            smooth: true
                        }
                }

                Button {
                        id: sourceButton
                        height: master.buttonHeight
                        anchors.right: parent.right
                        anchors.left: parent.left
                        anchors.top: websiteButton.bottom
                        anchors.margins: master.generalMargin
                        text: qsTr("Get the source code") + client.emptyString
                        icon: ""
                        onClicked: Qt.openUrlExternally("https://sourceforge.net/p/qremotecontrolclient/code/ci/master/tree/")

                        Image {
                            id: sourceImage
                            width: height
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            anchors.margins: master.generalMargin
                            source: "images/social/sourceforge.png"
                        }
                }
            }

            Button {
                    id: exitButton
                    height: master.buttonHeight*0.8
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
