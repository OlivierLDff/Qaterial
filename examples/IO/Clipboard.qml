import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import Qaterial 1.0 as Qaterial

ColumnLayout
{
  TextEdit
  {
    id: _textArea
    Layout.maximumWidth: 400
    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas ac mauris eget odio interdum volutpat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas ac mauris eget odio interdum volutpat."
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
  }

  Row
  {
    Layout.alignment: Qt.AlignRight
    Qaterial.FlatButton
    {
      text: "Copy"
      icon.source: Qaterial.Icons.contentCopy
      onClicked: () => Qaterial.Clipboard.text = _textArea.text
    } // Qaterial.FlatButton

    Qaterial.FlatButton
    {
      text: "Clear"
      icon.source: Qaterial.Icons.contentSaveOutline
      onClicked: () => Qaterial.Clipboard.clear()
    } // Qaterial.FlatButton
  } // Row

  Connections
  {
    target: Qaterial.Clipboard
    function onTextChanged()
    {
      // Don't display twice the same data
      if(_clipboardView.model.count &&
        _clipboardView.model.get(_clipboardView.model.count - 1)
        .text === Qaterial.Clipboard.text)
      {
        return
      }
      _clipboardView.model.append({ text: Qaterial.Clipboard.text, owned: Qaterial.Clipboard.owns })
    }
  }

  Qaterial.ToolSeparator
  {
    Layout.fillWidth: true
    orientation: Qt.Horizontal
  }

  ListView
  {
    id: _clipboardView
    clip: true

    implicitWidth: parent.width
    implicitHeight: 200
    verticalLayoutDirection: ListView.BottomToTop
    currentIndex: count - 1

    Layout.fillWidth: true
    Layout.fillHeight: true
    model: ListModel {}

    delegate: Qaterial.ItemDelegate
    {
      function formatText(str)
      {
        return str.replace(/^\n|\n$/g, '')
      }

      width: _clipboardView.width
      text: formatText(model.text)
      icon.source: Qaterial.Icons.contentCopy
      fillIcon: false
      highlightedIcon: model.owned
      drawSeparator: true

      onClicked: () => Qaterial.Clipboard.text = model.text
    } // ItemDelegate

    ScrollIndicator.vertical: Qaterial.ScrollIndicator {}
  } // ListView
} // Column
