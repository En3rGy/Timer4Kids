import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.0
import QtQuick.Particles 2.0

Page1Form {
    id: page1Form
    property alias labelTimerText : labelTimer.text
    property alias labelColor: labelTimer.color
    property alias rectColor: rect.color

    property int imgWidth : 40
    property int imgHeight : 40
    property int imgAmount : 5

    function setProgress( prct ) {
        dial.value = 100 - prct

        imgProgr.x = img5.x * ( prct / 100.0 )

        if ( prct === 100.0 ) {
            imgSun.visible = true
            img1.visible = false
            img2.visible = false
            img3.visible = false
            img4.visible = false
            img5.visible = false
            imgProgr.visible = false
        }
        else {
            imgSun.visible = false
            img1.visible = true
            img2.visible = true
            img3.visible = true
            img4.visible = true
            img5.visible = true
            imgProgr.visible = true
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
        id : rect
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
            anchors.centerIn: parent
            width: 20; height: 20
            system: particleSystem
            emitRate: 20
            lifeSpan: 1000
            lifeSpanVariation: 500
            size: 10
            endSize: 32
            //Tracer { color: 'green' }
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

    Image {
        id: imgSun
        source: "qrc:/img/happy-sun-gm.svg"
        sourceSize.height: 150
        sourceSize.width: 150
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        visible: false
    }
}
