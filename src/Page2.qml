import QtQuick 2.4
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQml.StateMachine 1.0 as DSM
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

Item {
    id: page2

    signal startTimer( double duration_ms )
    signal pauseTimer
    signal timerTriggered
    signal signal_autostart

    function autostart() {
        if ( page2ui.autostartSwitchChecked === true ) {
            signal_autostart()
        }
    }

    function isAlarm() {
        return page2ui.alarmSwitchChecked
    }

    function getAlarm() {
        var alarmDate = new Date( Date.now() )

        if ( page2ui.spinHourValue < alarmDate.getHours() ) {
            alarmDate.setDate( alarmDate.getDate() + 1 )
        }

        alarmDate.setHours( page2ui.spinHourValue )
        alarmDate.setMinutes( page2ui.spinMinuteValue )
        alarmDate.setSeconds( page2ui.spinSecondValue )

        return alarmDate
    }

    Connections {
        target: buttonQuit
        onClicked: Qt.quit();
    }

    Page2Form {
        id: page2ui

        property alias spinSecondValue   : spinSecond.value
        property alias spinMinuteValue   : spinMinute.value
        property alias spinHourValue     : spinHour.value
        property alias alarmSwitchChecked: alarmSwitch.checked
        property alias autostartSwitchChecked: autostartSwitch.checked
        property alias buttonStateText: buttonState.text

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

                RowLayout {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Switch {
                        id: alarmSwitch
                        Layout.fillWidth: true
                        text: "Is Alarm (instead of Timer)"
                        checked: settings.bIsAlarm
                    }

                    Switch {
                        id: autostartSwitch
                        text: "Auto start"
                        checked: settings.bAutostartEnabled
                        Layout.fillWidth: true
                    }
                }

                RowLayout {
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    ColumnLayout {
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        Label {
                            Layout.fillWidth: true
                            horizontalAlignment: Text.AlignHCenter
                            text: "Hours"
                        }

                        SpinBox {
                            Layout.fillWidth: true
                            id: spinHour
                            value : settings.hour
                        }
                    }

                    ColumnLayout {
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        Label {
                            Layout.fillWidth: true
                            horizontalAlignment: Text.AlignHCenter
                            text: "Minutes"
                        }

                        SpinBox {
                            Layout.fillWidth: true
                            id: spinMinute
                            to: 60
                            value : settings.min
                        }
                    }

                    ColumnLayout {
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        Label {
                            Layout.fillWidth: true
                            horizontalAlignment: Text.AlignHCenter
                            text: "Seconds"
                        }

                        SpinBox {
                            Layout.fillWidth: true
                            id: spinSecond
                            to: 60
                            value : settings.sec
                        }
                    }
                }

                RowLayout {
                    Layout.fillWidth: true
                    spacing: parent.width / 3

                    Button {
                        id: buttonState
                        text: "Initializing"
                        Layout.fillWidth: true
                    }

                    Button {
                        id: buttonQuit
                        text: "Quit"
                        Layout.fillWidth: true
                    }
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

    DSM.StateMachine {
        id: stateMachine
        initialState: stoped
        running: true
        DSM.State {
            id: stoped
            DSM.SignalTransition {
                targetState: running
                signal: buttonState.clicked
            }
            DSM.SignalTransition {
                targetState: running
                signal: signal_autostart
            }
            onEntered: {
                console.debug( "stoped state" )
                page2ui.buttonStateText = "Start"
                pauseTimer()
            }
        }
        DSM.State {
            id: running
            DSM.SignalTransition {
                targetState: stoped
                signal: buttonState.clicked
            }
            DSM.SignalTransition {
                targetState: stoped
                signal: onTimerTriggered
            }
            onEntered: {
                console.debug( "running state" )
                page2ui.buttonStateText = "Stop"
                startTimer( ( page2ui.spinHourValue * 60 * 60 + page2ui.spinMinuteValue * 60 + page2ui.spinSecondValue ) * 1000 )
            }
        }

        onStarted: autostart()
    }

    Settings {
        id : settings

        property int sec   : 0
        property int min   : 0
        property int hour  : 0
        property bool bIsAlarm : false
        property bool bAutostartEnabled : false
    }

    Component.onDestruction: {
        settings.sec               = page2ui.spinSecondValue
        settings.min               = page2ui.spinMinuteValue
        settings.hour              = page2ui.spinHourValue
        settings.bIsAlarm          = page2ui.alarmSwitchChecked
        settings.bAutostartEnabled = page2ui.autostartSwitchChecked
    }
}
