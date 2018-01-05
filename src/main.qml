import QtQml 2.2
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0

ApplicationWindow {
    id: applicationWindow
    visible: true
    visibility: "FullScreen"
    width: 320
    height: 240
    title: qsTr("Timer4Kids")

    property double startTime : 0

    Material.theme: Material.Dark

    function getTimeStr( time_ms ) {

        time_ms = time_ms - ( time_ms % 1000 )
        var ss =     ( time_ms / 1000 ) % 60
        var mm =   ( ( time_ms / 1000 - ss ) / 60 ) % 60
        var hh = ( ( ( time_ms / 1000 - ss ) / 60 ) - mm ) / 60

        var sHh  = ( hh < 10 ) ? ( "0" + hh.toString() ) : hh.toString()
        var sMm  = ( mm < 10 ) ? ( "0" + mm.toString() ) : mm.toString()
        var sSs  = ( ss < 10 ) ? ( "0" + ss.toString() ) : ss.toString()

        return sHh + ":" + sMm + ":" + sSs
    }

    Connections {
        target: page2
        onStartTimer: setTimer( duration_ms )
        onEmitterTriggered: { page1.emitterActive = bChecked }
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
            page1.labelTimerText = "00:00:00"
            page1.setProgress( 100 )
        }
    }

    Timer {
        id: uiUpdateTimer
        interval: 40
        repeat: true
        triggeredOnStart: true

        property int remainTime_ms
        property int elapsedTime_ms
        property double prct

        onTriggered: {
            var timerInt = timer.interval

            elapsedTime_ms = Date.now() - startTime
            remainTime_ms  = timerInt - elapsedTime_ms

            prct = ( timerInt - elapsedTime_ms ) / timerInt * 100
            page1.setProgress( 100 - prct )

            page1.labelTimerText = getTimeStr( remainTime_ms )
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

        page1.emitterActive = page2.emitterActive
        timer.interval = interval_ms
        timer.start()
        uiUpdateTimer.start()
        startTime = Date.now()
        swipeView.currentIndex = 0
        page1.setProgress( 0 )
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
