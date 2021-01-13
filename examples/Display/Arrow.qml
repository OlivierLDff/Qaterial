import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Item
{
  id: root

  width: 550
  height: 300
  property real value: 0

  Behavior on value { NumberAnimation { duration: 1000 } }

  Timer
  {
    interval: 1500;running: true;repeat: true
    onTriggered: () => value = value ? 0 : 200
  }

  Qaterial.Arrow
  {
    anchors.fill: parent
    start: Qt.vector2d(0 + root.value, 10)
    end: Qt.vector2d(100, 110)

    color: Qaterial.Style.pink
  }

  Qaterial.Arrow
  {
    anchors.fill: parent
    thickness: 4
    start: Qt.vector2d(50 + root.value, 10)
    end: Qt.vector2d(150, 110)

    color: Qaterial.Style.indigo
  }

  Qaterial.Arrow
  {
    anchors.fill: parent
    start: Qt.vector2d(100 + root.value, 10)
    end: Qt.vector2d(200, 110)

    color: Qaterial.Style.orange
    startTail: Qaterial.Arrow.Tail.FilledArrow
  }

  Qaterial.Arrow
  {
    anchors.fill: parent
    thickness: 4
    start: Qt.vector2d(150 + root.value, 10)
    end: Qt.vector2d(250, 110)

    color: Qaterial.Style.red
    startTail: Qaterial.Arrow.Tail.FilledArrow
  }

  Qaterial.Arrow
  {
    anchors.fill: parent
    start: Qt.vector2d(200 + root.value, 10)
    end: Qt.vector2d(300, 110)

    color: Qaterial.Style.green
    endTail: Qaterial.Arrow.Tail.FilledArrow
  }

  Qaterial.Arrow
  {
    anchors.fill: parent
    thickness: 4
    start: Qt.vector2d(250 + root.value, 10)
    end: Qt.vector2d(350, 110)

    color: Qaterial.Style.purple
    endTail: Qaterial.Arrow.Tail.FilledArrow
  }

  Qaterial.Arrow
  {
    anchors.fill: parent
    start: Qt.vector2d(300 + root.value, 10)
    end: Qt.vector2d(400, 110)

    color: Qaterial.Style.grey
    startTail: Qaterial.Arrow.Tail.FilledArrow
    endTail: Qaterial.Arrow.Tail.FilledArrow
  }

  Qaterial.Arrow
  {
    anchors.fill: parent
    thickness: 4
    start: Qt.vector2d(350 + root.value, 10)
    end: Qt.vector2d(450, 110)

    color: Qaterial.Style.teal
    startTail: Qaterial.Arrow.Tail.FilledArrow
    endTail: Qaterial.Arrow.Tail.FilledArrow
  }

  Qaterial.Arrow
  {
    anchors.fill: parent
    start: Qt.vector2d(100, 120)
    end: Qt.vector2d(0 + root.value, 220)

    color: Qaterial.Style.pink
  }

  Qaterial.Arrow
  {
    anchors.fill: parent
    thickness: 4
    headLength: 20
    start: Qt.vector2d(150, 120)
    end: Qt.vector2d(50 + root.value, 220)

    color: Qaterial.Style.indigo
  }

  Qaterial.Arrow
  {
    anchors.fill: parent
    start: Qt.vector2d(200, 120)
    end: Qt.vector2d(100 + root.value, 220)

    color: Qaterial.Style.orange
    startTail: Qaterial.Arrow.Tail.Arrow
  }

  Qaterial.Arrow
  {
    anchors.fill: parent
    thickness: 4
    headLength: 20
    start: Qt.vector2d(250, 120)
    end: Qt.vector2d(150 + root.value, 220)

    color: Qaterial.Style.red
    startTail: Qaterial.Arrow.Tail.Arrow
  }

  Qaterial.Arrow
  {
    anchors.fill: parent
    start: Qt.vector2d(300, 120)
    end: Qt.vector2d(200 + root.value, 220)

    color: Qaterial.Style.green
    endTail: Qaterial.Arrow.Tail.Arrow
  }

  Qaterial.Arrow
  {
    anchors.fill: parent
    thickness: 4
    headLength: 20
    start: Qt.vector2d(350, 120)
    end: Qt.vector2d(250 + root.value, 220)

    color: Qaterial.Style.purple
    endTail: Qaterial.Arrow.Tail.Arrow
  }

  Qaterial.Arrow
  {
    anchors.fill: parent
    start: Qt.vector2d(400, 120)
    end: Qt.vector2d(300 + root.value, 220)

    color: Qaterial.Style.grey
    startTail: Qaterial.Arrow.Tail.Arrow
    endTail: Qaterial.Arrow.Tail.Arrow
  }

  Qaterial.Arrow
  {
    anchors.fill: parent
    thickness: 4
    headLength: 20
    start: Qt.vector2d(450, 120)
    end: Qt.vector2d(350 + root.value, 220)

    gradient: Gradient
    {
      GradientStop { position: 0.0;color: "red" }
      GradientStop { position: 0.33;color: "yellow" }
      GradientStop { position: 1.0;color: "green" }
    }
    startTail: Qaterial.Arrow.Tail.Arrow
    endTail: Qaterial.Arrow.Tail.Arrow
  }

  Qaterial.DebugRectangle { anchors.fill: parent }
}
