// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0

Item {
    property alias border: minusButton.border
    property alias editGradient:    lineEdit.gradient
    property alias textColor: minusButton.textColor
    property alias editTextColor: lineEdit.textColor
    property alias font: minusButton.font
    property int value: 0
    property int min: 0
    property int max: 9999
    property int step: 1
    property Style theme: master.theme

    id: main

    width: 200
    height: 40

    LineEdit {
        id: lineEdit

        width: parent.width - parent.height*2 - parent.height * 0.2
        height: parent.height
        labelEnabled: false
        border.width: minusButton.border.width
        border.color: minusButton.border.color
        text: value
        autodelete: false
        inputMethodHints: Qt.ImhDigitsOnly
        validator: IntValidator{bottom: min; top: max;}
        theme: main.theme

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
        anchors.left: lineEdit.right
        anchors.leftMargin: parent.height * 0.1
        text: "-"
        textColor: lineEdit.inputActiveFocus?theme.highlightColor:theme.primaryColor
        theme: main.theme
        onClicked: {
            if ((value-step) >= min)
                value = value - step
        }
    }

    Button {
        id: plusButton
        width: height
        height: parent.height
        anchors.left: minusButton.right
        anchors.leftMargin: parent.height * 0.1
        text: "+"
        textColor: lineEdit.inputActiveFocus?theme.highlightColor:theme.primaryColor
        border.width: minusButton.border.width
        border.color: minusButton.border.color
        theme: main.theme
        onClicked: {
            if ((value+step) <= max)
                value = value + step
        }
    }
}
