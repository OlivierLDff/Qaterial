import QtQuick 2.12
import QtQuick.Controls 2.12
import Qaterial 1.0 as Qaterial

Rectangle
{
  id: root

  property string logString
  property string errorString
  property string file
  property bool error: errorString

  implicitWidth: 500
  implicitHeight: 100

  color: Qaterial.Style.theme === Qaterial.Style.Theme.Dark ? "#24262A" : "white"

  function append(text)
  {
    _errorTextArea.append(text)
  }

  Flickable
  {
    id: _flick
    width: parent.width
    height: root.height - _errorRect.height

    contentWidth: width
    contentHeight: _errorTextArea.height

    clip: true

    ScrollBar.vertical: Qaterial.ScrollBar {}
    ScrollBar.horizontal: Qaterial.ScrollBar {}

    TextEdit
    {
      id: _errorTextArea
      width: parent.width
      text: root.logString
      textFormat: TextEdit.RichText
      readOnly: true
      wrapMode: Text.WordWrap
      selectByMouse: true
      padding: Qaterial.Style.card.horizontalPadding
      selectionColor: Qaterial.Style.accentColor

      color: Qaterial.Style.textTypeToColor(Qaterial.Style.TextType.Body1)
      font.family: Qaterial.Style.textTypeToFontFamily(Qaterial.Style.TextType.Body1)
      font.styleName: Qaterial.Style.textTypeToStyleName(Qaterial.Style.TextType.Body1)
      font.capitalization: Qaterial.Style.fontCapitalization(Qaterial.Style.TextType.Body1)
      font.letterSpacing: Qaterial.Style.textTypeToLetterSpacing(Qaterial.Style.TextType.Body1)
      font.pixelSize: Qaterial.Style.textTypeToPixelSize(Qaterial.Style.TextType.Body1)

      onTextChanged: function()
      {
        cursorPosition = text.length - 1
        if(height > _flick.height)
          _flick.contentY = height - _flick.height
      }
    }
  }

  Rectangle
  {
    id: _errorRect

    y: root.height - height
    width: parent.width
    height: 32

    color: root.error ? "#f44336" : "#4CAF50"

    Qaterial.Label
    {
      anchors.verticalCenter: parent.verticalCenter
      anchors.left: parent.left
      anchors.leftMargin: Qaterial.Style.card.horizontalPadding
      anchors.right: _version.left
      anchors.rightMargin: Qaterial.Style.card.horizontalPadding

      width: 200

      text: root.error ? `Fail to load ${root.file}` : `File ${root.file} Loaded`
      elide: Text.ElideRight

      horizontalAlignment: Text.AlignLeft
      verticalAlignment: Text.AlignVCenter
    } // Qaterial.Label

    Qaterial.Label
    {
      id: _version
      anchors.verticalCenter: parent.verticalCenter
      anchors.right: parent.right
      anchors.rightMargin: Qaterial.Style.card.horizontalPadding
      text: Qaterial.Version.readable
      textType: Qaterial.Style.TextType.Caption
    }
  }
}
