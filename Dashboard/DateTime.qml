import QtQuick 2.14
import QtGraphicalEffects 1.14
/*
  W tym pliku znajduje się nagłówek panelu środkowego, który wyświetla czas, datę i ikony dla poszczególnego panelu.

  This file contains header definiton of the middle panel which displays date, time and icons for individual panels.
*/

Item {
    anchors.fill: parent
    anchors.horizontalCenter: parent.horizontalCenter
    property bool myIndex
    property int ind
    property int page3liczba1




    Text {
        id: timeText
        width: parent.width
        height: 31
        color: ind != 3? "white" : myIndex === true? "white" : "black"
        anchors.top: dateText.bottom
        anchors.topMargin: 7
        property string timeString


        function set(){
            var locale = Qt.locale()
            var currentTime = new Date()
            timeString = currentTime.toLocaleTimeString(locale, Locale.LongFormat);
            timeText.text = timeString
        }

        Timer{
            id: textTimer
            interval: 1000
            repeat: true
            running: true
            triggeredOnStart: true
            onTriggered: {
                timeText.set()
            }
        }

        font.pixelSize: 30
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        id: dateText
        width: parent.width
        height: 16
        color: ind != 3? "white" : myIndex=== true? "white" : "black"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.top: parent.top
        anchors.topMargin: 20
        font.pixelSize: 20
        property string dateString
        function set(){
            var locale = Qt.locale()
            var currentDate = new Date()
            dateString = currentDate.toLocaleDateString(locale, Locale.LongFormat);
            dateText.text = dateString
        }

        Component.onCompleted: set()
    }

    Rectangle{
        id: icons
        width: 600
        height: 70
        anchors.top: timeText.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"

        Row{
            anchors.fill: parent
            visible: ind != 3? true :false
            Rectangle{
                height: parent.height
                width: parent.width/4
                color: "transparent"

                Image {
                    id: info
                    source: "qrc:/Images/info.png"
                    width: 35
                    height: width
                    smooth: true
                    anchors.centerIn: parent
                }

                ColorOverlay{
                    anchors.fill: info
                    source: info
                    color: "dodgerblue"
                    visible: view.currentIndex === 0
                }

            }
            Rectangle{
                height: parent.height
                width: parent.width/4
                color: "transparent"

                Image {
                    id: music
                    source: "qrc:/Images/music.png"
                    width: 35
                    height: width
                    smooth: true
                    anchors.centerIn: parent
                }

                ColorOverlay{
                    anchors.fill: music
                    source: music
                    color: "dodgerblue"
                    visible: view.currentIndex === 1
                }

            }
            Rectangle{
                height: parent.height
                width: parent.width/4
                color: "transparent"

                Image {
                    id: error
                    source: "qrc:/Images/error.png"
                    width: 45
                    height: width
                    smooth: true
                    anchors.centerIn: parent
                }

                ColorOverlay{
                    anchors.fill: error
                    source: error
                    color: view.currentIndex === 2? "dodgerblue" : page3liczba1 > 0? "red" : "dodgerblue"
                    visible: page3liczba1 > 0? true : view.currentIndex === 2



                }

            }

            Rectangle{
                height: parent.height
                width: parent.width/4
                color: "transparent"

                Image {
                    id: map
                    source: "qrc:/Images/map.png"
                    width: 35
                    height: width
                    smooth: true
                    anchors.centerIn: parent
                }
            }
        }

    }
}
