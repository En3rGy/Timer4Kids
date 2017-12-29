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

    function setProgress( prct ) {
        imgProgr.x = img5.x * ( prct / 100.0 )

        if ( prct === 100.0 ) {
            imgProgr.visible = false
            imgSun.state = "visible"
            rect.state = "color"
            emitter.enabled = false
        }
        else {
            imgSun.state = "hidden"
            rect.state = "black"
            imgProgr.visible = true
            emitter.enabled = emitterActive
        }

        if ( prct >= 100.0 / (imgAmount - 1) * 0 ) {
            img1.source = "qrc:/img/star_gold.svg"
        }
        else {
            img1.source = "qrc:/img/star_silver.svg"
        }

        if ( prct >= 100.0 / (imgAmount - 1) * 1 ) {
            img2.source = "qrc:/img/star_gold.svg"
        }
        else {
            img2.source = "qrc:/img/star_silver.svg"
        }

        if ( prct >= 100.0 / (imgAmount - 1) * 2 ) {
            img3.source = "qrc:/img/star_gold.svg"
        }
        else {
            img3.source = "qrc:/img/star_silver.svg"
        }

        if ( prct >= 100.0 /  (imgAmount - 1) * 3  ) {
            img4.source = "qrc:/img/star_gold.svg"
        }
        else {
            img4.source = "qrc:/img/star_silver.svg"
        }

        if ( prct >= 100.0 / (imgAmount - 1) * 4 ) {
            img5.source = "qrc:/img/star_gold.svg"
        }
        else {
            img5.source = "qrc:/img/star_silver.svg"
        }
    }

    Rectangle {
        id : rectBack
        anchors.fill: parent
        color: "black"
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
            emitRate: 20
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
