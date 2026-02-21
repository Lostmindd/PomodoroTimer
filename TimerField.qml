import QtQuick
import QtMultimedia

Rectangle {
    border.color: mainColor
    border.width: 2
    property int secondsLeft: 0
    property alias running: timer.running

    function formatTime(seconds) {
        var mins = Math.floor(seconds / 60)
        var secs = seconds % 60

        return mins.toString().padStart(2, "0") + ":" +
                secs.toString().padStart(2, "0")
    }

    Text {
        id: time
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

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
            if (secondsLeft < 1) {
                running = false
                visibility = Window.Windowed
                return
            }
            else if (secondsLeft == 4) {bell.play()}
            secondsLeft = secondsLeft - 1
        }
    }
}
