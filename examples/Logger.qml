import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Column
{
  width: 200
  Qaterial.RaisedButton
  {
    text: "Debug"
    width: parent.width
    backgroundColor: Qaterial.Style.blue
    onClicked: () => Qaterial.Logger.debug(`This is a debug message`)
  }
  Qaterial.RaisedButton
  {
    text: "Info"
    width: parent.width
    backgroundColor: Qaterial.Style.green
    onClicked: () => Qaterial.Logger.info(`This is a info message`)
  }
  Qaterial.RaisedButton
  {
    text: "Warning"
    width: parent.width
    backgroundColor: Qaterial.Style.orange
    onClicked: () => Qaterial.Logger.warn(`This is a warning message`)
  }
  Qaterial.RaisedButton
  {
    text: "Error"
    width: parent.width
    backgroundColor: Qaterial.Style.red
    onClicked: () => Qaterial.Logger.error(`This is a error message`)
  }
}
