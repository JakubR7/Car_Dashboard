import QtGraphicalEffects 1.0
import QtLocation 5.9
import QtPositioning 5.14
import QtQuick 2.14
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0

/*
  Plik zawierający definicję mapy.

  Map definition.
*/

Item {

    property var myTarget: map
    property bool myIndex: false

    ComboBox {
        id: myCombo
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -250
        anchors.top: parent.top
        anchors.topMargin: 5
        z: 1
        currentIndex: 0

        background: Rectangle{
            implicitWidth: 180
            implicitHeight: 40
            radius: 15
            color: "lightgray"
            border.width: 1
        }

        indicator: Canvas {
                id: canvas
                x: myCombo.width - width - myCombo.rightPadding
                y: myCombo.topPadding + (myCombo.availableHeight - height) / 2
                width: 12
                height: 8
                contextType: "2d"

                Connections {
                    target: myCombo
                    onPressedChanged: canvas.requestPaint()
                }

                onPaint: {
                    context.reset();
                    context.moveTo(0, 0);
                    context.lineTo(width, 0);
                    context.lineTo(width / 2, height);
                    context.closePath();
                    context.fillStyle = myCombo.pressed ? "lightblue" : "dodgerblue";
                    context.fill();
                }
            }

        popup: Popup{

            y: myCombo.height
            width: myCombo.width
            implicitHeight: contentItem.implicitHeight
            padding: 1
            spacing: 5

            contentItem: ListView {
                clip: true
                implicitHeight: contentHeight
                model: myCombo.popup.visible ? myCombo.delegateModel : null
                currentIndex: myCombo.highlightedIndex

                ScrollIndicator.vertical: ScrollIndicator { }
            }

            background: Rectangle{
                radius: 5
            }


        }


        model: ListModel {
            id: styleModel
        }

        onActivated: {
            map.activeMapType = map.supportedMapTypes[index];

        }
    }



    Component.onCompleted: {
        for (var i = 0; i < map.supportedMapTypes.length; i++) {
            styleModel.append({ text: map.supportedMapTypes[i].description });
        }
    }
    anchors.fill: parent

    //Map properties
    Item{
        anchors.fill: parent

        Map {
                    id: map
                    anchors.fill: parent

                    plugin: Plugin {
                        name: "mapboxgl"

                        PluginParameter {
                            name: "mapboxgl.mapping.use_fbo"
                            value: true
                        }

                        PluginParameter {
                            name: "mapboxgl.mapping.items.insert_before"
                            value: "aerialway"
                        }
                    }

                    center: QtPositioning.coordinate(52.241994, 20.903646) // Warsaw
                    zoomLevel: 20
                    minimumZoomLevel: 0
                    maximumZoomLevel: 20
                    tilt: 45
                    bearing: -82

                    //Map layers definition
                    MapParameter {
                        type: "layer"

                        property var name: "3d-buildings"
                        property var source: "composite"
                        property var sourceLayer: "building"
                        property var layerType: "fill-extrusion"
                        property var minzoom: 15.0
                    }

                    MapParameter {
                        type: "filter"

                        property var layer: "3d-buildings"
                        property var filter: [ "==", "extrude", "true" ]
                    }

                    MapParameter {
                        type: "paint"

                        property var layer: "3d-buildings"
                        property var fillExtrusionColor: "#00617f"
                        property var fillExtrusionOpacity: .6
                        property var fillExtrusionHeight: { return { type: "identity", property: "height" } }
                        property var fillExtrusionBase: { return { type: "identity", property: "min_height" } }
                    }


                    function updateRoute() {
                        routeQuery.clearWaypoints();
                        routeQuery.addWaypoint(startMarker.coordinate);
                        routeQuery.addWaypoint(endMarker.coordinate);
                    }

                    //Definition of icons used in map
                    MapQuickItem {
                        id: startMarker

                        sourceItem: Image {
                            id: greenMarker
                            width: 50
                            height: 50
                            source: "qrc:/Images/marker-green.png"
                        }

                        coordinate : QtPositioning.coordinate(52.242002, 20.903681)
                        anchorPoint.x: greenMarker.width / 2
                        anchorPoint.y: greenMarker.height

                        MouseArea  {
                            drag.target: parent
                            anchors.fill: parent
                        }

                        onCoordinateChanged: {
                            map.updateRoute();
                        }
                    }

                    MapQuickItem{
                        id: pointer

                        sourceItem: Image {
                            id: carPointer
                            width: 70
                            height: width
                            //z: 1
                            source:"qrc:/Images/label-arrow.png"
                        }

                        coordinate : map.center
                        anchorPoint.x: carPointer.width / 2
                        anchorPoint.y: carPointer.height / 2
                    }

                    MapQuickItem {
                        id: endMarker

                        sourceItem: Image {
                            id: redMarker
                            width: 50
                            height: 50
                            source: "qrc:/Images/marker-red.png"
                        }

                        coordinate : QtPositioning.coordinate(52.249385, 20.899198)
                        anchorPoint.x: redMarker.width / 2
                        anchorPoint.y: redMarker.height

                        MouseArea  {
                            drag.target: parent
                            anchors.fill: parent
                        }

                        onCoordinateChanged: {
                            map.updateRoute();
                        }
                    }

                    MapItemView {
                        model: routeModel

                        delegate: MapRoute {
                            route: routeData
                            line.color: "dodgerblue"
                            line.width: 10
                        }
                    }
                }




    }

    //Definition of a route displayed in map
    RouteModel {
        id: routeModel

        autoUpdate: true
        query: routeQuery

        plugin: Plugin {
                    name: "mapbox"

                    // Development access token, do not use in production.
                    PluginParameter {
                        name: "mapbox.access_token"
                        value: "pk.eyJ1IjoiemV4Y2VlZCIsImEiOiJja2E2cWk1cW8wOWM4MnNtb3V3NG5paDIxIn0.RytUDOVNX4hxsYwcnBMPKQ"
                    }
                }

        //Map animation
        Component.onCompleted: {
            if (map) {
                map.updateRoute();
            }
        }
    }

    RouteQuery {
        id: routeQuery
    }
}
