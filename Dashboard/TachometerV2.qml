import QtQuick 2.14
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.14
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.14

/*
    Plik zawiera definicję wyglądu obrotomierza w sportowej wersji.
   File contains tachometer definition in sport view.
*/

CircularGauge{
    id: gauge
    width: 500
    height: width
    maximumValue: 8000
    value: myValue

    property int myValue
    property bool carStarted
    property var myGear


    style: CircularGaugeStyle{
        labelStepSize: 1000
        labelInset: outerRadius * -0.03
        tickmarkInset: outerRadius*0.02
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


                    var gradientR = ctx.createRadialGradient(xCenter, yCenter, outerRadius * 0.6 , xCenter, yCenter, outerRadius);
                    gradientR.addColorStop(0, Qt.rgba(1, 0, 0, 0.0));
                    gradientR.addColorStop(0.3, Qt.rgba(1, 0, 0, 0.4));
                    gradientR.addColorStop(1, Qt.rgba(1 , 0, 0, 1));

                    ctx.beginPath();
                    ctx.strokeStyle = gradientR2
                    ctx.lineWidth = 100
                    ctx.arc(outerRadius,
                            outerRadius,
                            outerRadius*0.95 - ctx.lineWidth/2 ,
                            degreesToRadians(valueToAngle(gauge.minimumValue ) - 90),
                            degreesToRadians(valueToAngle(gauge.value ) - 90));
                    ctx.stroke();


                }
            }


            Rectangle{
                id: rectId
                anchors.centerIn: parent
                width: outerRadius*0.83
                height: width
                color: "black"
                radius: 360


                Text {
                    id: gearText
                    font.pixelSize: toPixels(0.25)
                    text: !carStarted? "P" : myGear===0? "R" : myGear
                    color: myValue >= 6500? "yellow" : "white"
                    horizontalAlignment: Text.AlignRight
                    anchors.centerIn: parent
                }


            }

            Rectangle{
                id: rpmId
                width: 100
                height: 50
                color: "transparent"
                x: 410
                y: 434
                Text {
                    text: qsTr("x1000")
                    font.pixelSize: toPixels(0.06)
                    color: "white"
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

        minorTickmark: null

        tickmark:Rectangle {
            visible: styleData.value %500 == 0
            implicitWidth: outerRadius * 0.03
            implicitHeight: styleData.value%1000=== 0 ? outerRadius*0.4 : 0
            color: "black"
        }

        tickmarkLabel: Text{
            font.pixelSize: Math.max(6, outerRadius * 0.1)
            visible: styleData.value === 0 || styleData.value === maximumValue
            text: styleData.value/1000
            color: styleData.value >= 6500 ? "red" : "white"

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
