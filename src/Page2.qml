import QtQuick 2.4
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQml.StateMachine 1.0 as DSM
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

Page2Form {

    id: page2

    property alias btnText : button.text

    signal startTimer( double duration_ms )
    signal pauseTimer
    signal timerTriggered

    function isAlarm() {
        return alarmSwitch.checked
    }

    function getAlarm() {
        var alarmDate = new Date()

        if ( alarmDate.getHours() < spinHour.value ) {
            alarmDate.setDate( alarmDate.getDate() + 1 )
        }

        alarmDate.setHours( spinHour.value )
        alarmDate.setMinutes( spinMinute.value )
        alarmDate.setSeconds( spinSecond.value )

        return alarmDate
    }

    Item {
        anchors.fill: parent
        anchors.margins: 9

        Flickable {
            id: flickable
            anchors.fill: parent
            contentWidth: parent.width
            contentHeight: column.height

            ColumnLayout {
                id: column
                width: parent.width - 10 // to show scroll bar

                Switch {
                    id: alarmSwitch
                    Layout.fillWidth: true
                    text: "Alarm (vs. Timer)"
                    checked: settings.bIsAlarm
                }

                GridLayout {
                    id: grid
                    columns: 2
                    rows: 3

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
                    text: "Initializing"
                    Layout.fillWidth: true
                }

                Label {
                    text: " "
                }

                Button {
                    id: buttonQuit
                    text: "Quit"
                    Layout.fillWidth: true

                    onClicked: Qt.quit();
                }

                Label {
                    text: Qt.application.displayName + " v" + Qt.application.version + " by " + Qt.application.organization
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignRight
                }


            } // column


        } // flickable
    }

    Rectangle {
        id: scrollbar
        anchors.right: page2.right
        y: flickable.visibleArea.yPosition * flickable.height
        width: 10
        height: flickable.visibleArea.heightRatio * flickable.height
        color: "black"
    }

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
    }

    Settings {
        id : settings

        property int sec   : 0
        property int min   : 0
        property int hour  : 0
        property bool bIsAlarm : false
    }

    Component.onDestruction: {
        settings.sec  = spinSecond.value
        settings.min  = spinMinute.value
        settings.hour = spinHour.value
        settings.bIsAlarm = alarmSwitch.checked
    }
}
