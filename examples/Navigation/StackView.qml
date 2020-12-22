import QtQuick 2.0
import QtQuick.Controls 2.0
import Qaterial 1.0 as Qaterial

Item
{
  id: root

  anchors.fill: parent

  readonly property
  var colors: [
    Qaterial.Colors.red,
    Qaterial.Colors.pink,
    Qaterial.Colors.purple,
    Qaterial.Colors.deepPurple,
    Qaterial.Colors.indigo,
    Qaterial.Colors.blue,
    Qaterial.Colors.lightBlue,
    Qaterial.Colors.cyan,
    Qaterial.Colors.teal,
    Qaterial.Colors.green,
    Qaterial.Colors.lightGreen,
    Qaterial.Colors.lime,
    Qaterial.Colors.yellow,
    Qaterial.Colors.amber,
    Qaterial.Colors.orange,
    Qaterial.Colors.deepOrange,
    Qaterial.Colors.brown,
    Qaterial.Colors.gray,
    Qaterial.Colors.blueGray,
  ]

  readonly property Component stackItem: Rectangle
  {
    color: StackView.index >= 0 ? root.colors[StackView.index] : "transparent"

    Qaterial.LabelHeadline6
    {
      anchors.centerIn: parent
      text: parent.StackView.index.toString()
    }
  }

  Qaterial.StackView
  {
    id: stackView

    width: parent.width
    height: parent.height - 100

    initialItem: root.stackItem
  }

  Row
  {
    anchors.top: stackView.bottom
    anchors.horizontalCenter: parent.horizontalCenter

    Qaterial.FlatButton
    {
      text: "pop"
      icon.source: Qaterial.Icons.arrowLeft
      onClicked: function()
      {
        if(stackView.depth > 1)
          stackView.pop()
      }
    }

    Qaterial.FlatButton
    {
      LayoutMirroring.enabled: true
      text: "push"
      icon.source: Qaterial.Icons.arrowRight
      onClicked: function()
      {
        if(stackView.depth < 19)
          stackView.push(root.stackItem)
      }
    }
  }
}
