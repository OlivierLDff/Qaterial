import QtQuick
import Qaterial as Qaterial

Qaterial.FlatButton
{
  text: "Read text from file"

  onClicked: function()
  {
    textFile.open('foo.txt', Qaterial.TextFile.Read)
    const readText = textFile.readAll()
    textFile.close()

    console.log(`read text: ${readText}`)
  }

  Qaterial.TextFile
  {
    id: textFile
    onErrorChanged: () => console.warn(`io error : ${error}`)
  }
}
