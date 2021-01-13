import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.FlatButton
{
  text: "Write text to file"

  onClicked: function()
  {
    textFile.open('foo.txt', Qaterial.TextFile.Write)
    textFile.write('Some Taaaext')
    textFile.close()
  }

  Qaterial.TextFile
  {
    id: textFile
    onErrorChanged: () => console.warn(`io error : ${error}`)
  }
}
