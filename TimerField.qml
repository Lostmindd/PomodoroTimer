import QtQuick
import QtMultimedia

Rectangle {
    id: timerField
    property color mainColor

    border.color: mainColor
    border.width: 2

    property alias running: counter.running
    property alias phaseLabelText: phaseLabel.phaseLabelText

    property int maxMinutes
    property int focusCount: 0
    property int currentPhase: PomodoroCycle.Phase.Focus

    signal timeOver()
    signal tick()

    PhaseLabel {
        id: phaseLabel
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: time.top
        anchors.margins: 5
        anchors.bottomMargin: -20

        mainColor: timerField.mainColor
    }
    onFocusCountChanged: phaseLabel.fillCycles(focusCount+1)

    Text {
        id: time
        color: mainColor
        font.pointSize: 50
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 8

        text: formatTime(secondsLeft)
        property int secondsLeft: 25 * 60

        function formatTime(seconds) {
            var mins = Math.floor(seconds / 60)
            var secs = seconds % 60

            return mins.toString().padStart(2, "0") + ":" +
                    secs.toString().padStart(2, "0")
        }
    }

    MediaPlayer {
        id: finishSound
        audioOutput: AudioOutput {}
        source: "qrc:/sounds/resources/ring.mp3"
    }

    MediaPlayer {
        id: startSound
        audioOutput: AudioOutput {}
        source: "qrc:/sounds/resources/start.mp3"
    }

    Timer {
        id: counter
        repeat: true

        onTriggered: {
            tick()
            time.secondsLeft = time.secondsLeft - 1
            if (time.secondsLeft < 1) {
                stop()
                parent.timeOver()
                phaseLabel.hideCycles()
                updateTimeLabel()
                return
            }
            else if (time.secondsLeft === 3) {finishSound.play()}
        }
    }

    function updateTimeLabel() {
        if (!running)
            time.secondsLeft = maxMinutes * 60
    }

    function start(minutes) {
        updateTimeLabel()
        startSound.play()
        counter.running = true

        if (currentPhase == PomodoroCycle.Phase.Focus)
            phaseLabel.showCycles()
    }

    function stop() {
        counter.running = false
        finishSound.stop()
        startSound.stop()
        updateTimeLabel()
        phaseLabel.hideCycles()
    }
}
