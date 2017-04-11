import QtQuick 2.4
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQml.StateMachine 1.0 as DSM
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

Page2Form {

    property alias btnText : button.text
    signal startTimer( double duration_ms )
    signal pauseTimer
    signal timerTriggered

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
                to: 60
                value : settings.min
            }

            Label {
                text: "Seconds"
            }

            SpinBox {
                Layout.fillWidth: true
                id: spinSecond
                to: 60
                value : settings.sec
            }

        } // grid

        Button {
            id: button
            text: "Initializeing"
            Layout.fillWidth: true
        }

    } // column

    function setButtonText( sVal ) {
        btnText = sVal
    }

    DSM.StateMachine {
        id: stateMachine
        initialState: stoped
        running: true
        DSM.State {
            id: stoped
            DSM.SignalTransition {
                targetState: running
                signal: button.clicked
            }
            onEntered: {
                setButtonText( "Start" )
                pauseTimer()
            }
        }
        DSM.State {
            id: running
            DSM.SignalTransition {
                targetState: stoped
                signal: button.clicked
            }
            DSM.SignalTransition {
                targetState: stoped
                signal: onTimerTriggered
            }
            onEntered: {
                setButtonText( "Stop" )
                startTimer( ( spinHour.value * 60 * 60 + spinMinute.value * 60 + spinSecond.value ) * 1000 )
            }
        }

        //                DSM.FinalState {
        //                    id: finalState
        //                }
        //                onFinished: Qt.quit()
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