import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.RectangleAreaHandler
{
  id: root

  start: Qt.vector2d(0.25, 0.25)
  end: Qt.vector2d(0.75, 0.75)

  width: parent.width
  height: parent.height

  horizontalReverseAllowed: _horizontalReversedAllowed.checked
  verticalReverseAllowed: _verticalReversedAllowed.checked

  Column
  {
    anchors.centerIn: parent

    Qaterial.SwitchButton
    {
      id: _horizontalReversedAllowed
      text: "Allow horizontal reverse"
      checked: true
    }
    Qaterial.SwitchButton
    {
      id: _verticalReversedAllowed
      text: "Allow vertical reverse"
      checked: true
    }
  }
}
