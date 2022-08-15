import QtQuick 2.14
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.14
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.14

/* Plik zawiera definicję wyglądu prędkościomierza w sportowej wersji.
   File contains speedometer definition in sport view.

*/
CircularGauge{
    id: gauge
    width: 500
    height: width
    maximumValue: 250
    property var myValue

    value: myValue
    style: CircularGaugeStyle{
        id: myStyle
        labelStepSize: 10
        labelInset: outerRadius * -0.03
        minimumValueAngle: -150
        maximumValueAngle: 150
        tickmarkInset: outerRadius*0.02

        background: Rectangle{
            id: backgroundRect
            color: "transparent"
            radius: 360

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


                    var gradientR2 = ctx.createRadialGradient(xCenter, yCenter, outerRadius * 0.6 , xCenter, yCenter, outerRadius);
                    gradientR2.addColorStop(0, Qt.rgba(1, 0, 0, 0.05));
                    gradientR2.addColorStop(0.3, Qt.rgba(1, 0, 0, 0.2));
                    gradientR2.addColorStop(1, Qt.rgba(1 , 0, 0, 0.5));
                    ctx.beginPath();
                    ctx.lineWidth = 100;
                    ctx.strokeStyle = gradientR2
                    ctx.arc(outerRadius,
                            outerRadius,
                            outerRadius*0.95 - ctx.lineWidth/2 ,
                            degreesToRadians(valueToAngle(gauge.minimumValue ) - 90),
                            degreesToRadians(valueToAngle(gauge.maximumValue ) - 90));
                    ctx.stroke();


                    var gradient = ctx.createRadialGradient(xCenter, yCenter, outerRadius * 0.6 , xCenter, yCenter, outerRadius);
                    gradient.addColorStop(0, Qt.rgba(0.12, 0.56, 1.0, 0.05));
                    gradient.addColorStop(0.3, Qt.rgba(0.12, 0.56, 1.0, 0.4));
                    gradient.addColorStop(1, Qt.rgba(0.12, 0.56, 1.0, 1));
                    var gradientR = ctx.createRadialGradient(xCenter, yCenter, outerRadius * 0.6 , xCenter, yCenter, outerRadius);
                    gradientR.addColorStop(0, Qt.rgba(1, 0, 0, 0.05));
                    gradientR.addColorStop(0.3, Qt.rgba(1, 0, 0, 0.4));
                    gradientR.addColorStop(1, Qt.rgba(1 , 0, 0, 1));
                    ctx.beginPath();
                    ctx.strokeStyle = gauge.value == 0 ? "black" : gradientR
                    ctx.lineWidth = 100
                    ctx.arc(outerRadius,
                            outerRadius,
                            outerRadius*0.95 - ctx.lineWidth/2 ,
                            degreesToRadians(valueToAngle(gauge.minimumValue ) - 90),
                            degreesToRadians(valueToAngle(gauge.value ) - 90));
                    ctx.stroke();

                }
            }

            function toPixels(percentage) {
                return percentage * outerRadius;
            }

            Rectangle{
                id: rectId
                anchors.centerIn: parent
                width: outerRadius*0.83
                radius: 360
                height: width
                color: "black"

                Text {
                    id: speedText
                    font.pixelSize: toPixels(0.25)
                    text: kphInt
                    color: kphInt >=220? "yellow" : "white"
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
                samples: 24
                radius: 60
                verticalOffset: 0
                color: "red"
                source: rectId
            }

        }

        foreground: null


        tickmark: Rectangle {

            implicitWidth: outerRadius * 0.03
            implicitHeight: styleData.value%20=== 0 ? outerRadius*0.4 : 0
            color: "black"
        }

        minorTickmark: null

        tickmarkLabel: Text{
            font.pixelSize: Math.max(6, outerRadius * 0.1)
            visible: styleData.value===0 || styleData.value===250
            text: styleData.value
            color: styleData.value >= 220 ? "red":  "white"
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
