import QtQuick
import QtQuick.Controls.Basic
import QtCore

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

        mainColor: window.mainColor
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

            component PomodoroTimeSelector : TimeSelector {
                mainColor: window.mainColor
                secondColor: window.secondColor
            }

            PomodoroTimeSelector {
                id: focus
                text: qsTr("Focus")
                currentValue: 25
            }
            PomodoroTimeSelector {
                id: shortBreak
                text: qsTr("Short Break")
                currentValue: 5
            }
            PomodoroTimeSelector {
                id: longBreak
                text: qsTr("Long Break")
                currentValue: 15
            }
        }

        // saving time settings
        Settings {
            property alias focusTime: focus.currentValue
            property alias shortBreakTime: shortBreak.currentValue
            property alias longBreakTime: longBreak.currentValue
         }
    }

    PomodoroCycle {
        id: pomodoroCycle
    }

    function phaseMinutes(phase) {
        switch (phase) {
        case PomodoroCycle.Phase.Focus:
            return focus.currentValue
        case PomodoroCycle.Phase.ShortBreak:
            return shortBreak.currentValue
        case PomodoroCycle.Phase.LongBreak:
            return longBreak.currentValue
        }
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
                scale.reset()
            }
            else {
                timer.start(phaseMinutes(pomodoroCycle.currentPhase))
                scale.minutes = phaseMinutes(pomodoroCycle.currentPhase)
                scale.reset()
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

        mainColor: window.mainColor

        maxMinutes: phaseMinutes(pomodoroCycle.currentPhase)
        currentPhase: pomodoroCycle.currentPhase
        phaseLabelText: pomodoroCycle.phaseAsText(pomodoroCycle.currentPhase)
        focusCount: pomodoroCycle.focusCount

        onTimeOver: {
            visibility = Window.Windowed
            pomodoroCycle.nextStep()
        }
        onTick: scale.nextStep()

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
