import QtQuick
import Qaterial as Qaterial

Row
{
  id: root

  property int size: Qaterial.Style.roundIcon.size
  property
  var model: ["M", "T", "W", "T", "F", "S", "S"]

  Repeater
  {
    model: root.model
    delegate: Qaterial.LabelCaption
    {
      text: modelData

      width: root.size
      height: root.size

      horizontalAlignment: Text.AlignHCenter
      verticalAlignment: Text.AlignVCenter
    }
  }
}
