import QtQuick 2.14
import QtGraphicalEffects 1.14

/*
  W tym pliku załączane są ikony wskaźników, które znajdują się nad panelem środkowym.

  This file contains definition of indicators icons.
*/

Item {
    id: root
    anchors.fill: parent
    property bool turningR: false
    property bool turningL: false
    property bool lights: false
    property bool engineWarning: false
    property bool handBrakeOn: true
    Image {
        id: whiteRArrow
        width: 50
        height: 50
        source: "Images/right_white.png"
        anchors.right: parent.right
    }

    Image {
        id: greenRArrow
        width: 50
        height: 50
        source: "Images/right_green.png"
        anchors.right: parent.right
    }

    Image {
        id: whiteLArrow
        width: 50
        height: 50
        source: "Images/left_white.png"

    }

    Image {
        id: greenLArrow
        width: 50
        height: 50
        source: "Images/left_green.png"

    }

    Image {
        id: engine
        source: "Images/engine.png"
        width: 50
        height: 40
        anchors.left: greenLArrow.right
        anchors.leftMargin: 20
        opacity: 0.3
        visible: !engineWarning
    }

    Image {
        id: lowBeam
        source: "Images/lowbeam.png"
        width: 40
        height: 40
        anchors.left: engine.right
        anchors.leftMargin: 20
        opacity: 0.3
        visible: !lights

    }

    Image {
        id: handBrake
        source: "Images/handBrake.png"
        width: 40
        height: 40
        anchors.left: lowBeam.right
        anchors.leftMargin: 20
        opacity: 0.3
        visible: !handBrakeOn

    }

    ColorOverlay{
        anchors.fill: engine
        source: engine
        color: Qt.rgba(1.0,0.7,0,1)
        visible: engineWarning
    }

    ColorOverlay{
        anchors.fill: lowBeam
        source: lowBeam
        color: "limegreen"
        visible: lights
    }

    ColorOverlay{
        anchors.fill: handBrake
        source: handBrake
        color: "red"
        visible: handBrakeOn
    }


    states: [

        State {
            name: "activeR"
            PropertyChanges {
                target: whiteRArrow
                opacity: 0

            }

            PropertyChanges {
                target: greenRArrow
                opacity: 1

            }

            PropertyChanges {
                target: whiteLArrow
                opacity: 0.3

            }

            PropertyChanges {
                target: greenLArrow
                opacity: 0

            }
        },


        State {
            name: "inActive"
            PropertyChanges {
                target: whiteRArrow
                opacity: 0.3

            }

            PropertyChanges {
                target: greenRArrow
                opacity: 0

            }

            PropertyChanges {
                target: whiteLArrow
                opacity: 0.3

            }

            PropertyChanges {
                target: greenLArrow
                opacity: 0

            }
        },

        State {
            name: "activeL"
            PropertyChanges {
                target: whiteRArrow
                opacity: 0.3

            }

            PropertyChanges {
                target: greenRArrow
                opacity: 0

            }

            PropertyChanges {
                target: whiteLArrow
                opacity: 0

            }

            PropertyChanges {
                target: greenLArrow
                opacity: 1

            }
        }

    ]

    function animTurn(){

        if(!turningL&&!turningR){
            root.state = "inActive"
        }else if(turningL){
            root.state = (root.state === ("inActive" || "activeR")? "activeL" : "inActive")
        }else if(turningR){
            root.state = (root.state === ("inActive" || "activeL")? "activeR" : "inActive")
        }
    }

    Timer{
        id: iconTimer
        interval: 1000
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: {
            animTurn()
        }

    }

}
