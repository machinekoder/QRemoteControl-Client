// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
Rectangle {
    property alias border: minusButton.border
    //property alias defaultGradient: minusButton.defaultGradient
    //property alias hoveredGradient: minusButton.hoveredGradient
    //property alias pressedGradient: minusButton.pressedGradient
    property alias editGradient:    lineEdit.gradient
    property alias textColor: minusButton.textColor
    property alias editTextColor: lineEdit.textColor
    property alias font: minusButton.font
    property int value: 0
    property int min: 0
    property int max: 9999
    property int step: 1

    id: main
    width: 200
    height: 40
    color: "#00000000"

    LineEdit {
        id: lineEdit
        width: parent.width - parent.height*2 -10
        height: parent.height
        labelEnabled: false
        border.width: minusButton.border.width
        border.color: minusButton.border.color
        text: value.toString()
        font: minusButton.font
        autodelete: false
        onTextChanged: {
            var number = Number(text)
            if (!isNaN(number))
            {
                if ((number >= min) && (number <= max)) {
                    value = number
                    return
                }
            }

            value = value+1
            value = value-1

        }
    }

    Button {
        id: minusButton
        width: height
        height: parent.height
        text: "-"
        anchors.left: lineEdit.right
        anchors.leftMargin: 4
        onClicked: {
            if ((value-step) >= min)
                value = value - step
        }
    }

    Button {
        id: plusButton
        width: height
        height: parent.height
        text: "+"
        anchors.left: minusButton.right
        anchors.leftMargin: 5
        border.width: minusButton.border.width
        border.color: minusButton.border.color
        onClicked: {
            if ((value+step) <= max)
                value = value + step
        }
    }
}
