import QtQuick
import QtQuick.Shapes

Rectangle  {
    id: scale
    width: parent.width

    readonly property int lineThickness: 2
    readonly property int divisionsNum: 31
    readonly property int bigDivisionsPos: 5
    readonly property int stepsBetweenDivisions: 1

    property int minutes: 0

    component HorizontalLine : Rectangle {
        width: parent.width
        height: lineThickness
        color: mainColor
     }

    HorizontalLine {
        id: topHorizontalLine
        anchors.top: parent.top
    }

    Item {
        id: divisions

        anchors.top: parent.top
        anchors.left: parent.horizontalCenter

        width: parent.width
        height: parent.height
        anchors.leftMargin: -1

        Row {
            id: divisionLines
            topPadding: topHorizontalLine.height + 2

            property int bigDivisionOffset: 0
            property real spacingSize: Math.round((parent.width * 1.1 - divisionsNum * lineThickness) / (divisionsNum - 1))
            spacing: spacingSize

            Repeater {
                model: divisionsNum

                Rectangle {
                    width: lineThickness
                    height: divisionLines.calculateHeight(index)
                    color: mainColor
                }
            }

            function calculateHeight(index) {
                return 6 + ((index + divisionLines.bigDivisionOffset) % bigDivisionsPos == 0 ? 6 : 0)
            }
        }

        component BoundaryLine : Rectangle {
            width: lineThickness
            height: parent.height
            anchors.left: parent.left

            color: mainColor
        }

        BoundaryLine {
            id: stopLine
            anchors.leftMargin: calculateLeftMargin()
            property int offset: 0

            function calculateLeftMargin() {
                var spacingSizeWithDivision = divisionLines.spacingSize + lineThickness
                return (minutes * spacingSizeWithDivision) - offset
            }
        }

        BoundaryLine {
            id: startLine
        }

        NumberAnimation {
            id: animateDivisions
            target: divisions
            properties: "anchors.leftMargin"
            from: divisions.anchors.leftMargin
            to: -1
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

    HorizontalLine {
       anchors.bottom: parent.bottom
    }

    function nextStep() {
        const  spacingSizeWithDivision = divisionLines.spacingSize + lineThickness
        const  stepSize = spacingSizeWithDivision / stepsBetweenDivisions
        const  newPadding = (Math.abs(divisions.anchors.leftMargin) + stepSize)
        const  startOffset = Math.ceil((parent.width / 2) / spacingSizeWithDivision) * spacingSizeWithDivision

        if (newPadding > startOffset) {
            if ((newPadding - startOffset) < spacingSizeWithDivision)
                divisions.anchors.leftMargin = -newPadding
            else {
                divisions.anchors.leftMargin = -((newPadding % spacingSizeWithDivision) + startOffset)
                divisionLines.bigDivisionOffset = (divisionLines.bigDivisionOffset + 1) % bigDivisionsPos
                stopLine.offset += stepSize
            }
        }
        else
            divisions.anchors.leftMargin = - newPadding
    }

    function reset() {
        divisionLines.bigDivisionOffset = 0
        stopLine.offset = 0
        animateDivisions.start()
    }
}
