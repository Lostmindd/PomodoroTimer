import QtQuick
import QtMultimedia

Rectangle {
    border.color: mainColor
    border.width: 2

    function start(minutes) {
        var secs = minutes * 60
        time.secondsLeft = secs
        running = true
    }

    Text {
        function formatTime(seconds) {
            var mins = Math.floor(seconds / 60)
            var secs = seconds % 60

            return mins.toString().padStart(2, "0") + ":" +
                    secs.toString().padStart(2, "0")
        }

        id: time
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        property int secondsLeft: 5

        text: formatTime(secondsLeft)
        color: mainColor
        font.pointSize: 50
    }

    MediaPlayer {
        id: bell
        audioOutput: AudioOutput {}
        source: "qrc:/sounds/resources/ring.mp3"
    }

    Timer {
        id: timer
        running: true;
        repeat: true
        onTriggered: {
            if (time.secondsLeft < 1) {
                running = false
                return
            }
            else if (time.secondsLeft == 1) {visibility = Window.Windowed}
            else if (time.secondsLeft == 4) {bell.play()}
            time.secondsLeft = time.secondsLeft - 1
        }
    }
}
