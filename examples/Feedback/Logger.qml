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
    onClicked: () => console.debug(`This is a debug message`)
  }
  Qaterial.RaisedButton
  {
    text: "Info"
    width: parent.width
    backgroundColor: Qaterial.Style.green
    onClicked: () => console.log(`This is a info message`)
  }
  Qaterial.RaisedButton
  {
    text: "Warning"
    width: parent.width
    backgroundColor: Qaterial.Style.orange
    onClicked: () => console.warn(`This is a warning message`)
  }
  Qaterial.RaisedButton
  {
    text: "Error"
    width: parent.width
    backgroundColor: Qaterial.Style.red
    onClicked: () => console.error(`This is a error message`)
  }
  Qaterial.RaisedButton
  {
    text: "Exception"
    width: parent.width
    backgroundColor: Qaterial.Colors.red900
    onClicked: () => console.exception(`This is a exception message`)
  }
}
