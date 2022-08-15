import QtQuick 2.14
import QtQml 2.14
import QtMultimedia 5.14

/*
  W tym pliku zawarta jest animacja prędkościomierza, wartość obrotomierza jest powiązana z predkościomierzem,
  w związku z tym animowany jest równocześnie obrotomierz. W tym pliku znajduje się również działanie
  poszczególnych przycisków i ich działanie.


   This file contains the speedometer animation, the tachometer value is linked to the speedometer,
   therefore, the tachometer is also animated. There are also defined actions of button controling dashboard.
*/


Item {

    property bool accelerating: false
    property bool breaking: false
    property var myTarget
    property int mygear: 1
    property int myInd: 0
    property int speed
    property bool startCar: false
    property bool turnRight: false
    property bool turnLeft: false
    property bool lights: false
    property bool handBrake: true
    property bool setGauges: false
    property var myId
    property bool playing: false
    property bool paused: true
    property bool stopped: false
    property bool sport: false
    property bool city: true
    property var myStateSpeedV1
    property var myStateSpeedV2
    property var backgroundState
    property var myState: "city"

    Keys.onSpacePressed: handBrake = (handBrake === true? false : true)


    function starting(){
        startCar = (startCar === true? false : true);
    }

    Timer{
        id: myTimer
        interval: 1000
        onTriggered: {
            starting();
        }
    }


    Keys.onReleased: {
        if(event.key === Qt.Key_S){
            breaking = false;
            event.accepted = true;
        }

        if(event.key === Qt.Key_W){
            accelerating = false;
            event.accepted = true;
        }
    }

    Keys.onPressed: {

        if(event.key === Qt.Key_W){
            accelerating = true;
            event.accepted = true;
        }

        if(event.key === Qt.Key_M){

            if(playing === false){
               myId.play();
                stopped = false;
                playing = true;
                paused = false;
            }else{
                myId.pause();
                stopped = false;
                playing = false;
                paused = true;
            }
            event.accepted = true;
        }

        if(event.key === Qt.Key_N){
            myId.stop();
            stopped = false;
            playing = false;
            paused = true;
            event.accepted = true;
        }


        if(event.key === Qt.Key_S){
            breaking = true;
            event.accepted = true;
        }

        if(event.key === Qt.Key_D){
            setGauges = (setGauges === true? false : true);
            myTimer.running = true;
            event.accepted = true;
        }

        if(event.key === Qt.Key_E){
            turnRight = (turnRight== false? true : false);
            turnLeft = false;
            event.accepted = true;
        }

        if(event.key === Qt.Key_Q){
            turnLeft = (turnLeft== false? true : false);
            turnRight = false;
            event.accepted = true;
        }

        if(event.key === Qt.Key_L){
            lights = (lights== false? true : false);
            event.accepted = true;
        }

        if (event.key === Qt.Key_1){
            myState = "city"
            event.accepted = true;
        }
        if(event.key === Qt.Key_2){
            myState = "sport"
            event.accepted = true;
        }

    }



    Keys.onUpPressed:{
        if(mygear === 0 && myTarget.value > 0){
        }else if(mygear < 6){
            mygear++
        }else{}
    }
    Keys.onDownPressed:{
        if (mygear > 1){
            mygear--
        }else if (myTarget.value === 0 && mygear === 1){
            mygear--
        }else{

        }
    }

    Keys.onRightPressed: {
        if(myInd == 3){
            myInd =  0

        }else{
            myInd++
        }
    }
    Keys.onLeftPressed: {
        if(myInd == 0){
            myInd =  3

        }else{
            myInd--
        }
    }

    Component.onCompleted: forceActiveFocus()

        ParallelAnimation{
            running: accelerating && startCar
            NumberAnimation{
                target: myTarget
                properties: "value"
                to: myTarget.maximumValue
                duration: 10000-myTarget.value*40
            }
        }

        ParallelAnimation{
            running: !accelerating && !breaking
            NumberAnimation{
                target: myTarget
                properties: "value"
                to: 0
                duration: speed
            }
        }

        ParallelAnimation{
            running: !accelerating && breaking
            NumberAnimation{
                target: myTarget
                properties: "value"
                to: 0
                duration: speed/3
            }
        }

}
