import QtQml 2.2
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Particles 2.0

Page1Form {
    id: page1Form

    function setProgress( remainTime_ms ) {

        if ( remainTime_ms === 0.0 ) {
            imgProgr.visible = false
            imgSun.state = "visible"
            rect.state = "color"
        }

        else {
            imgSun.state = "hidden"
            rect.state = "black"

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
            component.createObject(rectBack, {
                                       "anchors.centerIn": rectBack,
                                       "size": Math.min( rectBack.width, rectBack.height ) * 0.5,
                                       "colorCircle": "black",
                                       "colorBackground": "#E6E6E6",
                                       "arcBegin": i * 360 / 60 - 1,
                                       "arcEnd": i * 360 / 60 + 1,
                                       "lineWidth": 12,
                                       "z": 10 });

            component.createObject(rectBack, {
                                       "anchors.centerIn": rectBack,
                                       "size": Math.min( rectBack.width, rectBack.height ) * 0.7,
                                       "colorCircle": "black",
                                       "colorBackground": "#E6E6E6",
                                       "arcBegin": i * 360 / 60 - 1,
                                       "arcEnd": i * 360 / 60 + 1,
                                       "lineWidth": 12,
                                       "z": 10 });
        }

        for ( var j = 0; j < 24; ++j ) {
            component.createObject(rectBack, {
                                       "anchors.centerIn": rectBack,
                                       "size": Math.min( rectBack.width, rectBack.height ) * 0.9,
                                       "colorCircle": "black",
                                       "colorBackground": "#E6E6E6",
                                       "arcBegin": j * 360 / 24 - 1,
                                       "arcEnd": j * 360 / 24 + 1,
                                       "lineWidth": 12,
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
            id : circleSec
            anchors.centerIn: parent
            size: Math.min( parent.width, parent.height ) * 0.5
            colorCircle: "orangered"
            colorBackground: "#E6E6E6"
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
            colorBackground: "#E6E6E6"
            arcBegin: 0
            arcEnd: 360
            lineWidth: 10
        }

        ProgressCircle {
            id : circleHoure
            anchors.centerIn: parent
            size: Math.min( parent.width, parent.height ) * 0.9
            colorCircle: "orchid"
            colorBackground: "#E6E6E6"
            arcBegin: 0
            arcEnd: 360
            lineWidth: 10

            Component.onCompleted: finishCreation();
        }



    }

    Rectangle {
        id : rect
        anchors.fill: parent
        color: "black"
        opacity: 0

        states: [
            State {
                name: "color"
                PropertyChanges {
                    target: rect
                    color: "darkorange"
                    opacity: 100
                }
            },
            State {
                name: "black"
                PropertyChanges {
                    target: rect
                    color: "black"
                    opacity: 0
                }
            }
        ]

        transitions: [
            Transition {
                from: "black"
                to: "color"
                OpacityAnimator{ duration: 2000; easing.type: Easing.InOutQuint }
            }
        ]
    }

    Image {
        id: imgSun
        source: "qrc:/img/happy-sun-gm.svg"
        sourceSize.height: parent.height * 0.8
        sourceSize.width: parent.height * 0.8
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        visible: false
        //rotation: -90

        states: [
            State {
                name: "visible"
                PropertyChanges {
                    target: imgSun
                    visible: true
                }
            },
            State {
                name: "hidden"
                PropertyChanges {
                    target: imgSun
                    visible: false
                }
            }
        ]
    } // image
}
