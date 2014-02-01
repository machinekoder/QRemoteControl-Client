var myObject

function createHaptic() {
    myObject = Qt.createQmlObject("import QtQuick 2.0; import QtMobility.feedback 1.1; ThemeEffect{ id: basicHapticEffect; effect: ThemeEffect.BasicButton}", base, "object")
}

function playHaptic() {
    myObject.play();
}
