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
            }

            theme.radiusScaler = roundness
            roundnessSlider.value = roundnessSlider.maximum-theme.radiusScaler
        }
    }


    Component.onCompleted: {
        loadTimer.start()
    }

    Label {
        id: label1
        text: qsTr("Color:")
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
    }

   Label {
        id: label2
        text: qsTr("Roundness:")
        anchors.top: grid1.bottom
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
    }

   Slider {
       id: roundnessSlider
       anchors.top: label2.bottom
       anchors.topMargin: 10
       anchors.right: parent.right
       anchors.rightMargin: 10
       anchors.left: parent.left
       anchors.leftMargin: 10

       height: parent.height*0.08

       minimum: 2
       maximum: 20

       onValueChanged: {
           theme.radiusScaler = maximum-value
           client.uiRoundness = theme.radiusScaler
       }
   }

    Button {
            id: exitButton
            height: parent.height * 0.08
            text: qsTr("Continue")
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            icon: ""
            onClicked: continueClicked()
        }

        Grid {
            id: grid1
            width: 380
            anchors.bottomMargin: parent.height/2
            anchors.bottom: parent.bottom
            rows: 4
            columns: 3
            spacing: 5
            anchors.top: label1.bottom
            anchors.topMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10

            Button {
                id: goldButton
                width: (parent.width-(parent.columns-1)*parent.spacing) / parent.columns
                height: (parent.height-parent.spacing*(parent.rows-1))/parent.rows
                text: qsTr("Gold")
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
                    master.iconTheme = "black"
                    client.uiColor = "gold"
                    client.uiRoundness = theme.radiusScaler
                }
            }

            Button {
                id: greyButton
                width: (parent.width-(parent.columns-1)*parent.spacing) / parent.columns
                height: (parent.height-parent.spacing*(parent.rows-1))/parent.rows
                text: qsTr("Grey")
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
                    master.iconTheme = "black"
                    client.uiColor = "grey"
                    client.uiRoundness = theme.radiusScaler
                }
            }

            Button {
                id: greenButton
                width: (parent.width-(parent.columns-1)*parent.spacing) / parent.columns
                height: (parent.height-parent.spacing*(parent.rows-1))/parent.rows
                text: qsTr("Green")
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
                    master.iconTheme = "black"
                    client.uiColor = "green"
                    client.uiRoundness = theme.radiusScaler
                }
            }

            Button {
                id: silverButton
                width: (parent.width-(parent.columns-1)*parent.spacing) / parent.columns
                height: (parent.height-parent.spacing*(parent.rows-1))/parent.rows
                text: qsTr("Silver")
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
                    master.iconTheme = "black"
                    client.uiColor = "silver"
                    client.uiRoundness = theme.radiusScaler
                }
            }

            Button {
                id: pinkButton
                width: (parent.width-(parent.columns-1)*parent.spacing) / parent.columns
                height: (parent.height-parent.spacing*(parent.rows-1))/parent.rows
                text: qsTr("Pink")
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
                    master.iconTheme = "black"
                    client.uiColor = "pink"
                    client.uiRoundness = theme.radiusScaler
                }
            }

            Button {
                id: redButton
                width: (parent.width-(parent.columns-1)*parent.spacing) / parent.columns
                height: (parent.height-parent.spacing*(parent.rows-1))/parent.rows
                text: qsTr("Red")
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
                    master.iconTheme = "black"
                    client.uiColor = "red"
                    client.uiRoundness = theme.radiusScaler
                }
            }

            Button {
                id: whiteButton
                width: (parent.width-(parent.columns-1)*parent.spacing) / parent.columns
                height: (parent.height-parent.spacing*(parent.rows-1))/parent.rows
                text: qsTr("White")
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
                    master.iconTheme = "black"
                    client.uiColor = "white"
                    client.uiRoundness = theme.radiusScaler
                }
            }

            Button {
                id: blackButton
                width: (parent.width-(parent.columns-1)*parent.spacing) / parent.columns
                height: (parent.height-parent.spacing*(parent.rows-1))/parent.rows
                text: qsTr("Black")
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
                height: (parent.height-parent.spacing*(parent.rows-1))/parent.rows
                text: qsTr("Blue")
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
                    master.iconTheme = "black"
                    client.uiColor = "blue"
                    client.uiRoundness = theme.radiusScaler
                }
            }
            Button {
                id: nerdyButton
                width: (parent.width-(parent.columns-1)*parent.spacing) / parent.columns
                height: (parent.height-parent.spacing*(parent.rows-1))/parent.rows
                text: qsTr("Nerdy")
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
        }
}
