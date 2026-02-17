import QtQuick
import QtQuick.Controls.Basic

Window {
    width: 300
    height: 400
    visible: true
    title: qsTr("Pomodoro Timer")

    component TimeSelector: Row {
        id: timeSelector
        spacing: 50
        property alias text: label.text

        Text {
            id: label
            font.pointSize: 10
            anchors.verticalCenter: parent.verticalCenter
        }

        SpinBox {
            value: 25
            to: 240
            editable: true
            font.pointSize: 10

            property string suffix: " m"
            textFromValue: value => value + suffix
            valueFromText: value => value.slice(0, -suffix.length)
        }
    }

    Column {
        TimeSelector {
            text: qsTr("Focus")
        }
        TimeSelector {
            text: qsTr("Short Break")
        }
        TimeSelector {
            text: qsTr("Long Break")
        }

        anchors.horizontalCenter: parent.horizontalCenter
    }
}
