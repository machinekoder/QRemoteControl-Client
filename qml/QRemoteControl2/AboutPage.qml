// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "MyComponents/"
//import MyComponents 1.0

Rectangle {
    signal continueClicked

    id: aboutPage
    width: 360
    height: 640
    color: "#00000000"

    Flickable {
        id: flickable

        width: aboutPage.width
        height: aboutPage.height - master.generalMargin*4
        flickableDirection: Flickable.VerticalFlick
        clip: true
        contentWidth: aboutPage.width - master.generalMargin*6
        contentHeight: aboutContainer.height + moreText.height + 60

        anchors {
            left: parent.left
            leftMargin: master.generalMargin*2
            rightMargin: master.generalMargin*2
            right: parent.right
            top: parent.top
            topMargin: master.generalMargin*2
        }

        Item {
            width: parent.width

            id: aboutContainer

            Image {
                id: logoImg
                source: "images/qrc.png"
                smooth: true
                width: parent.width*0.2
                height: width
                sourceSize.width: width
                sourceSize.height: height
                fillMode: Image.PreserveAspectFit
            }

            Text {
                text: qsTr("About QRemoteControl")
                id: aboutText
                color: theme.primaryTextColor
                anchors {
                    left: logoImg.right
                    leftMargin: 25
                    top: parent.top
                }

                font {
                    pixelSize: theme.buttonFontSize
                    bold: theme.buttonFontBold
                }
            }

            Text {
                textFormat: Text.RichText
                text: qsTr("Copyright 2012-2013 <br>by Alexander Rössler <br>Version: ") + client.version
                color: theme.primaryTextColor
                anchors {
                    left: logoImg.right
                    leftMargin: 25
                    top: aboutText.bottom
                }

                font {
                    pixelSize: theme.hintFontSize//aboutPage.width*0.03
                }
            }

            height: logoImg.height
        }

        Text {
            id: moreText
            text: qsTr("If you find bugs and errors or want to give feedback please contact: <a href=\"mailto:support@qremote.org\">support@qremote.org</a><br>") +
                  qsTr("or visit <a href=\"http://qremote.org\">qremote.org</a> <br> <br>") +
                  qsTr("If you find this application useful please show it to your friends and vote for it.")


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
            height: master.buttonHeight*0.8
            text: qsTr("Continue")
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
