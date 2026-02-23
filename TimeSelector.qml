import QtQuick
import QtQuick.Controls.Basic

Item  {
    id: timeSelector
    height: 40
    width: parent.width
    property alias text: label.text
    property alias currentValue: spin.value

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

        from: 1
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
            color: spin.down.pressed ? secondColor : mainColor
        }

        up.indicator: IndicatorButton {
            text: "+"
            anchors.right: parent.right
            color: spin.up.pressed ? secondColor : mainColor
        }

        background: Rectangle {
            height: timeSelector.height
            color: "white"
            border.color: mainColor
            border.width: 2
        }
    }
}
