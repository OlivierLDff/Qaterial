import QtQuick 2.12
import Qt.labs.platform 1.1
import Qaterial 1.0 as Qaterial

Column
{
  FileDialog
  {
    id: openDialog
    folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
    nameFilters: ["Text files (*.txt)"]
    fileMode: FileDialog.OpenFile
    defaultSuffix: "txt"
    onAccepted: function()
    {
      if(!textFile.open(openDialog.file, Qaterial.TextFile.Read))
        Qaterial.SnackbarManager.show({text: `${textFile.error}`})

      _textArea.text = textFile.readAll()

      if(textFile.error)
        Qaterial.SnackbarManager.show({text: `${textFile.error}`})

      textFile.close()
      Qaterial.SnackbarManager.show({text: `Success open file ${textFile.fileName}`})
    }
  }

  FileDialog
  {
    id: saveDialog
    folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
    nameFilters: ["Text files (*.txt)"]
    fileMode: FileDialog.SaveFile
    defaultSuffix: "txt"
    onAccepted: function()
    {
      if(!textFile.open(saveDialog.file, Qaterial.TextFile.Write))
        Qaterial.SnackbarManager.show({text: `${textFile.error}`})

      if(!textFile.write(_textArea.text))
        Qaterial.SnackbarManager.show({text: `${textFile.error}`})

      textFile.close()
      Qaterial.SnackbarManager.show({text: `Success save file ${textFile.fileName}`})
    }
  }

  Qaterial.TextFile
  {
    id: textFile
  }

  TextEdit
  {
    id: _textArea
    width: 400
    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas ac mauris eget odio interdum volutpat. "
    wrapMode: Text.WordWrap
    selectByMouse: true
    padding:  Qaterial.Style.card.horizontalPadding
    selectionColor: Qaterial.Style.accentColor

    color: Qaterial.Style.textTypeToColor(Qaterial.Style.TextType.Body1)
    font.family: Qaterial.Style.textTypeToFontFamily(Qaterial.Style.TextType.Body1)
    font.styleName: Qaterial.Style.textTypeToStyleName(Qaterial.Style.TextType.Body1)
    font.capitalization: Qaterial.Style.fontCapitalization(Qaterial.Style.TextType.Body1)
    font.letterSpacing: Qaterial.Style.textTypeToLetterSpacing(Qaterial.Style.TextType.Body1)
    font.pixelSize: Qaterial.Style.textTypeToPixelSize(Qaterial.Style.TextType.Body1)
  }

  Row
  {
    anchors.right: parent.right

    Qaterial.FlatButton
    {
      text: "Open"
      icon.source: Qaterial.Icons.folderOutline
      onClicked: () => openDialog.open()
    } // Qaterial.FlatButton

    Qaterial.FlatButton
    {
      text: "Save"
      icon.source: Qaterial.Icons.contentSaveOutline
      onClicked: () => saveDialog.open()
    } // Qaterial.FlatButton
  } // Row
} // Column