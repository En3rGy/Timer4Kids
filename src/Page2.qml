import QtQuick
import QtQuick.Controls
import QtQml.StateMachine as DSM
import QtQuick.Layouts
import QtCore

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

    function saveSettings() {
        settings.sec               = page2ui.spinSecondValue
        settings.min               = page2ui.spinMinuteValue
        settings.hour              = page2ui.spinHourValue
        settings.bIsAlarm          = page2ui.alarmSwitchChecked
        settings.bAutostartEnabled = page2ui.autostartSwitchChecked
    }

    Connections {
        target: page2ui.buttonQuit
        function onClicked() {
            Qt.quit();
        }
    }

    Timer {
        id: timerClock
        interval: 1000
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: {
            var alarmDate = new Date( Date.now() )
            page2ui.labelCurrentTimeText = alarmDate.toTimeString();
        }
    }

    Page2Form {
        id: page2ui
    }

    Rectangle {
        id: scrollbar
        anchors.right: page2.right
        y: page2ui.flickable.visibleArea.yPosition * page2ui.flickable.height
        width: 10
        height: page2ui.flickable.visibleArea.heightRatio * page2ui.flickable.height
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
                signal: page2ui.buttonState.clicked
            }
            DSM.SignalTransition {
                targetState: running
                signal: signal_autostart
            }
            onEntered: {
                page2ui.buttonState.text = "Start"
                pauseTimer()
            }
        }
        DSM.State {
            id: running
            DSM.SignalTransition {
                targetState: stoped
                signal: page2ui.buttonState.clicked
            }
            DSM.SignalTransition {
                targetState: stoped
                signal: onTimerTriggered
            }
            onEntered: {
                page2ui.buttonState.text = "Stop"
                startTimer( ( page2ui.spinHourValue * 60 * 60 + page2ui.spinMinuteValue * 60 + page2ui.spinSecondValue ) * 1000 )
                saveSettings()
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
        saveSettings()
    }
}
