import QtQuick

Rectangle {
    property alias phaseLabelText: phaseLabel.text
    property color mainColor

    Text {
        id: phaseLabel
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: mainColor
        font.pointSize: 14
    }

    Row {
        id: cycles
        spacing: 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Repeater {
            id: completeRepeater
            model: 1
            Rectangle {
                width: 10; height: 10
                color: mainColor
            }
        }
        Repeater {
            id: emptyRepeater
            model: 3
            Rectangle {
                width: 10; height: 10
                border.width: 2
                border.color: mainColor
            }
        }
        visible: false
    }

    function fillCycles (count) {
       if (count > 4 || count < 0)
           return

       completeRepeater.model = count
       emptyRepeater.model = 4 - count
    }

    function showCycles() {
        cycles.visible = true
        phaseLabel.visible = false
    }

    function hideCycles() {
        cycles.visible = false
        phaseLabel.visible = true
    }
}
