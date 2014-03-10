import QtQuick 2.0

Item {
    property string name: ""
    property string previous: ""
    property string source: ""

    signal showItem(string name)

    id: main

    width: 400
    height: 600
}
