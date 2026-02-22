import QtQuick
import QtMultimedia

Rectangle {
    border.color: mainColor
    border.width: 2
    property alias running: counter.running
    property alias phase: phaseLabel.text
    // property alias secondLeft: time.secondsLeft

    function updateTimeLabel() {
        if (!running)
            time.secondsLeft = pomodoroCycle.currentMinutes() //* 60
    }

    function start(minutes) {
        updateTimeLabel()
        startSound.play()
        counter.running = true
    }

    function stop() {
        counter.running = false
        bell.stop()
        startSound.stop()
        updateTimeLabel()
    }

    Text {
        id: phaseLabel
        text: pomodoroCycle.currentPhaseAsText()
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 14
        color: mainColor
        font.pointSize: 14
    }

    Text {
        id: time
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 8

        property int secondsLeft: pomodoroCycle.currentMinutes() //* 60
        function formatTime(seconds) {
            var mins = Math.floor(seconds / 60)
            var secs = seconds % 60

            return mins.toString().padStart(2, "0") + ":" +
                    secs.toString().padStart(2, "0")
        }
        text: formatTime(secondsLeft)
        color: mainColor
        font.pointSize: 50
    }

    MediaPlayer {
        id: bell
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
            time.secondsLeft = time.secondsLeft - 1
            if (time.secondsLeft < 1) {
                stop()
                pomodoroCycle.nextStep()
                time.secondsLeft = pomodoroCycle.currentMinutes() //* 60
                visibility = Window.Windowed
                return
            }
            else if (time.secondsLeft == 3) {bell.play()}
        }
    }
}
