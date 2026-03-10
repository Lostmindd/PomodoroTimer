import QtQuick
import QtQuick.Shapes

Rectangle  {
    id: scale
    width: parent.width

    property int lineThickness: 2
    property int divisionsNum: 31

    component Line : Rectangle {
        width: parent.width
        height: lineThickness
        color: mainColor
     }

    Line {
       anchors.top: parent.top
    }

    Row {
        id: divisions
        anchors.top: parent.top
        topPadding: lineThickness + 2
        property int offset: 0

        spacing: (parent.width - divisionsNum * lineThickness) / (divisionsNum - 1)
        Repeater {
            model: divisionsNum

            Rectangle {
                width: lineThickness
                height: 6 + ((index - divisions.offset) % 5 == 0 ? 6 : 0)
                color: mainColor
            }
        }
    }

    Shape {
        id: triangle

        layer.enabled: true
        layer.samples: 8

        width: parent.width / 24
        height: parent.height / 2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom

        ShapePath {
            fillColor: mainColor

            startX: 0
            startY: triangle.height

            PathLine { x: triangle.width/2; y: 0 }
            PathLine { x: triangle.width; y: triangle.height }
            PathLine { x: 0; y: triangle.height }
        }
    }

    Line {
       anchors.bottom: parent.bottom
    }

    function nextStep() {
        divisions.offset = (divisions.offset + 1) % 5
    }

    function reset() {
        divisions.offset = 0
    }
}
