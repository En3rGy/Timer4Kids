import QtQml 2.2
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

ApplicationWindow {
    id: applicationWindow
    visible: true
    visibility: "FullScreen"
    width: 320
    height: 240
    title: qsTr("Timer4Kids")

    property double startTime : 0

    Connections {
        target: page2
        onStartTimer: {
            console.log( "Timer started" )
            page1.bgColor = "black"
            setTimer( duration_ms )
        }
        onPauseTimer: {
            timer.stop()
            uiUpdateTimer.stop()
        }
    }

    Timer {
        id: timer
        onTriggered: {
            page2.timerTriggered()
            uiUpdateTimer.stop()
            timer.stop()
            page1.setProgress( 0.0 )
        }
    }

    Timer {
        id: uiUpdateTimer
        interval: 250
        repeat: true
        triggeredOnStart: true

        property int remainTime_ms
        property int elapsedTime_ms
        property double prct

        onTriggered: {
            var timerInt = timer.interval

            elapsedTime_ms = Date.now() - startTime
            remainTime_ms  = timerInt - elapsedTime_ms

            if ( remainTime_ms <= 0.0 ) {
                uiUpdateTimer.stop()
            }

            page1.setProgress( remainTime_ms )
        }
    }

    function setTimer( interval_ms ) {
        var alarmDate = page2.getAlarm()
        var currDate  = new Date();

        if ( page2.isAlarm() === true ) {
            if ( alarmDate < currDate ) {
                alarmDate.setDate( alarmDate.getDate() + 1 )
            }

            interval_ms = alarmDate - currDate
        }

        page1.setCircleVisible( true )
        page1.setBgCircleColor( "midnightblue" )

        timer.interval = interval_ms
        timer.start()

        uiUpdateTimer.start()
        startTime = Date.now()
        swipeView.currentIndex = 0
        page1.setProgress( interval_ms )
    }

    SwipeView {
        id: swipeView
        wheelEnabled: false
        anchors.fill: parent

        Page1 {
            id: page1
        }

        Page2 {
            id: page2
        }
    }
}
