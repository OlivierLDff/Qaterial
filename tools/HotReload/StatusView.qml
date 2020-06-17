import QtQuick 2.14
import QtQuick.Controls 2.14
import Qaterial 1.0 as Qaterial

Rectangle
{
  id: root

  property string errorString
  property string file
  property bool error: errorString

  implicitWidth: 500
  implicitHeight: 100

  color: "#202225"

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
      text: root.errorString
      readOnly: true
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
      width: parent.width - Qaterial.Style.card.horizontalPadding*2
      anchors.centerIn: parent
      text: root.error ? `Fail to load ${root.file}` : `File ${root.file} Loaded`
      wrapMode: Text.WordWrap
      horizontalAlignment: Text.AlignLeft
      verticalAlignment: Text.AlignVCenter
    } // Qaterial.Label
  }
}