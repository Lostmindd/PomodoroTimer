import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Window {
    visible: true
    title: qsTr("Pomodoro Timer")

    width: 300
    height: 200
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
            font.pointSize: 32
            color: "white"
        }
    }

    component TimeSelector: RowLayout  {
        id: timeSelector
        spacing: 20
        Layout.maximumWidth: 300
        height: 40

        property alias text: label.text

        Text {
            id: label
            font.pointSize: 10
            Layout.alignment: Qt.AlignVCenter
        }

        Item { Layout.fillWidth: true } // spacer

        SpinBox {
            id: spin
            value: 10
            to: 240
            editable: true
            font.pointSize: 10
            property string suffix: " m"

            Layout.alignment: Qt.AlignVCenter
            Layout.minimumWidth: 130

            textFromValue: value => value + suffix
            valueFromText: value => parseInt(value)


            down.indicator: IndicatorButton {
                text: "-"
                color: spin.down.pressed ? "#9E2222" : "#AD2525"
            }

            up.indicator: IndicatorButton {
                text: "+"
                anchors.right: parent.right
                color: spin.up.pressed ? "#9E2222" : "#AD2525"
            }

            background: Rectangle {
                height: timeSelector.height
                color: "white"
                border.color: "#7D1919"
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
        }
        TimeSelector {
            text: qsTr("Short Break")
        }
        TimeSelector {
            text: qsTr("Long Break")
        }
    }
}
