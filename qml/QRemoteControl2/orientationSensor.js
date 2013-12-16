var myObject

function createOrientationSensor() {
    myObject = Qt.createQmlObject(
       "import QtQuick 2.0; \
        import QtSensors 5.0; \
        OrientationSensor { \
            id: orientation; \
            active: client.screenOrientation === 0; \
            onReadingChanged: { \
                if (reading.orientation === OrientationReading.TopUp)  \
                    master.screenRotation = 0; \
                else if (reading.orientation === OrientationReading.TopDown) \
                    master.screenRotation = 180; \
                else if (reading.orientation === OrientationReading.RightUp) \
                    master.screenRotation = 90; \
                else if (reading.orientation === OrientationReading.LeftUp) \
                    master.screenRotation = -90; \
                if (!device.landscapeMode) \
                    master.screenRotation += 90; \
                console.log(master.screenRotation); \
            } \
         }", master, "object")
}
