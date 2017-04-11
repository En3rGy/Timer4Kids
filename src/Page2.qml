import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.0
import Qt.labs.settings 1.0

Page2Form {
    property alias btnText : button.text
    signal startTimer( double duration_ms )
    signal pauseTimer

    ColumnLayout {

        id: column
        anchors.fill: parent

        GridLayout {
            id: grid
            columns: 2
            rows: 4

            Label {
                text: "Hours"
            }

            SpinBox {
                Layout.fillWidth: true
                id: spinHour
                value : settings.hour
            }

            Label {
                text: "Minutes"
            }

            SpinBox {
                Layout.fillWidth: true
                id: spinMinute
                maximumValue: 60
                value : settings.min
            }

            Label {
                text: "Seconds"
            }

            SpinBox {
                Layout.fillWidth: true
                id: spinSecond
                maximumValue: 60
                value : settings.sec
            }

        } // grid

        Button {
            id: button
            text: "Start"
            Layout.fillWidth: true
            onClicked: {
                if ( button.text == "Start" ) {
                    setButtonText( "Stop" )
                    startTimer( ( spinHour.value * 60 * 60 + spinMinute.value * 60 + spinSecond.value ) * 1000 )
                }
                else {
                    setButtonText( "Start" )
                    pauseTimer()
                }
            }
        }


    } // column

    function setButtonText( sVal ) {
        btnText = sVal
    }

    Settings {
        id : settings

        property int sec   : 0
        property int min   : 0
        property int hour  : 0
    }

    Component.onDestruction: {
        settings.sec = spinSecond.value
        settings.min = spinMinute.value
        settings.hour = spinHour.value
    }
}
