import QtQuick 2.14
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.14
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.14

/*
  Ten plik jest zbliżony do "Speedometer.qml", zakres jest do 8000, a wartość wskazania jest zależna od
  biegu i wskazania prędkościomierza, "Canvas" zostało wykorzystane w podobny sposób.

  File containing tachometer definition. It was defined similar to speedometer. The main difference is in displayed
  values.
*/

CircularGauge{
    id: gauge
    width: 500
    height: width
    maximumValue: 8000


    property int gear: 1
    property var speedometerV
    property bool carStarted: false


    function gears(gear){
        if(gear === 1){
            return 80
        }else if(gear === 2){
            return 55
        }else if(gear === 3){
            return 38
        }else if(gear === 4){
            return 27
        }else if(gear === 5){
            return 22
        }else if(gear === 6){
            return 15
        }else if(gear === 0){
            return 45
        }

    }


    value: (speedometerV.value*gears(gear))

    style: CircularGaugeStyle{
        labelStepSize: 1000
        labelInset: outerRadius * -0.07
        tickmarkInset: outerRadius*0.07
        background: Rectangle{
            id: backgroundRect
            color: "transparent"
            radius: 360
            function toPixels(percentage) {
                return percentage * outerRadius;
            }

            Canvas{
                property real xCenter: outerRadius
                property real yCenter: outerRadius
                property int value: gauge.value
                anchors.fill: parent

                onValueChanged: requestPaint()

                function degreesToRadians(degrees) {
                    return degrees * (Math.PI / 180);
                }

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();
                    var gradient = ctx.createRadialGradient(xCenter, yCenter, outerRadius * 0.6 , xCenter, yCenter, outerRadius);
                    gradient.addColorStop(0, Qt.rgba(0.12, 0.56, 1.0, 0.0));
                    gradient.addColorStop(0.3, Qt.rgba(0.12, 0.56, 1.0, 0.4));
                    gradient.addColorStop(1, Qt.rgba(0.12, 0.56, 1.0, 1));
                    var gradientR = ctx.createRadialGradient(xCenter, yCenter, outerRadius * 0.6 , xCenter, yCenter, outerRadius);
                    gradientR.addColorStop(0, Qt.rgba(1, 0, 0, 0.0));
                    gradientR.addColorStop(0.3, Qt.rgba(1, 0, 0, 0.4));
                    gradientR.addColorStop(1, Qt.rgba(1 , 0, 0, 1));
                    var gradientY = ctx.createRadialGradient(xCenter, yCenter, outerRadius * 0.6 , xCenter, yCenter, outerRadius);
                    gradientY.addColorStop(0, Qt.rgba(1, 0.84, 0, 0.0));
                    gradientY.addColorStop(0.3, Qt.rgba(1, 0.84, 0, 0.3));
                    gradientY.addColorStop(1, Qt.rgba(1 , 0.84, 0, 1));
                    ctx.beginPath();
                    ctx.strokeStyle = gauge.value == 0 ? "black" : gauge.value >= 6500? gradientR :gauge.value >= 5000? gradientY :gradient
                    ctx.lineWidth = 100
                    ctx.arc(outerRadius,
                            outerRadius,
                            outerRadius*0.95 - ctx.lineWidth/2 ,
                            degreesToRadians(valueToAngle(gauge.minimumValue ) - 90),
                            degreesToRadians(valueToAngle(gauge.value ) - 90));
                    ctx.stroke();

                    ctx.beginPath();
                    ctx.strokeStyle = "white";
                    ctx.lineWidth = 5;
                    ctx.arc(outerRadius,
                            outerRadius,
                            outerRadius*0.99,
                            degreesToRadians(valueToAngle(gauge.minimumValue ) - 90)
                            , degreesToRadians(valueToAngle(6500) -90));
                    ctx.stroke();

                    ctx.beginPath();
                    ctx.strokeStyle = "red";
                    ctx.lineWidth = 5;
                    ctx.arc(outerRadius,
                            outerRadius,
                            outerRadius*0.99,
                            degreesToRadians(valueToAngle(6500 ) - 90)
                            , degreesToRadians(valueToAngle(gauge.maximumValue +1) -90));
                    ctx.stroke();


                }
            }


            Rectangle{
                id: rectId
                anchors.centerIn: parent
                width: outerRadius*0.78
                height: width
                color: "black"
                radius: 360

                Text {
                    id: rotationText
                    font.pixelSize: toPixels(0.25)
                    text: (kphInt-kphInt%100)
                    color: "white"
                    horizontalAlignment: Text.AlignRight
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: rectId.top
                    anchors.topMargin: toPixels(0.07)

                    readonly property int kphInt: control.value
                }
                Text {
                    text: "RPM"
                    color: "white"
                    font.pixelSize: toPixels(0.07)
                    anchors.top: rotationText.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    id: gearText
                    font.pixelSize: toPixels(0.25)
                    text: !carStarted? "P" : gear === 0? "R" : gear
                    color: "white"
                    horizontalAlignment: Text.AlignRight
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: rectId.bottom
                    anchors.bottomMargin: 10
                    anchors.topMargin: toPixels(0.1)


                    readonly property int kphInt: control.value
                }


            }

            InnerShadow {
                anchors.fill: rectId
                radius: 20
                samples: 24
                horizontalOffset: -3
                verticalOffset: 3
                color: "#00bfff"
                source: rectId

            }
        }

        foreground: null

        minorTickmark: null

        tickmark:Rectangle {
            visible: styleData.value %500 == 0
            implicitWidth: outerRadius * 0.015
            implicitHeight: styleData.value%1000?outerRadius * 0.05 : outerRadius * 0.1
            antialiasing: true
            color: styleData.value >= 6500 ? "red" : "white"
            radius: 20
        }

        tickmarkLabel: Text{
            font.pixelSize: Math.max(6, outerRadius * 0.1)
            text: styleData.value/1000
            color: styleData.value >= 6500 ? "red" : styleData.value <= gauge.value? "dodgerblue" :  "white"

        }

        needle: Canvas {
            function toPixels(percentage) {
                return percentage * outerRadius;
            }
            property real needleLength: outerRadius - tickmarkInset * 1.25
            property real needleTipWidth: toPixels(0.02)
            property real needleBaseWidth: toPixels(0.03)
            implicitWidth: needleBaseWidth
            implicitHeight: needleLength

            property real xCenter: width / 2
            property real yCenter: 4*(height / 7)

            onPaint: {
                var ctx = getContext("2d");
                ctx.reset();

                ctx.beginPath();
                ctx.moveTo(xCenter, yCenter);
                ctx.lineTo(xCenter - needleBaseWidth,  yCenter);
                ctx.lineTo(xCenter, 0 + 4*needleBaseWidth);
                ctx.closePath();
                ctx.fillStyle = "crimson"
                ctx.strokeStyle = "crimson";
                ctx.lineWidth = 2;
                ctx.fill();
                ctx.stroke();

                ctx.beginPath();
                ctx.moveTo(xCenter, yCenter);
                ctx.lineTo(xCenter + needleBaseWidth,  yCenter);
                ctx.lineTo(xCenter, 0 + 4*needleBaseWidth);
                ctx.closePath();
                ctx.fillStyle = "crimson"
                ctx.strokeStyle = "crimson";
                ctx.lineWidth = 2;
                ctx.fill();
                ctx.stroke();

            }
        }
    }

}
