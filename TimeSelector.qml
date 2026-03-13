import QtQuick
import QtQuick.Controls.Basic

Item  {
    id: timeSelector
    height: 40
    width: parent.width

    readonly property int min: 1
    readonly property int max: 240

    property alias text: label.text
    property alias currentValue: spinner.value

    property color mainColor
    property color secondColor

    Text {
        id: label
        anchors.left: timeSelector.left
        anchors.verticalCenter: timeSelector.verticalCenter
        font.pointSize: 14
    }

    SpinBox {
        id: spinner
        anchors.right: timeSelector.right

        implicitWidth: 160

        from: timeSelector.min
        to: timeSelector.max
        editable: true
        font.pointSize: 14

        readonly property string suffix: " m"

        textFromValue: value => spinner.activeFocus? value : value + suffix
        valueFromText: value => parseInt(value)

        // textFromValue is not called without changing the value to a new one
        onActiveFocusChanged: {
            if (activeFocus)
            {
                const val = spinner.value
                spinner.value = -1
                spinner.value = val
            }
        }

        component IndicatorButton : Rectangle {
            implicitWidth: timeSelector.height
            implicitHeight: timeSelector.height
            color: mainColor
            property alias text: buttonText.text
            Text {
                id: buttonText
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -4
                font.pointSize: 24
                color: "white"
            }
        }

        down.indicator: IndicatorButton {
            text: "-"
            color: spinner.down.pressed ? secondColor : mainColor
        }

        up.indicator: IndicatorButton {
            text: "+"
            anchors.right: parent.right
            color: spinner.up.pressed ? secondColor : mainColor
        }

        background: Rectangle {
            height: timeSelector.height
            color: "white"
            border.color: mainColor
            border.width: 2
        }
    }
}
