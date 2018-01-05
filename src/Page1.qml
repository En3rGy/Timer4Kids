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
    property bool emitterActive

    property bool bImg1Passed : false
    property bool bImg2Passed : false
    property bool bImg3Passed : false
    property bool bImg4Passed : false
    property bool bImg5Passed : false

    function setProgress( prct ) {
        imgProgr.x = img5.x * ( prct / 100.0 )

        if ( prct >= 100.0 ) {
            imgProgr.visible = false
            imgSun.state = "visible"
            rect.state = "color"
            emitter.enabled = false
        }
        else if ( prct === 0.0 ) {
            imgSun.state = "hidden"
            rect.state = "black"
            imgProgr.visible = true
            emitter.enabled = emitterActive
            bImg1Passed = false
            bImg2Passed = false
            bImg3Passed = false
            bImg4Passed = false
            bImg5Passed = false
            img1.source = "qrc:/img/star_silver.svg"
            img2.source = "qrc:/img/star_silver.svg"
            img3.source = "qrc:/img/star_silver.svg"
            img4.source = "qrc:/img/star_silver.svg"
            img5.source = "qrc:/img/star_silver.svg"
        }
        else if ( ( prct >= 100.0 / (imgAmount - 1) * 0 ) && ( bImg1Passed === false ) ) { // img 1
            img1.source = "qrc:/img/star_gold.svg"
            bImg1Passed = true
        }
        else if ( ( prct >= 100.0 / (imgAmount - 1) * 1 ) && ( bImg2Passed === false ) ) { // img 2
            img2.source = "qrc:/img/star_gold.svg"
            bImg2Passed = true
        }
        else if ( ( prct >= 100.0 / (imgAmount - 1) * 2 ) && ( bImg3Passed === false ) ) { // img 3
            img3.source = "qrc:/img/star_gold.svg"
            bImg3Passed = true
        }
        else if ( ( prct >= 100.0 /  (imgAmount - 1) * 3  ) && ( bImg4Passed === false ) ) { // img 4
            img4.source = "qrc:/img/star_gold.svg"
            bImg4Passed = true
        }
        else if ( ( prct >= 100.0 / (imgAmount - 1) * 4 ) && ( bImg5Passed === false ) ) { // img 5
            img5.source = "qrc:/img/star_gold.svg"
            bImg5Passed = true
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
        id: img1
        source : "qrc:/img/star_silver.svg"
        sourceSize.height: imgHeight
        sourceSize.width: imgWidth
        x : ( parent.width - imgWidth ) / 4 * 0
        anchors.verticalCenter: parent.verticalCenter
    }

    Image {
        id: img2
        source : "qrc:/img/star_silver.svg"
        sourceSize.height: imgHeight
        sourceSize.width: imgWidth
        x : ( parent.width - imgWidth ) / 4 * 1
        anchors.verticalCenter: parent.verticalCenter
    }

    Image {
        id: img3
        source : "qrc:/img/star_silver.svg"
        sourceSize.height: imgHeight
        sourceSize.width: imgWidth
        x : ( parent.width - imgWidth ) / 4 * 2
        anchors.verticalCenter: parent.verticalCenter
    }

    Image {
        id: img4
        source : "qrc:/img/star_silver.svg"
        sourceSize.height: imgHeight
        sourceSize.width: imgWidth
        x : ( parent.width - imgWidth ) / 4 * 3
        anchors.verticalCenter: parent.verticalCenter
    }

    Image {
        id: img5
        source : "qrc:/img/star_silver.svg"
        sourceSize.height: imgHeight
        sourceSize.width: imgWidth
        x : ( parent.width - imgWidth ) / 4 * 4
        anchors.verticalCenter: parent.verticalCenter
    }

    Image {
        id: imgProgr
        source : "qrc:/img/star_gold.svg"
        sourceSize.height: imgHeight
        sourceSize.width: imgWidth
        x : ( parent.width - imgWidth ) / 4 * 0
        anchors.verticalCenter: parent.verticalCenter

        ParticleSystem {
            id: particleSystem
        }

        Emitter {
            id: emitter
            enabled: false
            anchors.centerIn: parent
            width: 20; height: 20
            system: particleSystem
            emitRate: 5
            lifeSpan: 1000
            lifeSpanVariation: 500
            size: 10
            endSize: 32
            velocity: AngleDirection   {
                angle: 180
                angleVariation: 30
                magnitude: 80
                magnitudeVariation: 20
            }
        }

        ImageParticle {
            source: "qrc:/img/star_gold.svg"
            system: particleSystem
            rotation: 0
            rotationVariation: 45
            rotationVelocity: 15
            rotationVelocityVariation: 15
            entryEffect: ImageParticle.Scale
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
