// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0
import "MyComponents/"
//import MyComponents 1.0

Button {
    id:             keyboardButton
    width:          100
    height:         62
    border.width:   1
    font.pixelSize: keyboardMain.textSize
    iconRotation:   master.screenRotation-keyboard.rotation
    textRotation:   master.screenRotation-keyboard.rotation
    animated:       (mainRect.state == "keyboardPageState")

}
