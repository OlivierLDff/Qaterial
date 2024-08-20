import QtQuick
import Qaterial as Qaterial

Column
{
  Qaterial.CheckButton
  {
    text: "CheckButton 1"
    checkState: Qt.Unchecked
  }
  Qaterial.CheckButton
  {
    id: button2
    text: "CheckButton 2"
    checkState: Qt.Checked
  }
  Qaterial.CheckButton
  {
    text: "CheckButton 3"
    checkState: button2.checkState
  }
}
