import QtQuick 2.14

/*
  Stworzenie listy modeli, losowana jest liczba, jeżeli istnieje model o odpowiednim indeksie to jest usuwany,
  jeżeli nie zostanie wylosowany dany indeks to komunikat zostaje wyświetlony.

  Definition of the 3rd panel displaying warnings.
*/

Item {
    anchors.bottom: parent.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    height: 340
    width: 280

    property int page3liczba: warningsModel.count

    function isVisible(){
        var var1
        var1 = Math.round((Math.random()*4))
        return var1
    }





    //Warning list definition
    ListModel {
        id: warningsModel
        ListElement {
            img: "qrc:/Images/abs.png"
            message: "Nieaktywne wspomaganie hamowania"
        }
        ListElement {
            img: "qrc:/Images/battery.png"
            message: "Niski poziom akumulatora"
        }
    }
    //Warning icons definition
    Component{
        id: warningDelegate
            Rectangle{
                width: parent.width
                height: 70
                color: "transparent"
                Row{
                    leftPadding: 5
                    topPadding: 10
                    spacing: 25
                    Image{
                        source: img
                        width: 50
                        height: 50

                    }

                    Text {
                        text: message
                        height: 70
                        width: 200
                        color: "white"
                        font.pointSize: 10
                        wrapMode: Text.WordWrap
                    }
                }
            }

    }

    ListView {
            id: myList
            anchors.fill: parent
            model: warningsModel
            delegate: warningDelegate
        }

    //Pseudo-random display of warnings.
    property var liczba
    Component.onCompleted: {
        for(var i =0; i < 2; i++){
            liczba = isVisible()
            if(liczba <warningsModel.count){
               warningsModel.remove(liczba,1)
            }
        }


    }

}
