import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes 1.6

Item {
    id: page1Form

    property string bgCircleColor : "midnightblue"
    property string finishedColor : "gold"
    property alias  bgColor : rectBack.color

    function setCircleVisible( bVisible ) {
        circleSec.visible   = bVisible
        circleMin.visible   = bVisible
        circleHoure.visible = bVisible
    }

    function setFinishCircle( bFinished ) {
        circleHoureFinished.visible = bFinished
        circleMinFinished.visible = bFinished
        circleSecFinished.visible = bFinished
    }


    function setProgress( remainTime_ms ) {

        // timer finished
        if ( remainTime_ms <= 0.0 ) {
            setFinishCircle( true )
        }

        // reduce foreground circles w.r.t. progress
        else {
            var remain_s = remainTime_ms / 1000

            var sec = 60 - Math.round( remain_s % 60 - 0.5 )
            var arcSec = sec * 360 / 60

            if ( arcSec != circleSec.arcBegin ) {
                circleSec.arcBegin = arcSec
            }

            var remain_m = remain_s / 60
            var min = 60 - Math.round( remain_m % 60 - 0.5 )
            var arcMin = min * 360 / 60

            if ( arcMin != circleMin.arcBegin ) {
                circleMin.arcBegin = arcMin
            }

            var remain_h = remain_m / 60
            var h = 24 - Math.round( remain_h % 24 - 0.5 )
            var arcH = h * 360 / 24

            if ( arcH != circleHoure.arcBegin ) {
                circleHoure.arcBegin = arcH
            }
        }
    }

    // Creates new ProgressCircles on top of the rectBack object and there fore draws many black "gap circles" on the three time circles
    function finishCreation() {
        var component = Qt.createComponent( "ProgressCircle.qml" );

        for ( var i = 0; i < 60; ++i ) {

            // black parts to seperate sec circle elements
            component.createObject(rectBack, {
                                       "anchors.centerIn": rectBack,
                                       "size": Math.min( rectBack.width, rectBack.height ) * 0.5 + 5,
                                       "colorCircle": "black",
                                       "arcBegin": i * 360 / 60 - 1,
                                       "arcEnd": i * 360 / 60 + 1,
                                       "lineWidth": 20,
                                       "z": 10 });

            // black parts to seperate min circle elements
            component.createObject(rectBack, {
                                       "anchors.centerIn": rectBack,
                                       "size": Math.min( rectBack.width, rectBack.height ) * 0.7 + 5,
                                       "colorCircle": "black",
                                       "arcBegin": i * 360 / 60 - 1,
                                       "arcEnd": i * 360 / 60 + 1,
                                       "lineWidth": 20,
                                       "z": 10 });
        }

        for ( var j = 0; j < 24; ++j ) {
            // black parts to seperate hh circle elements
            component.createObject(rectBack, {
                                       "anchors.centerIn": rectBack,
                                       "size": Math.min( rectBack.width, rectBack.height ) * 0.9 + 5,
                                       "colorCircle": "black",
                                       "arcBegin": j * 360 / 24 - 1,
                                       "arcEnd": j * 360 / 24 + 1,
                                       "lineWidth": 20,
                                       "z": 10 });
        }
    }

    Rectangle {
        id : rectBack
        anchors.fill: parent
        color: "black"

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.BlankCursor
        }

        ProgressCircle {
            id : bgCircleSec
            anchors.centerIn: parent
            size: Math.min( parent.width, parent.height ) * 0.5
            colorCircle: bgCircleColor
            arcBegin: 0
            arcEnd: 360
            lineWidth: 10
        }

        ProgressCircle {
            id : bgCircleMin
            anchors.centerIn: parent
            size: Math.min( parent.width, parent.height ) * 0.7
            colorCircle: bgCircleColor
            arcBegin: 0
            arcEnd: 360
            lineWidth: 10
        }

        ProgressCircle {
            id : bgCircleH
            anchors.centerIn: parent
            size: Math.min( parent.width, parent.height ) * 0.9
            colorCircle: bgCircleColor
            arcBegin: 0
            arcEnd: 360
            lineWidth: 10
        }

        ProgressCircle {
            id : circleSecFinished
            anchors.centerIn: parent
            size: Math.min( parent.width, parent.height ) * 0.5
            colorCircle: finishedColor
            arcBegin: 0
            arcEnd: 360
            lineWidth: 10
            visible: false
            z: 4
        }

        ProgressCircle {
            id : circleMinFinished
            anchors.centerIn: parent
            size: Math.min( parent.width, parent.height ) * 0.7
            colorCircle: finishedColor
            arcBegin: 0
            arcEnd: 360
            lineWidth: 10
            visible: false
            z: 4
        }

        ProgressCircle {
            id : circleHoureFinished
            anchors.centerIn: parent
            size: Math.min( parent.width, parent.height ) * 0.9
            colorCircle: finishedColor
            arcBegin: 0
            arcEnd: 360
            lineWidth: 10
            visible: false
            z: 4
        }

        ProgressCircle {
            id : circleSec
            anchors.centerIn: parent
            size: Math.min( parent.width, parent.height ) * 0.5
            colorCircle: "orangered"
            arcBegin: 0
            arcEnd: 360
            lineWidth: 10
            z: 5
        }

        ProgressCircle {
            id : circleMin
            anchors.centerIn: parent
            size: Math.min( parent.width, parent.height ) * 0.7
            colorCircle: "mediumspringgreen"
            arcBegin: 0
            arcEnd: 360
            lineWidth: 10
            z: 5
        }

        ProgressCircle {
            id : circleHoure
            anchors.centerIn: parent
            size: Math.min( parent.width, parent.height ) * 0.9
            colorCircle: "orchid"
            arcBegin: 0
            arcEnd: 360
            lineWidth: 10
            z: 5

            Component.onCompleted: finishCreation();
        }
    } // rectBack
}
