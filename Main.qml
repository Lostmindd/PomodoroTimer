import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Window {
    id: window
    visible: true
    title: qsTr("Pomodoro Timer")

    // width: 280
    width: 380
    // height: 200
    height: 460
    maximumHeight: height
    maximumWidth: width
    minimumHeight: height
    minimumWidth: width

    property color mainColor: "#AD2525"
    property color darkColor: "#9E2222"

    component IndicatorButton : Rectangle {
        implicitWidth: timeSelector.height
        implicitHeight: timeSelector.height
        color: "#AD2525"
        property alias text: buttonText.text
        Text {
            id: buttonText
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -4
            font.pointSize: 26
            color: "white"
        }
    }

    component TimeSelector: Item  {
        id: timeSelector
        height: 40
        width: parent.width
        property alias value: spin.value
        property alias text: label.text

        Text {
            id: label
            anchors.left: timeSelector.left
            anchors.verticalCenter: timeSelector.verticalCenter
            font.pointSize: 14
        }

        SpinBox {
            id: spin
            anchors.right: timeSelector.right
            implicitWidth: 160

            to: 240
            editable: true
            font.pointSize: 14
            property string suffix: " m"

            textFromValue: value => spin.activeFocus? value : value + suffix
            valueFromText: value => parseInt(value)

            // textFromValue is not called without changing the value to a new one
            onActiveFocusChanged: {
                if (activeFocus)
                {
                    const val = spin.value
                    spin.value = -1
                    spin.value = val
                }
            }

            down.indicator: IndicatorButton {
                text: "-"
                color: spin.down.pressed ? darkColor : mainColor
            }

            up.indicator: IndicatorButton {
                text: "+"
                anchors.right: parent.right
                color: spin.up.pressed ? darkColor : mainColor
            }

            background: Rectangle {
                height: timeSelector.height
                color: "white"
                border.color: mainColor
                border.width: 2
            }
        }
    }

    component TimerScale: Rectangle  {
        width: parent.width
        border.color: mainColor
        border.width: 2
    }

    TimerScale {
        id: scale

        height: 40
        // anchors.left: parent.left
        // anchors.bottom: parent.top
    }

    // ToolBar {
    //     background: TimerScale
    // }

    Rectangle {
        id: settings
        anchors.top: scale.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 20
        height: col.implicitHeight

        Column  {
            id: col
            width: parent.width
            spacing: 40

            TimeSelector {
                text: qsTr("Focus")
                value: 25
            }
            TimeSelector {
                text: qsTr("Short Break")
                value: 5
            }
            TimeSelector {
                text: qsTr("Long Break")
                value: 150
            }
        }
    }

}
