import QtQml 2.2
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    id: page1Form

    property string bgCircleColor : "midnightblue"
    property alias  bgColor : rectBack.color

    function setCircleVisible( bVisible ) {
        circleSec.visible   = bVisible
        circleMin.visible   = bVisible
        circleHoure.visible = bVisible
    }

    function setBgCircleColor( sColor ) {

        /// @bug bg color resetting from gold back to midnhight blue does not work;
        // Removing the if sentence leads to not setting the color to gold after finish...?!?
        // Try to hide the circles before setting the color and make the visible again afterwards

        if ( bgCircleSec.colorCircle !== sColor ) {
            bgCircleSec.colorCircle = sColor
            bgCircleSec.arcBegin = 1
            bgCircleSec.arcEnd = 360

            bgCircleMin.colorCircle = sColor
            bgCircleMin.arcBegin = 1
            bgCircleMin.arcEnd = 360

            bgCircleH.colorCircle = sColor
            bgCircleH.arcBegin = 1
            bgCircleH.arcEnd = 360
        }
    }


    function setProgress( remainTime_ms ) {

        // timer finished
        if ( remainTime_ms <= 0.0 ) {
            setBgCircleColor( "gold" )
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
        }

        ProgressCircle {
            id : circleHoure
            anchors.centerIn: parent
            size: Math.min( parent.width, parent.height ) * 0.9
            colorCircle: "orchid"
            arcBegin: 0
            arcEnd: 360
            lineWidth: 10

            Component.onCompleted: finishCreation();
        }
    }
}
