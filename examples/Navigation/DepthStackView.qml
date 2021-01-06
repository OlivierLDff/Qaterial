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

  readonly property Component stackItem: Item
  {
    Rectangle
    {
      anchors.fill: parent
      anchors.margins: -scaleRatioSlider.value * parent.width
      color: parent.StackView.index >= 0 ? root.colors[parent.StackView.index] : "transparent"
    }

    Rectangle
    {
      anchors.fill: parent
      color: "transparent"
      border.color: "white"
      border.width: 2
    }

    Qaterial.LabelHeadline6
    {
      x: 16
      y: 16

      text: `Depth ${parent.StackView.index.toString()}`
    }
  }

  Qaterial.LabelSubtitle1
  {
    text: "Qaterial.DepthStackView Example"
    anchors.bottom: stackView.top
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.margins: 16
  }

  Qaterial.DepthStackView
  {
    id: stackView

    // Customize the size of the animation
    scaleRatio: scaleRatioSlider.value
    // Customize the duration of the animation
    duration: durationSlider.value

    clip: true

    anchors.centerIn: parent

    width: parent.width / 2
    height: parent.height / 2 - 100

    initialItem: root.stackItem
  }

  Column
  {
    anchors.top: stackView.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.margins: 16

    Row
    {
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

    Qaterial.SliderDelegate
    {
      id: scaleRatioSlider
      text: "scaleRatio"
      secondaryText: `${(stackView.scaleRatio*100).toFixed(0)} %`
      value: 0.3
      from: 0
      to: 1
      stepSize: 0.1
    }

    Qaterial.SliderDelegate
    {
      id: durationSlider
      text: "scaleRatio"
      secondaryText: `${value} ms`
      value: 1000
      from: 0
      to: 10000
      stepSize: 100
    }
  }

}
