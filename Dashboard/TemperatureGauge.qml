import QtQuick 2.14
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4
/*
  Zawartość tego pliku jest bardzo zbliżona do "FuelGauge.qml", różnicą jest gradient oraz to że wartość
  wskaźnia jest animowana tylko przy uruchomieniu do stałej wartości.

  Definition of a temperature gauge. Similar definition to the fuel gauge.
*/
CircularGauge{
    id: tempGauge
    width: 500
    height: width
    maximumValue: 10

    property bool carStarted: false

    function degreesToRadians(degrees) {
        return degrees * (Math.PI / 180);
    }

    style: CircularGaugeStyle{
        minimumValueAngle: -160
        maximumValueAngle: -200
        labelInset: outerRadius * -0.1
        background: Rectangle{
            color: "transparent"
            radius: 360
            property int myHeightBegin: parent.height-parent.height/10
            property int myHeightEnd: parent.height
            property int myWidthBegin: parent.width/3
            property int myWidthEnd: 2*parent.width/3

            Canvas{
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();

                    var gradient = ctx.createLinearGradient(myWidthBegin, myHeightBegin, myWidthEnd, myHeightEnd)
                    gradient.addColorStop(0.05, "deepskyblue");
                    gradient.addColorStop(0.3, Qt.rgba(1, 1, 1, 1));
                    gradient.addColorStop(0.7, Qt.rgba(1, 1, 1, 1));
                    gradient.addColorStop(0.95, Qt.rgba(1, 0, 0, 1));

                    ctx.beginPath();
                    ctx.strokeStyle = gradient;
                    ctx.lineWidth = outerRadius * 0.03;

                    ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 2,
                            degreesToRadians(valueToAngle(10) - 90), degreesToRadians(valueToAngle(0) - 90));
                    ctx.stroke();

                }
            }

            Image {
                id: tempId
                source: "qrc:/Images/temperature.png"
                width: 40
                height: 40
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: -50

            }
        }

        tickmarkLabel: Text{
            font.pixelSize: Math.max(6, outerRadius * 0.1)
            text: styleData.value === 0? "C" : styleData.value === 10? "H" : ""
            color: "white"

        }

        needle: Canvas{
            function toPixels(percentage) {
                return percentage * outerRadius;
            }

            property real needleLength: outerRadius - tickmarkInset * 1.25
            property real needleTipWidth: toPixels(0.02)
            property real needleBaseWidth: toPixels(0.03)
            implicitWidth: needleBaseWidth
            implicitHeight: needleLength

            property real xCenter: width / 2
            property real yCenter: height / 2

            onPaint: {
                var ctx = getContext("2d");
                ctx.reset();

                ctx.beginPath();
                ctx.moveTo(xCenter, yCenter - yCenter/3);
                ctx.lineTo(xCenter - needleBaseWidth,  yCenter - yCenter/3);
                ctx.lineTo(xCenter, 0 + 3*needleBaseWidth);
                ctx.closePath();
                ctx.fillStyle = "blue"
                ctx.strokeStyle = "blue";
                ctx.lineWidth = 2;
                ctx.fill();
                ctx.stroke();

                ctx.beginPath();
                ctx.moveTo(xCenter, yCenter- yCenter/3);
                ctx.lineTo(xCenter + needleBaseWidth,  yCenter- yCenter/3);
                ctx.lineTo(xCenter, 0 + 3*needleBaseWidth);
                ctx.closePath();
                ctx.fillStyle = "blue"
                ctx.strokeStyle = "blue";
                ctx.lineWidth = 2;
                ctx.fill();
                ctx.stroke();

            }
        }
        foreground: null
        minorTickmark: null

    }

    SequentialAnimation{
        running: carStarted

        NumberAnimation{

            target: tempGauge
            properties: "value"

            to: 4.5
            duration: 1000
        }

    }

    SequentialAnimation{
        running: !carStarted

        NumberAnimation{

            target: tempGauge
            properties: "value"

            to: 0
            duration: 1000
        }
    }
}
