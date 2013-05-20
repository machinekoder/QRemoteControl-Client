import QtQuick 1.1
import "MyComponents/"

import "styles" as Styles

Rectangle {
    id: rectangle1
    width: 400
    height: 600
    color: "#00000000"

    signal continueClicked

    Styles.Black{ id: blackStyle}
    Styles.Blue{ id: blueStyle}
    Styles.Gold{ id: goldStyle}
    Styles.Green{ id: greenStyle}
    Styles.Grey{ id: greyStyle}
    Styles.Pink{ id: pinkStyle}
    Styles.Red{ id: redStyle}
    Styles.Silver{ id: silverStyle}
    Styles.White{ id: whiteStyle}
    Styles.Nerdy{ id: nerdyStyle}
    Styles.Tech{ id: techStyle}

    Timer {
        id: loadTimer
        interval: 50
        repeat: false
        running: false
        onTriggered: {
            var roundness = client.uiRoundness;

            switch (client.uiColor)
            {
            case "gold": goldButton.clicked()
                break
            case "silver": silverButton.clicked()
                break
            case "grey": greyButton.clicked()
                break
            case "black": blackButton.clicked()
                break
            case "white": whiteButton.clicked()
                break
            case "pink": pinkButton.clicked()
                break
            case "blue": blueButton.clicked()
                break
            case "red": redButton.clicked()
                break
            case "green": greenButton.clicked()
                break
            case "nerdy": nerdyButton.clicked()
                break
            case "tech": techButton.clicked()
                break
            }

            theme.radiusScaler = roundness
            roundnessSlider.value = roundnessSlider.maximum-theme.radiusScaler
        }
    }


    Component.onCompleted: {
        loadTimer.start()
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

            Flickable {
                id: flicker
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: exitButton.top
                anchors.bottomMargin: master.generalMargin
                contentHeight: master.buttonHeight * 10
                contentWidth: width
                flickableDirection: Flickable.VerticalFlick
                clip: true

                Label {
                    id: label1
                    text: qsTr("Color:") + client.emptyString
                    height: master.buttonHeight * 0.7
                    anchors.top: parent.top
                    anchors.topMargin: master.generalMargin
                    anchors.right: parent.right
                    anchors.rightMargin: master.generalMargin
                    anchors.left: parent.left
                    anchors.leftMargin: master.generalMargin
                }

               Label {
                    id: label2
                    text: qsTr("Roundness:") + client.emptyString
                    height: master.buttonHeight * 0.7
                    anchors.top: grid1.bottom
                    anchors.topMargin: master.generalMargin
                    anchors.right: parent.right
                    anchors.rightMargin: master.generalMargin
                    anchors.left: parent.left
                    anchors.leftMargin: master.generalMargin
                }

               Slider {
                   id: roundnessSlider
                   anchors.top: label2.bottom
                   anchors.topMargin: master.generalMargin
                   anchors.right: parent.right
                   anchors.rightMargin: master.generalMargin
                   anchors.left: parent.left
                   anchors.leftMargin: master.generalMargin

                   height: master.buttonHeight*0.7

                   minimum: 2
                   maximum: 20

                   onValueChanged: {
                       theme.radiusScaler = maximum-value
                       client.uiRoundness = theme.radiusScaler
                   }
               }

               Label {
                    id: label3
                    text: qsTr("Orientation Lock:") + client.emptyString
                    height: master.buttonHeight * 0.7
                    anchors.top: roundnessSlider.bottom
                    anchors.topMargin: master.generalMargin
                    anchors.right: parent.right
                    anchors.rightMargin: master.generalMargin
                    anchors.left: parent.left
                    anchors.leftMargin: master.generalMargin
                }

               Item {
                   id: orientationLockButtons
                   anchors.top:                 label3.bottom
                   anchors.topMargin:           master.generalMargin
                   anchors.horizontalCenter:    parent.horizontalCenter
                   width:                       master.buttonHeight * 0.9 * 5 + 4 * master.generalMargin
                   height:                      master.buttonHeight
                   Button {
                       id:              noLockButton
                       checkable:       true
                       width:           master.buttonHeight * 0.9
                       height:          width
                       text:            ""
                       icon:            master.imagePath + master.iconTheme + "/exit.png"
                       anchors.top:     parent.top
                       anchors.left:    parent.left
                       onClicked: {
                           if (!checked)
                           {
                               portraitLockButton.checked = false
                               reversePortraitLockButton.checked = false
                               landscapeLockButton.checked = false
                               reverseLandcapeLockButton.checked = false

                               client.screenOrientation = 0
                           }
                           else
                               checked = false
                       }
                   }

                   Button {
                       id:                  portraitLockButton
                       checkable:           true
                       width:               master.buttonHeight * 0.9
                       height:              width
                       text:                ""
                       icon:                master.imagePath + master.iconTheme + "/up.png"
                       anchors.top:         parent.top
                       anchors.left:        noLockButton.right
                       anchors.leftMargin:  master.generalMargin
                       onClicked: {
                           if (!checked)
                           {
                               noLockButton.checked = false
                               reversePortraitLockButton.checked = false
                               landscapeLockButton.checked = false
                               reverseLandcapeLockButton.checked = false

                               client.screenOrientation = 1
                               master.screenRotation = 0
                               if (!device.landscapeMode)
                                    master.screenRotation += 90
                           }
                           else
                               checked = false
                       }
                   }

                   Button {
                       id:                  reversePortraitLockButton
                       checkable:           true
                       width:               master.buttonHeight * 0.9
                       height:              width
                       text:                ""
                       icon:                master.imagePath + master.iconTheme + "/down.png"
                       anchors.top:         parent.top
                       anchors.left:        portraitLockButton.right
                       anchors.leftMargin:  master.generalMargin
                       onClicked: {
                           if (!checked)
                           {
                               portraitLockButton.checked = false
                               noLockButton.checked = false
                               landscapeLockButton.checked = false
                               reverseLandcapeLockButton.checked = false

                               client.screenOrientation = 2
                               master.screenRotation = 180
                               if (!device.landscapeMode)
                                    master.screenRotation += 90
                           }
                           else
                               checked = false
                       }
                   }

                   Button {
                       id:                  landscapeLockButton
                       checkable:           true
                       width:               master.buttonHeight * 0.9
                       height:              width
                       text:                ""
                       icon:                master.imagePath + master.iconTheme + "/right.png"
                       anchors.top:         parent.top
                       anchors.left:        reversePortraitLockButton.right
                       anchors.leftMargin:  master.generalMargin
                       onClicked: {
                           if (!checked)
                           {
                               portraitLockButton.checked = false
                               reversePortraitLockButton.checked = false
                               noLockButton.checked = false
                               reverseLandcapeLockButton.checked = false

                               client.screenOrientation = 3
                               master.screenRotation = 90
                               if (!device.landscapeMode)
                                    master.screenRotation += 90
                           }
                           else
                               checked = false
                       }
                   }

                   Button {
                       id:                  reverseLandcapeLockButton
                       checkable:           true
                       width:               master.buttonHeight * 0.9
                       height:              width
                       text:                ""
                       icon:                master.imagePath + master.iconTheme + "/left.png"
                       anchors.top:         parent.top
                       anchors.left:        landscapeLockButton.right
                       anchors.leftMargin:  master.generalMargin
                       onClicked: {
                           if (!checked)
                           {
                               portraitLockButton.checked = false
                               reversePortraitLockButton.checked = false
                               landscapeLockButton.checked = false
                               noLockButton.checked = false

                               client.screenOrientation = 4
                               master.screenRotation = -90
                               if (!device.landscapeMode)
                                    master.screenRotation += 90
                           }
                           else
                               checked = false
                       }
                   }
               }

               Label {
                    id: label4
                    text: qsTr("Language:") + client.emptyString
                    height: master.buttonHeight * 0.7
                    anchors.top: orientationLockButtons.bottom
                    anchors.topMargin: master.generalMargin
                    anchors.right: parent.right
                    anchors.rightMargin: master.generalMargin
                    anchors.left: parent.left
                    anchors.leftMargin: master.generalMargin
                }

               Item {
                   id: languageButtons
                   anchors.top:                 label4.bottom
                   anchors.topMargin:           master.generalMargin
                   anchors.horizontalCenter:    parent.horizontalCenter
                   width:                       master.buttonHeight * 0.9 * 4 + 3 * master.generalMargin

                   Button {
                       id:              englishButton
                       checkable:       true
                       width:           master.buttonHeight * 0.9
                       height:          width
                       text:            ""
                       icon:            master.imagePath + "/lang/english.png"
                       anchors.top:     parent.top
                       anchors.left:    parent.left
                       onClicked: {
                           if (!checked)
                           {
                               germanButton.checked = false
                               russianButton.checked = false
                               ukrainianButton.checked = false

                               client.language = "en"
                           }
                           else
                               checked = false
                       }
                   }
                   Button {
                       id:              germanButton
                       checkable:       true
                       width:           master.buttonHeight * 0.9
                       height:          width
                       text:            ""
                       icon:            master.imagePath + "/lang/german.png"
                       anchors.top:     parent.top
                       anchors.left:    englishButton.right
                       anchors.leftMargin:  master.generalMargin
                       onClicked: {
                           if (!checked)
                           {
                               englishButton.checked = false
                               russianButton.checked = false
                               ukrainianButton.checked = false

                               client.language = "de"
                           }
                           else
                               checked = false
                       }
                   }
                   Button {
                       id:              russianButton
                       checkable:       true
                       width:           master.buttonHeight * 0.9
                       height:          width
                       text:            ""
                       icon:            master.imagePath + "/lang/russian.png"
                       anchors.top:     parent.top
                       anchors.left:    germanButton.right
                       anchors.leftMargin:  master.generalMargin
                       onClicked: {
                           if (!checked)
                           {
                               germanButton.checked = false
                               englishButton.checked = false
                               ukrainianButton.checked = false

                               client.language = "ru"
                           }
                           else
                               checked = false
                       }
                   }
                   Button {
                       id:              ukrainianButton
                       checkable:       true
                       width:           master.buttonHeight * 0.9
                       height:          width
                       text:            ""
                       icon:            master.imagePath + "/lang/ukrainian.png"
                       anchors.top:     parent.top
                       anchors.left:    russianButton.right
                       anchors.leftMargin:  master.generalMargin
                       onClicked: {
                           if (!checked)
                           {
                               germanButton.checked = false
                               russianButton.checked = false
                               englishButton.checked = false

                               client.language = "uk"
                           }
                           else
                               checked = false
                       }
                   }

                }
                    Grid {
                        id: grid1
                        rows: 4
                        columns: 3
                        spacing: master.generalMargin/2
                        anchors.top: label1.bottom
                        anchors.topMargin: master.generalMargin
                        anchors.right: parent.right
                        anchors.rightMargin: master.generalMargin
                        anchors.left: parent.left
                        anchors.leftMargin: master.generalMargin

                        Button {
                            id: goldButton
                            width: (parent.width-(parent.columns-1)*parent.spacing) / parent.columns
                            height: master.buttonHeight * 0.8
                            text: qsTr("Gold") + client.emptyString
                            border.color: goldStyle.buttonBorderColor
                            font.pixelSize: goldStyle.buttonFontSize
                            font.bold: goldStyle.buttonFontBold
                            font.family: goldStyle.fontFamily
                            textColor: goldStyle.primaryTextColor
                            radiusScaler: goldStyle.radiusScaler
                            defaultGradient: goldStyle.defaultGradient
                            pressedGradient: goldStyle.pressedGradient
                            hoveredGradient: goldStyle.hoveredGradient
                            onClicked: {
                                theme.load(goldStyle);
                                roundnessSlider.value = roundnessSlider.maximum-theme.radiusScaler
                                master.backgroundImage = "images/background_gold.png"
                                master.backgroundImageFillMode = Image.Stretch
                                master.iconTheme = "black"
                                client.uiColor = "gold"
                                client.uiRoundness = theme.radiusScaler
                            }
                        }

                        Button {
                            id: greyButton
                            width: (parent.width-(parent.columns-1)*parent.spacing) / parent.columns
                            height: master.buttonHeight * 0.8
                            text: qsTr("Grey") + client.emptyString
                            border.color: greyStyle.buttonBorderColor
                            font.pixelSize: greyStyle.buttonFontSize
                            font.bold: greyStyle.buttonFontBold
                            font.family: greyStyle.fontFamily
                            textColor: greyStyle.primaryTextColor
                            radiusScaler: greyStyle.radiusScaler
                            defaultGradient: greyStyle.defaultGradient
                            pressedGradient: greyStyle.pressedGradient
                            hoveredGradient: greyStyle.hoveredGradient
                            onClicked: {
                                theme.load(greyStyle);
                                roundnessSlider.value = roundnessSlider.maximum-theme.radiusScaler
                                master.backgroundImage = "images/background_grey.png"
                                master.backgroundImageFillMode = Image.Stretch
                                master.iconTheme = "black"
                                client.uiColor = "grey"
                                client.uiRoundness = theme.radiusScaler
                            }
                        }

                        Button {
                            id: greenButton
                            width: (parent.width-(parent.columns-1)*parent.spacing) / parent.columns
                            height: master.buttonHeight * 0.8
                            text: qsTr("Green") + client.emptyString
                            border.color: greenStyle.buttonBorderColor
                            font.pixelSize: greenStyle.buttonFontSize
                            font.bold: greenStyle.buttonFontBold
                            font.family: greenStyle.fontFamily
                            textColor: greenStyle.primaryTextColor
                            radiusScaler: greenStyle.radiusScaler
                            defaultGradient: greenStyle.defaultGradient
                            pressedGradient: greenStyle.pressedGradient
                            hoveredGradient: greenStyle.hoveredGradient
                            onClicked: {
                                theme.load(greenStyle);
                                roundnessSlider.value = roundnessSlider.maximum-theme.radiusScaler
                                master.backgroundImage = "images/background_green.png"
                                master.backgroundImageFillMode = Image.Stretch
                                master.iconTheme = "black"
                                client.uiColor = "green"
                                client.uiRoundness = theme.radiusScaler
                            }
                        }

                        Button {
                            id: silverButton
                            width: (parent.width-(parent.columns-1)*parent.spacing) / parent.columns
                            height: master.buttonHeight * 0.8
                            text: qsTr("Silver") + client.emptyString
                            border.color: silverStyle.buttonBorderColor
                            font.pixelSize: silverStyle.buttonFontSize
                            font.bold: silverStyle.buttonFontBold
                            font.family: silverStyle.fontFamily
                            textColor: silverStyle.primaryTextColor
                            radiusScaler: silverStyle.radiusScaler
                            defaultGradient: silverStyle.defaultGradient
                            pressedGradient: silverStyle.pressedGradient
                            hoveredGradient: silverStyle.hoveredGradient
                            onClicked: {
                                theme.load(silverStyle);
                                roundnessSlider.value = roundnessSlider.maximum-theme.radiusScaler
                                master.backgroundImage = "images/background_silver.png"
                                master.backgroundImageFillMode = Image.Stretch
                                master.iconTheme = "black"
                                client.uiColor = "silver"
                                client.uiRoundness = theme.radiusScaler
                            }
                        }

                        Button {
                            id: pinkButton
                            width: (parent.width-(parent.columns-1)*parent.spacing) / parent.columns
                            height: master.buttonHeight * 0.8
                            text: qsTr("Pink") + client.emptyString
                            border.color: pinkStyle.buttonBorderColor
                            font.pixelSize: pinkStyle.buttonFontSize
                            font.bold: pinkStyle.buttonFontBold
                            font.family: pinkStyle.fontFamily
                            textColor: pinkStyle.primaryTextColor
                            radiusScaler: pinkStyle.radiusScaler
                            defaultGradient: pinkStyle.defaultGradient
                            pressedGradient: pinkStyle.pressedGradient
                            hoveredGradient: pinkStyle.hoveredGradient
                            onClicked: {
                                theme.load(pinkStyle);
                                roundnessSlider.value = roundnessSlider.maximum-theme.radiusScaler
                                master.backgroundImage = "images/background_pink.png"
                                master.backgroundImageFillMode = Image.Stretch
                                master.iconTheme = "black"
                                client.uiColor = "pink"
                                client.uiRoundness = theme.radiusScaler
                            }
                        }

                        Button {
                            id: redButton
                            width: (parent.width-(parent.columns-1)*parent.spacing) / parent.columns
                            height: master.buttonHeight * 0.8
                            text: qsTr("Red") + client.emptyString
                            border.color: redStyle.buttonBorderColor
                            textColor: redStyle.primaryTextColor
                            font.pixelSize: redStyle.buttonFontSize
                            font.bold: redStyle.buttonFontBold
                            font.family: redStyle.fontFamily
                            radiusScaler: redStyle.radiusScaler
                            defaultGradient: redStyle.defaultGradient
                            pressedGradient: redStyle.pressedGradient
                            hoveredGradient: redStyle.hoveredGradient
                            onClicked: {
                                theme.load(redStyle);
                                roundnessSlider.value = roundnessSlider.maximum-theme.radiusScaler
                                master.backgroundImage = "images/background_red.png"
                                master.backgroundImageFillMode = Image.Stretch
                                master.iconTheme = "black"
                                client.uiColor = "red"
                                client.uiRoundness = theme.radiusScaler
                            }
                        }

                        Button {
                            id: whiteButton
                            width: (parent.width-(parent.columns-1)*parent.spacing) / parent.columns
                            height: master.buttonHeight * 0.8
                            text: qsTr("White") + client.emptyString
                            border.color: whiteStyle.buttonBorderColor
                            font.pixelSize: whiteStyle.buttonFontSize
                            font.bold: whiteStyle.buttonFontBold
                            font.family: whiteStyle.fontFamily
                            textColor: whiteStyle.primaryTextColor
                            radiusScaler: whiteStyle.radiusScaler
                            defaultGradient: whiteStyle.defaultGradient
                            pressedGradient: whiteStyle.pressedGradient
                            hoveredGradient: whiteStyle.hoveredGradient
                            onClicked: {
                                theme.load(whiteStyle);
                                roundnessSlider.value = roundnessSlider.maximum-theme.radiusScaler
                                master.backgroundImage = "images/background_white.png"
                                master.backgroundImageFillMode = Image.Stretch
                                master.iconTheme = "black"
                                client.uiColor = "white"
                                client.uiRoundness = theme.radiusScaler
                            }
                        }

                        Button {
                            id: blackButton
                            width: (parent.width-(parent.columns-1)*parent.spacing) / parent.columns
                            height: master.buttonHeight * 0.8
                            text: qsTr("Black") + client.emptyString
                            border.color: blackStyle.buttonBorderColor
                            font.pixelSize: blackStyle.buttonFontSize
                            font.bold: blackStyle.buttonFontBold
                            font.family: blackStyle.fontFamily
                            textColor: blackStyle.primaryTextColor
                            radiusScaler: blackStyle.radiusScaler
                            defaultGradient: blackStyle.defaultGradient
                            pressedGradient: blackStyle.pressedGradient
                            hoveredGradient: blackStyle.hoveredGradient
                            onClicked: {
                                theme.load(blackStyle);
                                roundnessSlider.value = roundnessSlider.maximum-theme.radiusScaler
                                master.backgroundImage = ""
                                master.iconTheme = "white"
                                client.uiColor = "black"
                                client.uiRoundness = theme.radiusScaler
                            }
                        }

                        Button {
                            id: blueButton
                            width: (parent.width-(parent.columns-1)*parent.spacing) / parent.columns
                            height: master.buttonHeight * 0.8
                            text: qsTr("Blue") + client.emptyString
                            border.color: blueStyle.buttonBorderColor
                            font.pixelSize: blueStyle.buttonFontSize
                            font.bold: blueStyle.buttonFontBold
                            font.family: blueStyle.fontFamily
                            textColor: blueStyle.primaryTextColor
                            radiusScaler: blueStyle.radiusScaler
                            defaultGradient: blueStyle.defaultGradient
                            pressedGradient: blueStyle.pressedGradient
                            hoveredGradient: blueStyle.hoveredGradient
                            onClicked: {
                                theme.load(blueStyle);
                                roundnessSlider.value = roundnessSlider.maximum-theme.radiusScaler
                                master.backgroundImage = "images/background_blue.png"
                                master.backgroundImageFillMode = Image.Stretch
                                master.iconTheme = "black"
                                client.uiColor = "blue"
                                client.uiRoundness = theme.radiusScaler
                            }
                        }
                        Button {
                            id: nerdyButton
                            width: (parent.width-(parent.columns-1)*parent.spacing) / parent.columns
                            height: master.buttonHeight * 0.8
                            text: qsTr("Nerdy") + client.emptyString
                            border.color: nerdyStyle.buttonBorderColor
                            font.pixelSize: nerdyStyle.buttonFontSize
                            font.bold: nerdyStyle.buttonFontBold
                            font.family: nerdyStyle.fontFamily
                            textColor: nerdyStyle.primaryTextColor
                            radiusScaler: nerdyStyle.radiusScaler
                            defaultGradient: nerdyStyle.defaultGradient
                            pressedGradient: nerdyStyle.pressedGradient
                            hoveredGradient: nerdyStyle.hoveredGradient
                            onClicked: {
                                theme.load(nerdyStyle);
                                roundnessSlider.value = roundnessSlider.maximum-theme.radiusScaler
                                master.backgroundImage = ""
                                master.iconTheme = "nerdy"
                                client.uiColor = "nerdy"
                                client.uiRoundness = theme.radiusScaler
                            }
                        }
                        Button {
                            id: techButton
                            width: (parent.width-(parent.columns-1)*parent.spacing) / parent.columns
                            height: master.buttonHeight * 0.8
                            text: qsTr("Tech") + client.emptyString
                            border.color: techStyle.buttonBorderColor
                            font.pixelSize: techStyle.buttonFontSize
                            font.bold: techStyle.buttonFontBold
                            font.family: techStyle.fontFamily
                            textColor: techStyle.primaryTextColor
                            radiusScaler: techStyle.radiusScaler
                            defaultGradient: techStyle.defaultGradient
                            pressedGradient: techStyle.pressedGradient
                            hoveredGradient: techStyle.hoveredGradient
                            onClicked: {
                                theme.load(techStyle);
                                roundnessSlider.value = roundnessSlider.maximum-theme.radiusScaler
                                master.backgroundImage = "images/tile.png"
                                master.backgroundImageFillMode = Image.Tile
                                master.iconTheme = "white"
                                client.uiColor = "tech"
                                client.uiRoundness = theme.radiusScaler
                            }
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

    function setScreenOrientation(screenOrientation)
    {
        noLockButton.checked = false
        portraitLockButton.checked = false
        reversePortraitLockButton.checked = false
        landscapeLockButton.checked = false
        reverseLandcapeLockButton.checked = false

        switch (screenOrientation)
        {
            case 0: noLockButton.checked = true
                break
            case 1: portraitLockButton.checked = true
                master.screenRotation = 0
                break
            case 2: reversePortraitLockButton.checked = true
                master.screenRotation = 180
                break
            case 3: landscapeLockButton.checked = true
                master.screenRotation = 90
                break
            case 4: reverseLandcapeLockButton.checked = true
                master.screenRotation = -90
                break
        }

        if (!device.landscapeMode)
             master.screenRotation += 90
    }

    function setLanguage(language)
    {
        englishButton.checked   = false
        germanButton.checked    = false
        russianButton.checked   = false
        ukrainianButton.checked = false

        switch (language)
        {
            case "en": englishButton.checked = true
                    break
            case "de": germanButton.checked = true
                    break
            case "ru": russianButton.checked = true
                    break
            case "uk": ukrainianButton.checked = true
                    break
        }
    }
}


