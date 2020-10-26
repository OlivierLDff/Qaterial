import QtQuick 2.12
import Qaterial 1.0 as Qaterial

Row
{
  id: root

  property int textType: Qaterial.Style.TextType.Caption
  property int size: Qaterial.Style.roundIcon.size
  property
  var model: ["M", "T", "W", "T", "F", "S", "S"]

  Repeater
  {
    model: root.model
    delegate: Qaterial.Label
    {
      text: modelData
      textType: root.textType

      width: root.size
      height: root.size

      horizontalAlignment: Text.AlignHCenter
      verticalAlignment: Text.AlignVCenter
    }
  }
}
