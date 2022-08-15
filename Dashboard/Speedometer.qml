import QtQuick 2.14
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.14
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.14

/*
  Ten plik odpowiada za stworzenie prędkościomierza, za pomocą "Canvas" tworzony jest wygląd igły wskaźnika jak i "RadialGradient",
  który tworzony jest na podstawie aktualnej wartości wskazania.

  File containing speedometer definition.

*/

CircularGauge{
    id: gauge
    width: 500
    height: width
    maximumValue: 250

    style: CircularGaugeStyle{
        id: myStyle
        labelStepSize: 20
        labelInset: outerRadius * -0.085
        minimumValueAngle: -150
        maximumValueAngle: 150
        tickmarkInset: outerRadius*0.07

        background: Rectangle{
            id: backgroundRect
            color: "transparent"
            radius: 360            
            property int fuel: fuelId.value
            //Creating unique view of a speedometer using canvas
            Canvas{
                property real xCenter: outerRadius
                property real yCenter: outerRadius
                property int value: gauge.value
                anchors.fill: parent


                onValueChanged: requestPaint()

                function degreesToRadians(degrees) {
                    return degrees * (Math.PI / 180);
                }
                //Drawing arc depending on speedometer value
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();
                    var gradient = ctx.createRadialGradient(xCenter, yCenter, outerRadius * 0.6 , xCenter, yCenter, outerRadius);
                    gradient.addColorStop(0, Qt.rgba(0.12, 0.56, 1.0, 0.05));
                    gradient.addColorStop(0.3, Qt.rgba(0.12, 0.56, 1.0, 0.4));
                    gradient.addColorStop(1, Qt.rgba(0.12, 0.56, 1.0, 1));
                    var gradientR = ctx.createRadialGradient(xCenter, yCenter, outerRadius * 0.6 , xCenter, yCenter, outerRadius);
                    gradientR.addColorStop(0, Qt.rgba(1, 0, 0, 0.05));
                    gradientR.addColorStop(0.3, Qt.rgba(1, 0, 0, 0.4));
                    gradientR.addColorStop(1, Qt.rgba(1 , 0, 0, 1));
                    ctx.beginPath();
                    ctx.strokeStyle = gauge.value == 0 ? "black" : gauge.value >= 220? gradientR :gradient
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
                            , degreesToRadians(valueToAngle(220) -90));
                    ctx.stroke();

                    ctx.beginPath();
                    ctx.strokeStyle = "red";
                    ctx.lineWidth = 5;
                    ctx.arc(outerRadius,
                            outerRadius,
                            outerRadius*0.99,
                            degreesToRadians(valueToAngle(220 ) - 90)
                            , degreesToRadians(valueToAngle(gauge.maximumValue +1) -90));
                    ctx.stroke();


                }
            }

            function toPixels(percentage) {
                return percentage * outerRadius;
            }

            Rectangle{
                id: rectId
                anchors.centerIn: parent
                width: outerRadius*0.78
                height: width
                color: "black"
                radius: 360

                Text {
                    id: speedText
                    font.pixelSize: toPixels(0.25)
                    text: kphInt
                    color: "white"
                    horizontalAlignment: Text.AlignRight
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: rectId.top
                    anchors.topMargin: 40

                    readonly property int kphInt: control.value
                }
                Text {
                    text: "km/h"
                    color: "white"
                    font.pixelSize: toPixels(0.07)
                    anchors.top: speedText.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
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


        tickmark: Rectangle {
            implicitWidth: outerRadius * 0.015
            implicitHeight: styleData.value%20?outerRadius * 0.05 : outerRadius * 0.1
            antialiasing: true
            color: styleData.value >= 220 ? "red" : "white"
            radius: 20
        }

        minorTickmark: null

        tickmarkLabel: Text{
            font.pixelSize: Math.max(6, outerRadius * 0.1)
            text: styleData.value
            color: styleData.value >= 220 ? "red" : styleData.value <= gauge.value? "dodgerblue" :  "white"
        }
        //Creating new pointing needle using canvas
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
                ctx.lineTo(xCenter, 0+ 4*needleBaseWidth);
                ctx.closePath();
                ctx.fillStyle = "crimson"
                ctx.strokeStyle = "crimson";
                ctx.lineWidth = 2;
                ctx.fill();
                ctx.stroke();

                ctx.beginPath();
                ctx.moveTo(xCenter, yCenter);
                ctx.lineTo(xCenter + needleBaseWidth,  yCenter);
                ctx.lineTo(xCenter, 0+ 4*needleBaseWidth);
                ctx.fillStyle = "crimson"
                ctx.strokeStyle = "crimson";
                ctx.lineWidth = 2;
                ctx.fill();
                ctx.stroke();

            }

        }

    }

}
