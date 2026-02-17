import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Window {
    id: window
    width: 300
    height: 400
    visible: true
    title: qsTr("Pomodoro Timer")

    component TimeSelector: RowLayout  {
        id: timeSelector
        spacing: 20
        Layout.maximumWidth: 300

        property alias text: label.text

        Text {
            id: label
            font.pointSize: 10
            Layout.alignment: Qt.AlignVCenter
        }
        Item { Layout.fillWidth: true } // spacer
        SpinBox {
            value: 25
            to: 240
            editable: true
            font.pointSize: 10
            Layout.alignment: Qt.AlignVCenter

            property string suffix: " m"
            textFromValue: value => value + suffix
            valueFromText: value => value.slice(0, -suffix.length)
        }
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
