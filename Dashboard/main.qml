import QtQuick 2.14
import QtQuick.Window 2.14
import QtGraphicalEffects 1.14

/*
  Ten plik odpowiada za połączenie wszystkich plików, stworzenie gradientu tła oraz przypisanie "properties"
  między plikami.

  The main file assembling all defined elements and properties.
*/
Window {
    id: root
    visible: true
    width: 1920
    height: 720
    title: qsTr("Dashboard")
    color: "black"

    //Positioning elements in main window using "columns"
    Column{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: 10

        Rectangle{
            width: 300
            height: 50
            color: "transparent"
            anchors.horizontalCenter: parent.horizontalCenter

            Icons{
                id: iconId
                turningR: anim.turnRight
                turningL: anim.turnLeft
                engineWarning: tachometer.value >= 6500? true : false
                lights: anim.lights
                handBrakeOn: anim.handBrake
            }
        }



        Swipe{
            id: swipe
            ind: anim.myInd
            speedText: speedometer.value
            rpmValue: tachometer.value
            fuelValue: fuelId.fuelValue
            playing: anim.playing
            stopped: anim.stopped
            paused: anim.paused

        }
    }
    //Speedometer positioning
    Rectangle{
        id: speedRect
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        width: speedometer.width*1.2
        height: speedometer.width*1.2
        radius: 360
        LinearGradient {
            anchors.fill: parent
            source: speedRect
            start: Qt.point(0, parent.height/2)
            end: Qt.point(parent.width, parent.height)
            gradient: Gradient {
                GradientStop {id: id1; position: 0; color: Qt.rgba(0.0,0.0,0.0,0.6)}
                GradientStop {id: id2; position: 0.1; color: Qt.rgba(0.0,0.0,0.0,1)  }
                GradientStop {id: id3; position: 0.2; color: "black" }
                GradientStop {id: id4; position: 0.5; color: Qt.rgba(0.0,0.0,0.0,0.6) }
                GradientStop {id: id5; position: 0.53; color: Qt.rgba(0.0,0.0,0.0,0.8)}
                GradientStop {id: id6; position: 1; color: Qt.rgba(0.0,0.0,0.0,1) }
            }
        }

        //Fuel gauge positioning
        FuelGauge{
            id: fuelId
            anchors.centerIn: parent
            combustion: speedometer.value
            run: anim.accelerating && anim.startCar
            carStarted: anim.setGauges
        }

        //City and sport view of the speedometer
        Speedometer{
            id: speedometer
            anchors.centerIn: parent
        }
        SpeedometerV2{
            id: speedometerV2
            myValue: speedometer.value
            anchors.centerIn: speedometer
        }
    }

    //Tachometer positioning
    Rectangle{
        id: tachoRect
        width: tachometer.width*1.2
        height: tachometer.height*1.2
        radius: 360
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        LinearGradient {
            anchors.fill: parent
            source: tachoRect
            start: Qt.point(0, parent.height/2)
            end: Qt.point(parent.width, parent.height)
            gradient: Gradient {
                GradientStop {  id: idT1; position: 0; color: Qt.rgba(0.0,0.0,0.0,0.6)}
                GradientStop {  id: idT2;  position: 0.1; color: Qt.rgba(0.0,0.0,0.0,1)  }
                GradientStop {  id: idT3; position: 0.2; color: "black" }
                GradientStop {  id: idT4; position: 0.5; color: Qt.rgba(0.0,0.0,0.0,0.6) }
                GradientStop {  id: idT5; position: 0.53; color: Qt.rgba(0.0,0.0,0.0,0.8)}
                GradientStop {  id: idT6; position: 1; color: Qt.rgba(0.0,0.0,0.0,1) }
            }
        }

        //City and sport view of the tachometer
        Tachometer{
            id: tachometer
            anchors.centerIn: parent
            speedometerV: speedometer
            gear: anim.mygear
            carStarted: anim.setGauges
            anchors.topMargin:200

        }

        TachometerV2{
            id: tachometerV2
            anchors.centerIn: tachometer
            myValue: tachometer.value
            myGear: tachometer.gear
            carStarted: anim.setGauges
        }
        //Temperature gauge positioning
        TemperatureGauge{
            anchors.centerIn: parent
            carStarted: anim.setGauges
        }
    }

    //Transition animation between city and sport view
    Animated{
        id: anim
        myTarget: speedometer
        mygear: tachometer.gear
        myInd: swipe.ind
        speed: speedometer.value*50
        myId: swipe.myId
        myStateSpeedV1: speedometer
        myStateSpeedV2: speedometerV2
    }

    Item{
        id: myId
        states: [
            State {
                name: "city"
                PropertyChanges {
                    target: speedometer
                    opacity: 1

                }
                PropertyChanges {
                    target: speedometerV2
                    opacity: 0


                }

                PropertyChanges {
                    target: tachometer
                    opacity: 1

                }

                PropertyChanges {
                    target: tachometerV2
                    opacity: 0

                }
            },

            State {
                name: "sport"
                PropertyChanges {
                    target: speedometer
                    opacity: 0

                }

                PropertyChanges {
                    target: speedometerV2
                    opacity: 1

                }

                PropertyChanges {
                    target: tachometer
                    opacity: 0

                }

                PropertyChanges {
                    target: tachometerV2
                    opacity: 1

                }

                PropertyChanges {
                    target: id1
                    color: "black"
                }

                PropertyChanges {
                    target: id2
                    color: "black"
                }

                PropertyChanges {
                    target: id3
                    color: "black"
                }

                PropertyChanges {
                    target: id4
                    color: "black"
                }

                PropertyChanges {
                    target: id5
                    color: "black"
                }

                PropertyChanges {
                    target: id6
                    color: "black"
                }

                PropertyChanges {
                    target: idT1
                    color: "black"
                }

                PropertyChanges {
                    target: idT2
                    color: "black"
                }

                PropertyChanges {
                    target: idT3
                    color: "black"
                }

                PropertyChanges {
                    target: idT4
                    color: "black"
                }

                PropertyChanges {
                    target: idT5
                    color: "black"
                }

                PropertyChanges {
                    target: idT6
                    color: "black"
                }

                PropertyChanges {
                    target: swipe.swipeC1
                    color: Qt.rgba(1.0,0.0,0.0,1.0)
                }

                PropertyChanges {
                    target: swipe.swipeC2
                    color: Qt.rgba(0.53,0.085,0.085,1)
                }

                PropertyChanges {
                    target: swipe.swipeC3
                    color: "black"
                }

                PropertyChanges {
                    target: swipe.swipeC4
                    color: Qt.rgba(0.53,0.085,0.085,1)
                }

                PropertyChanges {
                    target: swipe.swipeC5
                    color: Qt.rgba(0.0,0.0,0.0,0.9)
                }

                PropertyChanges {
                    target: swipe.swipeC6
                    color: Qt.rgba(0.53,0.085,0.085,1)
                }
            }
        ]

        state: anim.myState

        transitions: [
            Transition {
                from: "city"
                to: "sport"

                ColorAnimation {
                    duration: 1000
                }
                NumberAnimation{
                    properties: "opacity"
                    duration: 1000
                }

            },

            Transition {
                from: "sport"
                to: "city"

                ColorAnimation {
                    duration: 1000
                }
                NumberAnimation{
                    properties: "opacity"
                    duration: 1000
                }

            }
        ]
    }


}

