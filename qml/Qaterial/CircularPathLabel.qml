import QtQuick 2.12
import Qaterial 1.0 as Qaterial

Item
{
  id: root

  property int radius: 100
  property font font: Qaterial.Style.textTheme.body2
  property
  var model: [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
  property int numberOfElement: 12
  property int currentIndex: -1

  property int labelSize: Qaterial.Style.dense ? 24 : 32

  implicitWidth: radius * 2 + labelSize
  implicitHeight: radius * 2 + labelSize

  //Qaterial.DebugRectangle { border.color: "red"; anchors.fill: parent }

  Repeater
  {
    id: _repeater

    function degreesToRadians(degrees) { return degrees * (Math.PI / 180) }

    anchors.centerIn: parent
    model: root.model
    delegate: Qaterial.Label
    {
      readonly property bool checked: root.currentIndex === index
      width: root.labelSize
      height: root.labelSize
      x: -(root.radius) * Math.sin(_repeater.degreesToRadians(index * (360 / root.numberOfElement) + 180)) + (parent
        .width / 2 - width / 2)
      y: (root.radius) * Math.cos(_repeater.degreesToRadians(index * (360 / root.numberOfElement) + 180)) + (parent
        .height / 2 - height / 2)
      text: modelData
      horizontalAlignment: Text.AlignHCenter
      verticalAlignment: Text.AlignVCenter

      font: root.font
      colorReversed: Qaterial.Style.shouldReverseForegroundOnAccent && checked

      onCheckedChanged: () => font.bold = checked

      //Qaterial.DebugRectangle { anchors.fill: parent }
    }
  }
}
