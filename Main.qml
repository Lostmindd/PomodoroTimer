import QtQuick
import QtQuick.Controls.Basic

Window {
    id: window
    visible: true
    title: qsTr("Pomodoro Timer")

    width: 380
    height: 460
    maximumHeight: height
    maximumWidth: width
    minimumHeight: height
    minimumWidth: width

    property color mainColor: "#AD2525"
    property color secondColor: "#9E2222"

    TimerScale {
        id: scale

        height: 40
        // anchors.left: parent.left
        // anchors.bottom: parent.top
    }

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
                id: focus
                text: qsTr("Focus")
                currentValue: 3 //25
            }
            TimeSelector {
                id: shortBreak
                text: qsTr("Short Break")
                currentValue: 1//5
            }
            TimeSelector {
                id: longBreak
                text: qsTr("Long Break")
                currentValue: 4//15
            }
        }
    }

    PomodoroCycle {
        id: pomodoroCycle
    }

    Button {
        id: startButton

        anchors.margins: 20
        anchors.top: settings.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: 120
        height: 40
        text: timer.running? qsTr("stop") : qsTr("start")
        background: Rectangle {
            color: parent.down ? secondColor : mainColor
        }

        palette.buttonText: "white"
        font.pointSize: 22
        contentItem.anchors.verticalCenter: verticalCenter
        contentItem.anchors.verticalCenterOffset: -2

        onClicked: {
            if (timer.running){
                pomodoroCycle.reset()
                timer.stop()
            }
            else{
                timer.start(pomodoroCycle.currentMinutes())
            }
        }
    }

    TimerField {
        id: timer
        anchors.margins: 10
        width: 240
        height: 120
        anchors.top: startButton.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        Connections {
            target: focus
            function onCurrentValueChanged(){timer.updateTimeLabel()}
        }
        Connections {
            target: shortBreak
            function onCurrentValueChanged(){timer.updateTimeLabel()}
        }
        Connections {
            target: longBreak
            function onCurrentValueChanged(){timer.updateTimeLabel()}
        }
    }
}
