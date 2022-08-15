import QtQuick 2.14
import QtPositioning 5.14

/* Plik zawierający animację trasy w nawigacji.

  Definition of a GPS route animation.

*/

Item {

    property var myTarget

    SequentialAnimation{
        running: true
        NumberAnimation{
            duration: 2500
        }

        CoordinateAnimation{
            target: myTarget
            property: "center"
            to: QtPositioning.coordinate(52.242023,  20.903471)
            duration: 1000
        }

        CoordinateAnimation{
            target: myTarget
            property: "center"
            to: QtPositioning.coordinate(52.242132,  20.902154)
            duration: 6000
        }

        CoordinateAnimation{
            target: myTarget
            property: "center"
            to: QtPositioning.coordinate(52.242207,  20.901063)
            duration: 5000
        }

        CoordinateAnimation{
            target: myTarget
            property: "center"
            to: QtPositioning.coordinate(52.242350,   20.899279)
            duration: 7000
        }

        CoordinateAnimation{
            target: myTarget
            property: "center"
            to: QtPositioning.coordinate(52.242405, 20.898421)
            duration: 3000
        }
        ParallelAnimation{

            CoordinateAnimation{
                target: myTarget
                property: "center"
                to: QtPositioning.coordinate(52.242405, 20.898421)
                duration: 1000
            }

            NumberAnimation{
                target: myTarget
                property: "bearing"
                from: -82
                to:-175
                duration: 1000
            }
        }

        CoordinateAnimation{
            target: myTarget
            property: "center"
            to: QtPositioning.coordinate(52.242107, 20.898376)
            duration: 3000
        }

        ParallelAnimation{

            CoordinateAnimation{
                target: myTarget
                property: "center"
                to: QtPositioning.coordinate(52.242035, 20.898352)
                duration: 1000
            }

            NumberAnimation{
                target: myTarget
                property: "bearing"
                from: -175
                to:-160
                duration: 1000
            }
        }

        ParallelAnimation{

            CoordinateAnimation{
                target: myTarget
                property: "center"
                to: QtPositioning.coordinate(52.241953, 20.898256)
                duration: 1000
            }

            NumberAnimation{
                target: myTarget
                property: "bearing"
                from: -160
                to:-140
                duration: 1000

            }
        }


        ParallelAnimation{

            CoordinateAnimation{
                target: myTarget
                property: "center"
                to: QtPositioning.coordinate(52.241915, 20.898202)
                duration: 1000
            }

            NumberAnimation{
                target: myTarget
                property: "bearing"
                from: -140
                to:-120
                duration: 1000

            }
        }

        ParallelAnimation{

            CoordinateAnimation{
                target: myTarget
                property: "center"
                to: QtPositioning.coordinate(52.241906, 20.898099)
                duration: 1000
            }

            NumberAnimation{
                target: myTarget
                property: "bearing"
                from: -120
                to:-82
                duration: 1000

            }
        }

        CoordinateAnimation{
            target: myTarget
            property: "center"
            to: QtPositioning.coordinate(52.241945, 20.897589)
            duration: 2000
        }

        CoordinateAnimation{
            target: myTarget
            property: "center"
            to: QtPositioning.coordinate(52.241980, 20.896973)
            duration: 2000
        }


        ParallelAnimation{

            CoordinateAnimation{
                target: myTarget
                property: "center"
                to: QtPositioning.coordinate(52.241993, 20.896943)
                duration: 1000
            }

            NumberAnimation{
                target: myTarget
                property: "bearing"
                from: -82
                to:-40
                duration: 1000

            }
        }

        ParallelAnimation{

            CoordinateAnimation{
                target: myTarget
                property: "center"
                to: QtPositioning.coordinate(52.242005, 20.896930)
                duration: 1000
            }

            NumberAnimation{
                target: myTarget
                property: "bearing"
                from: -40
                to:0
                duration: 1000

            }
        }


        ParallelAnimation{

            CoordinateAnimation{
                target: myTarget
                property: "center"
                to: QtPositioning.coordinate(52.242952, 20.897083)
                duration: 6000
            }

            NumberAnimation{
                target: myTarget
                property: "bearing"
                from: 0
                to:10
                duration: 6000

            }
        }


        ParallelAnimation{

            CoordinateAnimation{
                target: myTarget
                property: "center"
                to: QtPositioning.coordinate(52.243265, 20.897175)
                duration: 4000
            }

            NumberAnimation{
                target: myTarget
                property: "bearing"
                from: 10
                to:15
                duration: 4000

            }
        }

        ParallelAnimation{

            CoordinateAnimation{
                target: myTarget
                property: "center"
                to: QtPositioning.coordinate(52.243490, 20.897217)
                duration: 2000
            }

            NumberAnimation{
                target: myTarget
                property: "bearing"
                from: 15
                to:8
                duration: 2000

            }
        }

        CoordinateAnimation{
            target: myTarget
            property: "center"
            to: QtPositioning.coordinate(52.244215, 20.897404)
            duration: 3000
        }


        ParallelAnimation{

            CoordinateAnimation{
                target: myTarget
                property: "center"
                to: QtPositioning.coordinate(52.244633, 20.897484)
                duration: 2000
            }

            NumberAnimation{
                target: myTarget
                property: "bearing"
                from: 8
                to:5
                duration: 2000

            }
        }

        ParallelAnimation{

            CoordinateAnimation{
                target: myTarget
                property: "center"
                to: QtPositioning.coordinate(52.244867, 20.897528)
                duration: 1000
            }

            NumberAnimation{
                target: myTarget
                property: "bearing"
                from: 5
                to:12
                duration: 1000

            }
        }


        ParallelAnimation{

            CoordinateAnimation{
                target: myTarget
                property: "center"
                to: QtPositioning.coordinate(52.244950, 20.897567)
                duration: 1000
            }

            NumberAnimation{
                target: myTarget
                property: "bearing"
                from: 12
                to:14
                duration: 1000

            }
        }


        ParallelAnimation{

            CoordinateAnimation{
                target: myTarget
                property: "center"
                to: QtPositioning.coordinate(52.245318, 20.897597)
                duration: 2000
            }

            NumberAnimation{
                target: myTarget
                property: "bearing"
                from: 14
                to:0
                duration: 2000

            }
        }


        CoordinateAnimation{
            target: myTarget
            property: "center"
            to: QtPositioning.coordinate(52.245498, 20.897609)
            duration: 2000
        }

        ParallelAnimation{

            CoordinateAnimation{
                target: myTarget
                property: "center"
                to: QtPositioning.coordinate(52.245623, 20.897614)
                duration: 1000
            }

            NumberAnimation{
                target: myTarget
                property: "bearing"
                from: 0
                to:5
                duration: 1000

            }
        }

        CoordinateAnimation{
            target: myTarget
            property: "center"
            to: QtPositioning.coordinate(52.246109, 20.897703)
            duration: 3000
        }

        CoordinateAnimation{
            target: myTarget
            property: "center"
            to: QtPositioning.coordinate(52.246620, 20.897778)
            duration: 3000
        }




        ParallelAnimation{

            CoordinateAnimation{
                target: myTarget
                property: "center"
                to: QtPositioning.coordinate(52.247236, 20.897885)
                duration: 3000
            }

            NumberAnimation{
                target: myTarget
                property: "bearing"
                from: 5
                to:8
                duration: 3000

            }
        }

        ParallelAnimation{

            CoordinateAnimation{
                target: myTarget
                property: "center"
                to: QtPositioning.coordinate(52.247957, 20.897976)
                duration: 3000
            }

            NumberAnimation{
                target: myTarget
                property: "bearing"
                from: 8
                to:3
                duration: 3000

            }
        }

        ParallelAnimation{

            CoordinateAnimation{
                target: myTarget
                property: "center"
                to: QtPositioning.coordinate(52.248112, 20.897997)
                duration: 500
            }

            NumberAnimation{
                target: myTarget
                property: "bearing"
                from: 3
                to:6
                duration: 500

            }
        }

        ParallelAnimation{

            CoordinateAnimation{
                target: myTarget
                property: "center"
                to: QtPositioning.coordinate(52.248248, 20.898030)
                duration: 1000
            }

            NumberAnimation{
                target: myTarget
                property: "bearing"
                from: 6
                to:4
                duration: 1000

            }
        }

        ParallelAnimation{

            CoordinateAnimation{
                target: myTarget
                property: "center"
                to: QtPositioning.coordinate(52.248581, 20.898052)
                duration: 3000
            }

            NumberAnimation{
                target: myTarget
                property: "bearing"
                from: 4
                to:7
                duration: 3000

            }
        }




        ParallelAnimation{

            CoordinateAnimation{
                target: myTarget
                property: "center"
                to: QtPositioning.coordinate(52.249271, 20.898170)
                duration: 4000
            }

            NumberAnimation{
                target: myTarget
                property: "bearing"
                from: 7
                to:9
                duration: 4000

            }
        }

        ParallelAnimation{

            CoordinateAnimation{
                target: myTarget
                property: "center"
                to: QtPositioning.coordinate(52.249317, 20.898183)
                duration: 1000
            }

            NumberAnimation{
                target: myTarget
                property: "bearing"
                from: 9
                to:11
                duration: 1000

            }
        }


        ParallelAnimation{

            CoordinateAnimation{
                target: myTarget
                property: "center"
                to: QtPositioning.coordinate(52.249342, 20.898198)
                duration: 1000
            }

            NumberAnimation{
                target: myTarget
                property: "bearing"
                from: 11
                to:100
                duration: 1000

            }
        }

        CoordinateAnimation{
            target: myTarget
            property: "center"
            to: QtPositioning.coordinate(52.249324, 20.898417)
            duration: 1000
        }

        ParallelAnimation{

            CoordinateAnimation{
                target: myTarget
                property: "center"
                to: QtPositioning.coordinate(52.249335, 20.898589)
                duration: 1000
            }

            NumberAnimation{
                target: myTarget
                property: "bearing"
                from: 100
                to:85
                duration: 1000

            }
        }


        ParallelAnimation{

            CoordinateAnimation{
                target: myTarget
                property: "center"
                to: QtPositioning.coordinate(52.249347, 20.898664)
                duration: 1000
            }

            NumberAnimation{
                target: myTarget
                property: "bearing"
                from: 85
                to:75
                duration: 1000

            }
        }

        ParallelAnimation{

            CoordinateAnimation{
                target: myTarget
                property: "center"
                to: QtPositioning.coordinate(52.249387, 20.898814)
                duration: 1000
            }

            NumberAnimation{
                target: myTarget
                property: "bearing"
                from: 75
                to:60
                duration: 1000

            }
        }


        ParallelAnimation{

            CoordinateAnimation{
                target: myTarget
                property: "center"
                to: QtPositioning.coordinate(52.249394, 20.898985)
                duration: 1000
            }

            NumberAnimation{
                target: myTarget
                property: "bearing"
                from: 60
                to:90
                duration: 1000

            }
        }

        CoordinateAnimation{
            target: myTarget
            property: "center"
            to: QtPositioning.coordinate(52.249389, 20.899114)
            duration: 1000
        }

    }
}



