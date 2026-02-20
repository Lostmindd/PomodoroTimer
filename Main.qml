import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Window {
    visible: true
    title: qsTr("Pomodoro Timer")

    width: 280
    // width: 380
    height: 200
    // height: 460
    maximumHeight: height
    maximumWidth: width
    minimumHeight: height
    minimumWidth: width

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

    component TimeSelector: RowLayout  {
        id: timeSelector
        spacing: 20
        height: 30
        property alias value: spin.value
        property alias text: label.text
        property color mainColor: "#AD2525"
        property color darkColor: "#9E2222"

        Text {
            id: label
            font.pointSize: 10
            Layout.alignment: Qt.AlignVCenter
        }

        Item { Layout.fillWidth: true } // spacer

        SpinBox {
            id: spin
            to: 240
            editable: true
            font.pointSize: 10
            property string suffix: " m"

            Layout.alignment: Qt.AlignVCenter
            Layout.minimumWidth: 120

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
                border.width: 1
            }
        }
    }

    component TimerScale: RowLayout  {
        
    }
    
    ToolBar {
        background: TimerScale
    }

    ColumnLayout  {
        anchors.fill: parent
        anchors.margins: 20

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
            value: 15
        }
    }
}
