import QtQuick 2.4
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    property alias spinSecondValue: spinSecond.value
    property alias spinMinuteValue: spinMinute.value
    property alias spinHourValue: spinHour.value
    property alias alarmSwitchChecked: alarmSwitch.checked
    property alias autostartSwitchChecked: autostartSwitch.checked

    property alias buttonQuit: buttonQuit
    property alias buttonState: buttonState
    property alias flickable: flickable

    anchors.fill: parent
    anchors.margins: 9

    Flickable {
        id: flickable
        anchors.fill: parent
        contentWidth: parent.width
        contentHeight: column.height

        ColumnLayout {
            id: column
            width: parent.width - 10 // to show scroll bar

            RowLayout {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Switch {
                    id: alarmSwitch
                    Layout.fillWidth: true
                    text: "Is Alarm (instead of Timer)"
                    checked: settings.bIsAlarm
                }

                Switch {
                    id: autostartSwitch
                    text: "Auto start"
                    checked: settings.bAutostartEnabled
                    Layout.fillWidth: true
                }
            }

            RowLayout {
                Layout.fillHeight: true
                Layout.fillWidth: true

                ColumnLayout {
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Label {
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                        text: "Hours"
                    }

                    SpinBox {
                        Layout.fillWidth: true
                        id: spinHour
                        value: settings.hour
                    }
                }

                ColumnLayout {
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Label {
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                        text: "Minutes"
                    }

                    SpinBox {
                        Layout.fillWidth: true
                        id: spinMinute
                        to: 60
                        value: settings.min
                    }
                }

                ColumnLayout {
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Label {
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                        text: "Seconds"
                    }

                    SpinBox {
                        Layout.fillWidth: true
                        id: spinSecond
                        to: 60
                        value: settings.sec
                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: parent.width / 3

                Button {
                    id: buttonState
                    text: "Initializing"
                    Layout.fillWidth: true
                }

                Button {
                    id: buttonQuit
                    text: "Quit"
                    Layout.fillWidth: true
                }
            }

            Label {
                text: Qt.application.displayName + " v" + Qt.application.version
                      + " by " + Qt.application.organization
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignRight
            }
        } // column
    } // flickable
}


/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
