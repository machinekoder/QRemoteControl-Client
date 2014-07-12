import QtQuick 2.0
import "MyComponents/"

Item {
    signal continueClicked

    function setScreenOrientation(screenOrientation)
    {
        orientationSelector.setScreenOrientation(screenOrientation)
    }
    function setLanguage(language)
    {
        languageSelector.setLanguage(language)
    }

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
                             enabled: master.state == "settingsState"
                             NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                         }
            Behavior on height {
                             enabled: master.state == "settingsState"
                             NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                         }

            Flickable {
                id: flicker
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: exitButton.top
                anchors.bottomMargin: master.generalMargin
                contentHeight: master.buttonHeight * 12
                contentWidth: width
                flickableDirection: Flickable.VerticalFlick
                clip: true

                Label {
                     id: label3
                     text: qsTr("Orientation Lock:") + client.emptyString
                     height: master.buttonHeight * 0.7
                     anchors.top: parent.top
                     anchors.margins: master.generalMargin
                     anchors.right: parent.right
                     anchors.left: parent.left
                 }

                OrientationSelector {
                    id: orientationSelector
                    anchors.top:                 label3.bottom
                    anchors.topMargin:           master.generalMargin
                    anchors.horizontalCenter:    parent.horizontalCenter
                }

                Label {
                     id: label4
                     text: qsTr("Language:") + client.emptyString
                     height: master.buttonHeight * 0.7
                     anchors.top: orientationSelector.bottom
                     anchors.margins: master.generalMargin
                     anchors.right: parent.right
                     anchors.left: parent.left
                 }

                LanguageSelector {
                    id: languageSelector
                    anchors.top:                 label4.bottom
                    anchors.topMargin:           master.generalMargin
                    anchors.horizontalCenter:    parent.horizontalCenter
                }



                Label {
                    id: label1
                    text: qsTr("Color:") + client.emptyString
                    height: master.buttonHeight * 0.7
                    anchors.top: languageSelector.bottom
                    anchors.margins: master.generalMargin
                    anchors.right: parent.right
                    anchors.left: parent.left
                }

                ThemeSelector {
                    id: themeSelector
                    anchors.top: label1.bottom
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.margins: master.generalMargin
                }

                Label {
                     id: label2
                     text: qsTr("Roundness:") + client.emptyString
                     height: master.buttonHeight * 0.7
                     anchors.top: themeSelector.bottom
                     anchors.margins: master.generalMargin
                     anchors.right: parent.right
                     anchors.left: parent.left
                 }

                Slider {
                    id: roundnessSlider
                    anchors.top: label2.bottom
                    anchors.margins: master.generalMargin
                    anchors.right: parent.right
                    anchors.left: parent.left

                    height: master.buttonHeight*0.7

                    minimum: 2
                    maximum: 20

                    onValueChanged: {
                        theme.radiusScaler = maximum-value
                        client.uiRoundness = theme.radiusScaler
                    }
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
