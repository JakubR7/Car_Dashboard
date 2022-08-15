import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import QtGraphicalEffects 1.14
import QtQml 2.14

/*
  Plik łączący przygotowane 4 panele w jednym panelu środkowym.
  File connecting 4 predefined panels in one middle panel using "swipeview".
*/

Rectangle{
    id: swipeId
    height: 540
    width: 1250
    border.color: "black"
    border.width: 0.5
    clip: true
    LinearGradient {
        anchors.fill: parent
        start: Qt.point(0, parent.height/2)
        end: Qt.point(parent.width, parent.height)
        gradient: Gradient {
            GradientStop {id: swipe1; position: 0; color: Qt.rgba(0.0,0.0,0.0,0.6)}
            GradientStop {id: swipe2; position: 0.1; color: Qt.rgba(0.0,0.0,0.0,1)  }
            GradientStop {id: swipe3; position: 0.2; color: "black" }
            GradientStop {id: swipe4; position: 0.5; color: Qt.rgba(0.0,0.0,0.0,0.6) }
            GradientStop {id: swipe5; position: 0.53; color: Qt.rgba(0.0,0.0,0.0,0.8)}
            GradientStop {id: swipe6; position: 1; color: Qt.rgba(0.0,0.0,0.0,1) }
        }

    }

    property int ind
    property int speedText
    property int rpmValue
    property double averageConsumption
    property int fuelValue
    property int avaiableDistance: 0
    property alias myId: myPage2.myId
    property bool playing
    property bool paused
    property bool stopped
    property var swipeC1: swipe1
    property var swipeC2: swipe2
    property var swipeC3: swipe3
    property var swipeC4: swipe4
    property var swipeC5: swipe5
    property var swipeC6: swipe6


    function setAverage(){
        if(rpmValue <= 2000){
            averageConsumption = Math.round(100*(Math.random()*1.5+5))/100
        }else if( rpmValue > 2000 && rpmValue <= 4000 ){
            averageConsumption = Math.round(100*(Math.random()*1.5+6))/100
        }else if( rpmValue > 4000 && rpmValue <= 6000 ){
            averageConsumption = Math.round(100*(Math.random()*1.5+7))/100
        }else{
            averageConsumption = Math.round(100*(Math.random()*1.5+8))/100
        }
    }

    function fuel(){
        avaiableDistance = (fuelValue/averageConsumption) * 500
    }
    //Displaying date and time in panels, except for a GPS panel
    DateTime{
        id: dateTime
        ind: view.currentIndex
        z:1
        myIndex: myMap.myIndex
        page3liczba1: myPage3.page3liczba

    }
    //Panels implementation
    SwipeView {
        id: view
        anchors.fill: parent
        currentIndex: ind

        Rectangle {
            id: page1
            color: "transparent"

            Page1{}

        }
        Rectangle {
            id: page2
            color: "transparent"
            Page2{
                id: myPage2
                playing: swipeId.playing
                paused: swipeId.paused
                stopped: swipeId.stopped
            }
        }

        Rectangle {
            id: page3
            color: "transparent"
            Page3{
                id:myPage3
            }
        }

        Rectangle {
            id: page4
            Page4{
                id: myMap
            }

            MapAnimation{
                myTarget: myMap.myTarget
            }



        }
    }

    PageIndicator {
        id: indicator
        count: view.count
        currentIndex: view.currentIndex
        anchors.bottom: view.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
