import QtQuick 2.14
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.14

/*
    Ten plik odpowiada za stworzenie wsaźnika paliwa, oraz animacje, która jest zależna od prędkości obrotowej i biegu,
    oczywiście, nie jest to realna zależność, jednak pozwala na animację zmiany wskazania.
    Przy wykorzystaniu "Canvas" został swtorzony gradient, na wskaźniku paliwa oraz została stworzona igła wskaźnika paliwa.

    This file contains definition of fuel gauge, its animation which is linked to the tachometer value.
    Apperance of the fuel gauge, it's gradient and neeldle have been created using "Canvas".
*/

CircularGauge{
    id: fuelGauge
    maximumValue: 10
    width: 500
    height: width

    function degreesToRadians(degrees) {
        return degrees * (Math.PI / 180);
    }

    property int combustion
    property bool run: false
    property int gearCombustion: 80
    property bool carStarted: false
    property int fuelValue: fuelGauge.value

    style: CircularGaugeStyle{
        minimumValueAngle: -160
        maximumValueAngle: -200
        labelInset: outerRadius * -0.1
        tickmarkStepSize: 5
        background: Rectangle{
            id: backgroundRect
            radius: 360
            color: "transparent"

            property int myHeightBegin: parent.height-parent.height/10
            property int myHeightEnd: parent.height
            property int myWidthBegin: parent.width/3
            property int myWidthEnd: 2*parent.width/3
            Canvas{
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();
                    //Fuel gauge gradient definition
                    var gradient = ctx.createLinearGradient(myWidthBegin, myHeightBegin, myWidthEnd, myHeightEnd)
                    gradient.addColorStop(0.05, Qt.rgba(1, 0, 0, 1));
                    gradient.addColorStop(0.35, "yellow");
                    gradient.addColorStop(0.45, Qt.rgba(1, 1, 1, 1));
                    gradient.addColorStop(1, Qt.rgba(1, 1, 1, 1));

                    ctx.beginPath();
                    ctx.strokeStyle = gradient;
                    ctx.lineWidth = outerRadius * 0.03;

                    ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 2,
                            degreesToRadians(valueToAngle(10) - 90), degreesToRadians(valueToAngle(0) - 90));
                    ctx.stroke();

                }
            }

            Image {
                id: gasId
                source: "qrc:/Images/gas.png"
                width: 40
                height: 40
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: -50

            }
        }

        tickmarkLabel: Text{
            font.pixelSize: Math.max(6, outerRadius * 0.1)
            text: styleData.value === 0? "E" : styleData.value === 10? "F" : ""
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
                //Definition of the needle
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
        tickmark: Rectangle{
            implicitWidth: outerRadius * 0.02
            implicitHeight: styleData.value === 5?outerRadius * 0.055 :outerRadius * 0.07
            antialiasing: true
            visible: styleData.value%5 === 0? true : false
        }

    }
    //Animation of setting fuel gauge's vaule when "starting a car"
    ParallelAnimation{
        running: carStarted
        NumberAnimation{
            target: fuelGauge
            properties: "value"
            from: 0
            to: fuelGauge.maximumValue
            duration: 900
        }

    }
    //Animation of setting fuel gauge's vaule when "turning of a car"
    ParallelAnimation{
        running: !carStarted
        NumberAnimation{
            target: fuelGauge
            properties: "value"
            to: 0
            duration: 900
        }

    }

    //Fuel gauge value animation
    ParallelAnimation{

        running: run

        NumberAnimation{

            target: fuelGauge
            properties: "value"
            to: 0
            duration: 50000-(combustion+1)*gearCombustion
        }

    }

}
