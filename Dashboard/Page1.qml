import QtQuick 2.14
/*
  Stworzenie pierwszej strony w palenu środkowym, ustawienie ikon oraz tekstów.

  First page in the middle panel. Contains car's basic information.
*/
Item {

    anchors.fill: parent
    Image {
        id: tank
        x: 430
        y: 170
        width: 30
        height: width
        source: "qrc:/Images/gas.png"
    }

    Image {
        id: arrow
        x: 470
        y: 175
        width: 20
        height: width
        source: "qrc:/Images/left.png"
    }

    Image {
        id: car
        x: 490
        y: 165
        width: 40
        height: width
        source: "qrc:/Images/car.png"
    }

    Text {
        id: distance
        text: avaiableDistance + " km"
        anchors.right: parent.right
        anchors.rightMargin: 425
        y: 162
        font.pixelSize: 35
        color: "white"
        Timer{
            interval: 5000
            repeat: true
            running: true
            triggeredOnStart: true
            onTriggered: {
                fuel()
            }
        }
    }

    Text {
        y: 270
        color: "white"
        text: qsTr("Śred.")
        anchors.left: parent.left
        font.pixelSize: 30
        anchors.leftMargin: 435
    }

    Text {
        id: consumption
        y: 270
        color: "white"
        font.pixelSize: 30
        anchors.right: consumptionText.left
        anchors.rightMargin: 5
        text: rpmValue == 0? "0": averageConsumption
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

        Timer{
            id: consumptionTimer
            interval: 60000
            repeat: true
            running: true
            triggeredOnStart: true
            onTriggered: {
                setAverage()
            }
        }
    }

    Text {
        id: consumptionText
        y: 270
        color: "white"
        text: qsTr("L/100km")
        anchors.right: parent.right
        anchors.rightMargin: 425
        font.pixelSize: 15
        anchors.bottom: consumption.bottom
        anchors.bottomMargin: 5
    }

    Text {
        id: odometer
        text: qsTr("5387 km")
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: 20
        anchors.rightMargin: 420
        font.pixelSize: 30
        color: "white"
    }
}
