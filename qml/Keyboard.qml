import QtQuick 2.0
import "MyComponents/"

Item {
    property int textSize: width*0.035

    property bool shiftChecked: shiftButton.checked
    property bool controlChecked: controlButton.checked
    property bool altChecked: altButton.checked
    property bool metaChecked: false
    property int columnCount: 10

    property int keyboardMargin: Math.round(master.generalMargin/2)
    property int keyboardButtonWidth: Math.round((row6.width-keyboardMargin*(columnCount-1))/columnCount)
    property int keyboardButtonHeight: Math.round((height-keyboardMargin*7)/6)

    signal keyPressed
    signal keyReleased

    id: keyboardMain
    width: 640
    height: 360

    Row {
        id: row6
        y: 100
        height: keyboardButtonHeight
        anchors.bottom: row5.top
        anchors.bottomMargin: keyboardMargin
        anchors.left: parent.left
        anchors.leftMargin: keyboardMargin
        anchors.right: parent.right
        anchors.rightMargin: keyboardMargin
        spacing: keyboardMargin

        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: qsTr("Esc")
            shiftedText: qsTr("Esc")
            key: Qt.Key_Escape
            topRow: true
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: ";"
            shiftedText: ":"
            key: Qt.Key_Semicolon
            topRow: true
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "#"
            shiftedText: "~"
            key: Qt.Key_NumberSign
            topRow: true
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "["
            shiftedText: "{"
            key: Qt.Key_BracketLeft
            topRow: true
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "]"
            shiftedText: "}"
            key: Qt.Key_BracketRight
            topRow: true
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "`"
            shiftedText: "¬"
            key: Qt.Key_Dead_Grave
            topRow: true
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "-"
            shiftedText: "_"
            key: Qt.Key_Minus
            topRow: true
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "="
            shiftedText: "+"
            key: Qt.Key_Equal
            topRow: true
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "\\"
            shiftedText: "|"
            key: Qt.Key_Backslash
            topRow: true
        }
        KeyboardButton {
            width:          keyboardButtonWidth
            height:         parent.height
            icon:           master.imagePath + master.iconTheme + "/keyboard.png"
            onClicked:      toggleNativeKeyboard()
            showPreview:    false
        }
    }
    Row {
        id: row5
        y: 100
        height: keyboardButtonHeight
        anchors.bottom: row4.top
        anchors.bottomMargin: master.generalMargin/2
        anchors.left: parent.left
        anchors.leftMargin: master.generalMargin/2
        anchors.right: parent.right
        anchors.rightMargin: master.generalMargin/2
        spacing: master.generalMargin/2

        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "1"
            shiftedText: "!"
            key: Qt.Key_1
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "2"
            shiftedText: "\""
            key: Qt.Key_2
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "3"
            shiftedText: "£"
            key: Qt.Key_3
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "4"
            shiftedText: "$"
            key: Qt.Key_4
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "5"
            shiftedText: "%"
            key: Qt.Key_5
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "6"
            shiftedText: "^"
            key: Qt.Key_6
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "7"
            shiftedText: "&"
            key: Qt.Key_7
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "8"
            shiftedText: "*"
            key: Qt.Key_8
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "9"
            shiftedText: "()"
            key: Qt.Key_9
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "0"
            shiftedText: ")"
            key: Qt.Key_0
        }
    }
    Row {
        id: row4
        y: 100
        height: keyboardButtonHeight
        anchors.bottom: row3.top
        anchors.bottomMargin: master.generalMargin/2
        anchors.left: parent.left
        anchors.leftMargin: master.generalMargin/2
        anchors.right: parent.right
        anchors.rightMargin: master.generalMargin/2
        spacing: master.generalMargin/2

        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "q"
            shiftedText: "Q"
            key: Qt.Key_Q
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "w"
            shiftedText: "W"
            key: Qt.Key_W
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "e"
            shiftedText: "E"
            key: Qt.Key_E
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "r"
            shiftedText: "R"
            key: Qt.Key_R
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "t"
            shiftedText: "T"
            key: Qt.Key_T
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "y"
            shiftedText: "Y"
            key: Qt.Key_Y
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "u"
            shiftedText: "U"
            key: Qt.Key_U
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "i"
            shiftedText: "I"
            key: Qt.Key_I
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "o"
            shiftedText: "O"
            key: Qt.Key_O
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "p"
            shiftedText: "P"
            key: Qt.Key_P
        }
    }

    Row {
        id: row3
        y: 100
        height: keyboardButtonHeight
        anchors.bottom: row2.top
        anchors.bottomMargin: master.generalMargin/2
        anchors.left: parent.left
        anchors.leftMargin: master.generalMargin/2
        anchors.right: parent.right
        anchors.rightMargin: master.generalMargin/2
        spacing: master.generalMargin/2

        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "a"
            shiftedText: "A"
            key: Qt.Key_A
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "s"
            shiftedText: "S"
            key: Qt.Key_S
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "d"
            shiftedText: "D"
            key: Qt.Key_D
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "f"
            shiftedText: "F"
            key: Qt.Key_F
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "g"
            shiftedText: "G"
            key: Qt.Key_G
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "h"
            shiftedText: "H"
            key: Qt.Key_H
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "j"
            shiftedText: "J"
            key: Qt.Key_J
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "k"
            shiftedText: "K"
            key: Qt.Key_K
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "l"
            shiftedText: "L"
            key: Qt.Key_L
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "'"
            shiftedText: "@"
            key: Qt.Key_Apostrophe
        }
    }

    Row {
        id: row2
        y: 100
        height: keyboardButtonHeight
        anchors.bottom: row1.top
        anchors.bottomMargin: master.generalMargin/2
        anchors.left: parent.left
        anchors.leftMargin: master.generalMargin/2
        anchors.right: parent.right
        anchors.rightMargin: master.generalMargin/2
        spacing: master.generalMargin/2

        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "z"
            shiftedText: "Z"
            key: Qt.Key_Z
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "x"
            shiftedText: "X"
            key: Qt.Key_X
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "c"
            shiftedText: "C"
            key: Qt.Key_C
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "v"
            shiftedText: "V"
            key: Qt.Key_V
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "b"
            shiftedText: "B"
            key: Qt.Key_B
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "n"
            shiftedText: "N"
            key: Qt.Key_N
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "m"
            shiftedText: "M"
            key: Qt.Key_M
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: ","
            shiftedText: "<"
            key: Qt.Key_Comma
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "."
            shiftedText: ">"
            key: Qt.Key_Period
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            normalText: "/"
            shiftedText: "?"
            key: Qt.Key_Slash
        }
    }

    Row {
        id: row1
        y: 100
        height: keyboardButtonHeight
        anchors.bottom: parent.bottom
        anchors.bottomMargin: master.generalMargin/2
        anchors.left: parent.left
        anchors.leftMargin: master.generalMargin/2
        anchors.right: parent.right
        anchors.rightMargin: master.generalMargin/2
        spacing: master.generalMargin/2

        KeyboardButton2 {
            id: controlButton
            width: keyboardButtonWidth
            height: parent.height
            text: qsTr("Ctrl")
            checkable: true
        }
        KeyboardButton2 {
            id: altButton
            width: keyboardButtonWidth
            height: parent.height
            text: qsTr("Alt")
            checkable: true
        }
        KeyboardButton2 {
            id: shiftButton
            width: keyboardButtonWidth
            height: parent.height
            checkable: true
            icon: master.imagePath + master.iconTheme + "/shift.png"
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            key: Qt.Key_Left
            icon: master.imagePath + master.iconTheme + "/left.png"
            //iconMargin: 15
            showPreview: false
        }
        KeyboardButton {
            width: keyboardButtonWidth*3+2*keyboardMargin
            height: parent.height
            normalText: ""
            shiftedText: ""
            key: Qt.Key_Space
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            key: Qt.Key_Right
            icon: master.imagePath + master.iconTheme + "/right.png"
            //iconMargin: 15
            showPreview: false
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            key: Qt.Key_Return
            icon: master.imagePath + master.iconTheme + "/return.png"
            showPreview: false
        }
        KeyboardButton {
            width: keyboardButtonWidth
            height: parent.height
            key: Qt.Key_Backspace
            icon: master.imagePath + master.iconTheme + "/backspace.png"
            showPreview: false
        }
    }

    function modifierState()
    {
        var modifiers = Qt.NoModifier
        if (shiftChecked)
            modifiers |= Qt.ShiftModifier
        if (controlChecked)
            modifiers |= Qt.ControlModifier
        if (altChecked)
            modifiers |= Qt.AltModifier
        if (metaChecked)
            modifiers |= Qt.MetaModifier

        return modifiers
    }
}
