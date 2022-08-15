import QtQuick 2.0
import QtMultimedia 5.14
/*
    Stworzenie drugiego panelu, wyświetlenie autora, tytułu, ikony tła oraz ikon odnoszących się do odtwarzania
    lub nie utworu. Załączenie utworu.

    Music player, displaying title, author and icons.
*/

Item {
    anchors.fill: parent
    property alias myId: playMusic
    property bool playing
    property bool paused
    property bool stopped
    //Icons definition
    Image {
        id: playlistIcon
        width: 200
        height: width
        source: "qrc:/Images/playlist.png"
        anchors.centerIn: parent
        opacity: 0.2

    }

    Image {
        id: playIcon
        width: 70
        height: width
        source: "qrc:/Images/pause.png"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        visible: playing
    }

    Image {
        id: pauseIcon
        width: 70
        height: width
        source: "qrc:/Images/play.png"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        visible: paused
    }

    Image {
        id: stopIcon
        width: 70
        height: width
        source: "qrc:/Images/stop.png"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        visible: stopped
    }

    Audio {
        id: playMusic
        source: "qrc:/Music/[FREE] Japanese Type Beat - ''Arigato''.mp3"
    }
    //Author definition
    Text {
        text: "Author - GrillaBeats";
        font.pointSize: 17;
        color: "white"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 40
    }
    //Title definition
    Text {
        text: "Title - ''Arigato''";
        font.pointSize: 17;
        color: "white"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -40
    }
}
