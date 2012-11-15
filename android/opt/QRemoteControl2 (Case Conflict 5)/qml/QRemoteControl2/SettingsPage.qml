import QtQuick 1.1
import "MyComponents/"
//import MyComponents 1.0

import "gradients/grey" as GreyGradients
import "gradients/black" as BlackGradients
import "gradients/white" as WhiteGradients
import "gradients/gold" as GoldGradients
import "gradients/silver" as SilverGradients
import "gradients/pink" as PinkGradients
import "gradients/green" as GreenGradients
import "gradients/blue" as BlueGradients
import "gradients/red" as RedGradients

Rectangle {
    id: rectangle1
    width: 400
    height: 600
    color: "#00000000"

    signal continueClicked

    BlackGradients.LabelGradient{id: blackLabel}
    WhiteGradients.LabelGradient{id: whiteLabel}
    GreyGradients.LabelGradient{id: greyLabel}
    GoldGradients.LabelGradient{id: goldLabel}
    SilverGradients.LabelGradient{id: silverLabel}
    PinkGradients.LabelGradient{id: pinkLabel}
    RedGradients.LabelGradient{id: redLabel}
    BlueGradients.LabelGradient{id: blueLabel}
    GreenGradients.LabelGradient{id: greenLabel}
    BlackGradients.BarGradient{id: blackBar}
    WhiteGradients.BarGradient{id: whiteBar}
    GreyGradients.BarGradient{id: greyBar}
    GoldGradients.BarGradient{id: goldBar}
    SilverGradients.BarGradient{id: silverBar}
    PinkGradients.BarGradient{id: pinkBar}
    RedGradients.BarGradient{id: redBar}
    BlueGradients.BarGradient{id: blueBar}
    GreenGradients.BarGradient{id: greenBar}

    Component.onCompleted: {
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
        }
    }

    Label {
        id: label1
        text: "Color:"
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        gradient: master.labelGradient
        border.color: master.border.color
        font.pixelSize: master.textSize2
        textColor: master.textColor2
    }

    Button {
            id: exitButton
            height: parent.height * 0.08
            text: "Continue"
            font.bold: true
            font.pixelSize: master.textSize2
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            icon: ""
            defaultGradient: master.defaultGradient
            pressedGradient: master.pressedGradient
            hoveredGradient: master.hoveredGradient
            border.color: master.border.color
            textColor: master.textColor1
            onClicked: continueClicked()
        }

        Grid {
            id: grid1
            width: 380
            anchors.bottomMargin: parent.height/2
            anchors.bottom: parent.bottom
            rows: 3
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
                text: "Gold"
                defaultGradient: GoldGradients.DefaultGradient{}
                hoveredGradient: GoldGradients.HoveredGradient{}
                pressedGradient: GoldGradients.PressedGradient{}
                border.color: "#ffb300"
                textColor: "black"
                onClicked: {
                    master.defaultGradient = defaultGradient
                    master.hoveredGradient = hoveredGradient
                    master.pressedGradient = pressedGradient
                    master.labelGradient = goldLabel
                    master.barGradient = goldBar
                    master.border.color = border.color
                    master.textColor1 = textColor
                    master.textColor2 = textColor
                    master.backgroundImage = "images/background_gold.png"
                    client.uiColor = "gold"
                    client.saveSettings()
                }
            }

            Button {
                id: greyButton
                width: (parent.width-(parent.columns-1)*parent.spacing) / parent.columns
                height: (parent.height-parent.spacing*(parent.rows-1))/parent.rows
                text: "Grey"
                defaultGradient: GreyGradients.DefaultGradient{}
                hoveredGradient: GreyGradients.HoveredGradient{}
                pressedGradient: GreyGradients.PressedGradient{}
                border.color: "#999"
                textColor: "black"
                onClicked: {
                    master.defaultGradient = defaultGradient
                    master.hoveredGradient = hoveredGradient
                    master.pressedGradient = pressedGradient
                    master.labelGradient = greyLabel
                    master.barGradient = greyBar
                    master.border.color = border.color
                    master.textColor1 = textColor
                    master.textColor2 = "white"
                    master.backgroundImage = "images/background_grey.png"
                    client.uiColor = "grey"
                    client.saveSettings()
                }
            }

            Button {
                id: greenButton
                width: (parent.width-(parent.columns-1)*parent.spacing) / parent.columns
                height: (parent.height-parent.spacing*(parent.rows-1))/parent.rows
                text: "Green"
                defaultGradient: GreenGradients.DefaultGradient{}
                hoveredGradient: GreenGradients.HoveredGradient{}
                pressedGradient: GreenGradients.PressedGradient{}
                border.color: "#84ff00"
                textColor: "black"
                onClicked: {
                    master.defaultGradient = defaultGradient
                    master.hoveredGradient = hoveredGradient
                    master.pressedGradient = pressedGradient
                    master.labelGradient = greenLabel
                    master.barGradient = greenBar
                    master.border.color = border.color
                    master.textColor1 = textColor
                    master.textColor2 = textColor
                    master.backgroundImage = "images/background_green.png"
                    client.uiColor = "green"
                    client.saveSettings()
                }
            }

            Button {
                id: silverButton
                width: (parent.width-(parent.columns-1)*parent.spacing) / parent.columns
                height: (parent.height-parent.spacing*(parent.rows-1))/parent.rows
                text: "Silver"
                defaultGradient: SilverGradients.DefaultGradient{}
                hoveredGradient: SilverGradients.HoveredGradient{}
                pressedGradient: SilverGradients.PressedGradient{}
                border.color: "#8d8d8d"
                textColor: "black"
                onClicked: {
                    master.defaultGradient = defaultGradient
                    master.hoveredGradient = hoveredGradient
                    master.pressedGradient = pressedGradient
                    master.labelGradient = silverLabel
                    master.barGradient = silverBar
                    master.border.color = border.color
                    master.textColor1 = textColor
                    master.textColor2 = "white"
                    master.backgroundImage = "images/background_silver.png"
                    client.uiColor = "silver"
                    client.saveSettings()
                }
            }

            Button {
                id: pinkButton
                width: (parent.width-(parent.columns-1)*parent.spacing) / parent.columns
                height: (parent.height-parent.spacing*(parent.rows-1))/parent.rows
                text: "Pink"
                defaultGradient: PinkGradients.DefaultGradient{}
                hoveredGradient: PinkGradients.HoveredGradient{}
                pressedGradient: PinkGradients.PressedGradient{}
                border.color: "#e664ff"
                textColor: "black"
                onClicked: {
                    master.defaultGradient = defaultGradient
                    master.hoveredGradient = hoveredGradient
                    master.pressedGradient = pressedGradient
                    master.labelGradient = pinkLabel
                    master.barGradient = pinkBar
                    master.border.color = border.color
                    master.textColor1 = textColor
                    master.textColor2 = textColor
                    master.backgroundImage = "images/background_pink.png"
                    client.uiColor = "pink"
                    client.saveSettings()
                }
            }

            Button {
                id: redButton
                width: (parent.width-(parent.columns-1)*parent.spacing) / parent.columns
                height: (parent.height-parent.spacing*(parent.rows-1))/parent.rows
                text: "Red"
                defaultGradient: RedGradients.DefaultGradient{}
                hoveredGradient: RedGradients.HoveredGradient{}
                pressedGradient: RedGradients.PressedGradient{}
                border.color: "#ff2e00"
                textColor: "black"
                onClicked: {
                    master.defaultGradient = defaultGradient
                    master.hoveredGradient = hoveredGradient
                    master.pressedGradient = pressedGradient
                    master.labelGradient = redLabel
                    master.barGradient = redBar
                    master.border.color = border.color
                    master.textColor1 = textColor
                    master.textColor2 = textColor
                    master.backgroundImage = "images/background_red.png"
                    client.uiColor = "red"
                    client.saveSettings()
                }
            }

            Button {
                id: whiteButton
                width: (parent.width-(parent.columns-1)*parent.spacing) / parent.columns
                height: (parent.height-parent.spacing*(parent.rows-1))/parent.rows
                text: "White"
                defaultGradient: WhiteGradients.DefaultGradient{}
                hoveredGradient: WhiteGradients.HoveredGradient{}
                pressedGradient: WhiteGradients.PressedGradient{}
                border.color: "#eeeeee"
                textColor: "black"
                onClicked: {
                    master.defaultGradient = defaultGradient
                    master.hoveredGradient = hoveredGradient
                    master.pressedGradient = pressedGradient
                    master.labelGradient = whiteLabel
                    master.barGradient = whiteBar
                    master.border.color = border.color
                    master.textColor1 = textColor
                    master.textColor2 = textColor
                    master.backgroundImage = "images/background_white.png"
                    client.uiColor = "white"
                    client.saveSettings()
                }
            }

            Button {
                id: blackButton
                width: (parent.width-(parent.columns-1)*parent.spacing) / parent.columns
                height: (parent.height-parent.spacing*(parent.rows-1))/parent.rows
                text: "Black"
                defaultGradient: BlackGradients.DefaultGradient{}
                hoveredGradient: BlackGradients.HoveredGradient{}
                pressedGradient: BlackGradients.PressedGradient{}
                border.color: "#333"
                textColor: "white"
                onClicked: {
                    master.defaultGradient = defaultGradient
                    master.hoveredGradient = hoveredGradient
                    master.pressedGradient = pressedGradient
                    master.labelGradient = blackLabel
                    master.barGradient = blackBar
                    master.border.color = border.color
                    master.textColor1 = textColor
                    master.textColor2 = textColor
                    master.backgroundImage = "images/background_black.png"
                    client.uiColor = "black"
                    client.saveSettings()
                }
            }

            Button {
                id: blueButton
                width: (parent.width-(parent.columns-1)*parent.spacing) / parent.columns
                height: (parent.height-parent.spacing*(parent.rows-1))/parent.rows
                text: "Blue"
                defaultGradient: BlueGradients.DefaultGradient{}
                hoveredGradient: BlueGradients.HoveredGradient{}
                pressedGradient: BlueGradients.PressedGradient{}
                border.color: "#009dff"
                textColor: "black"
                onClicked: {
                    master.defaultGradient = defaultGradient
                    master.hoveredGradient = hoveredGradient
                    master.pressedGradient = pressedGradient
                    master.labelGradient = blueLabel
                    master.barGradient = blueBar
                    master.border.color = border.color
                    master.textColor1 = textColor
                    master.textColor2 = textColor
                    master.backgroundImage = "images/background_blue.png"
                    client.uiColor = "blue"
                    client.saveSettings()
                }
            }
        }
}
