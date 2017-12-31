import QtQml 2.2
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Particles 2.0

Page1Form {
    id: page1Form
    property alias labelTimerText : labelTimer.text
    property alias labelColor: labelTimer.color

    property int imgWidth : parent.height / 5
    property int imgHeight : parent.height / 5
    property int imgAmount : 5

    property int nCounterMinute_ms : 0
    property int nAltMinY : applicationWindow.height * 0.5 * 0.5
    property int nAltMinX : applicationWindow.width * 0.5 * 0.5

    property int nAltHrY  : applicationWindow.height * 0.5 * 0.9
    property int nAltHrX  : applicationWindow.width * 0.5 * 0.9

    function positionStart() {
        nCounterMinute_ms = 0

        var nOffX = applicationWindow.width * 0.5
        var nOffY = applicationWindow.height * 0.5

        var nMinStar = 12
        for( var i = 0; i < nMinStar; ++i ) {
            var nPosX = nAltMinX * Math.cos( 2.0 * Math.PI / nMinStar * i ) + nOffX - parent.height / 20;
            var nPosY = nAltMinY * Math.sin( 2.0 * Math.PI / nMinStar * i ) + nOffY - parent.height / 20;
            var img = Qt.createComponent( "Indicator.qml" );
            img.createObject( page1Form, { "x": nPosX, "y": nPosY, "height": parent.height / 10, "width": parent.height / 10 } )
        }

        var nHHStar = 24
        for( var i2 = 0; i2 < nHHStar; ++i2 ) {
            var nPosX2 = nAltHrX * Math.cos( 2.0 * Math.PI / nHHStar * i2 ) + nOffX;
            var nPosY2 = nAltHrY * Math.sin( 2.0 * Math.PI / nHHStar * i2 ) + nOffY;
            var img2 = Qt.createComponent( "Indicator.qml" );
            img2.createObject( page1Form, { "x": nPosX2, "y": nPosY2, "height": parent.height / 10, "width": parent.height / 10 } )
        }
    }

    function updateIndicator() {
        nCounterMinute_ms += uiUpdateTimer.interval
        if ( nCounterMinute_ms >= 60000 ) {
            nCounterMinute_ms = 0
        }

        var dPos = 2.0 * Math.PI * ( nCounterMinute_ms / 60000 ) - Math.PI / 2.0; // - PI/2 for starting at 0 o'clock
        var nOffX  = applicationWindow.width * 0.5 - imgProgr.width / 2
        var nOffY  = applicationWindow.height * 0.5 - imgProgr.height / 2
        var nX     = nAltMinX * Math.cos( dPos ) + nOffX
        var nY     = nAltMinY * Math.sin( dPos ) + nOffY

        imgProgr.x = nX
        imgProgr.y = nY


        var img3 = Qt.createComponent( "Indicator.qml" );
        var nX2 = nAltMinX * Math.cos( dPos ) + applicationWindow.width * 0.5 - 5.0 / 2.0
        var nY2 = nAltMinY * Math.sin( dPos ) + applicationWindow.height * 0.5 - 5.0/2.0

        img3.createObject( page1Form, { "x": nX2, "y": nY2, "height": 5, "width": 5 } )
    }

    function setProgress( prct ) {
        if ( prct === 100.0 ) {
            imgProgr.visible = false
            imgSun.state = "visible"
            rect.state = "color"
        }
        else {
            imgSun.state = "hidden"
            rect.state = "black"
            imgProgr.visible = true
        }

        //        if ( prct >= 100.0 / (imgAmount - 1) * 4 ) {
        //            img5.source = "qrc:/img/star_gold.svg"
        //        }
        //        else {
        //            img5.source = "qrc:/img/star_silver.svg"
        //        }
    }

    Rectangle {
        id : rectBack
        anchors.fill: parent
        color: "black"

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.BlankCursor
        }
    }

    Label {
        id: labelTimer
        text: "Timer4Kids"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        font.pointSize: 14
        anchors.horizontalCenter: parent.horizontalCenter
        Layout.fillWidth: true
        color: "silver"
    }

    Image {
        id: imgProgr
        source : "qrc:/img/star_gold.svg"
        sourceSize.height: imgHeight
        sourceSize.width: imgWidth
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
