//import QtQml 2.2
import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.0

ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 320
    height: 240
    title: qsTr("Timer4Kids")

    //Material.theme: Material.Dark

    Connections {
        target: page2
        onStartTimer: setTimer( duration_ms )
    }

    Connections {
        target: page2
        onPauseTimer: {
            timer.stop()
            uiUpdateTimer.stop()
        }
    }

    property double startTime : 0

    Timer {
        id: timer
        onTriggered: {
            page2.setButtonText( "Start" )
            page2.pauseTimer()
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
        onTriggered: {
            var currentTime   = new Date( Date.now() ) // local
            var elapsedTime   = currentTime - startTime
            var remainTime    = new Date( timer.interval - elapsedTime + 1000 )

            var prct = ( timer.interval - elapsedTime ) / timer.interval * 100
            page1.setProgress( 100 - prct )

            var hh = remainTime.getHours()   + remainTime.getTimezoneOffset() / 60
            var mm = remainTime.getMinutes() + remainTime.getTimezoneOffset() % 60
            var ss = remainTime.getSeconds()

            var sHh = ( hh < 10 ) ? ( "0" + hh.toString() ) : hh.toString()
            var sMm = ( mm < 10 ) ? ( "0" + mm.toString() ) : mm.toString()
            var sSs = ( ss < 10 ) ? ( "0" + ss.toString() ) : ss.toString()

            page1.labelTimerText = sHh + ":" + sMm + ":" + sSs
        }
    }

    function setTimer( interval_ms ) {
        timer.interval = interval_ms
        timer.start()
        uiUpdateTimer.start()
        startTime = new Date().setTime( Date.now() )  // local
        tabView.currentIndex = 0
        page1.setProgress( 0 )
    }

    TabView {
        id: tabView
        anchors.fill: parent
        tabPosition: 0

        Tab {
            title: qsTr("Timer")

            Page1 {
                id: page1
            }
        }

        Tab {
            title: qsTr("Settings")

            Page2 {
                id: page2
            }
        }
    }
}
