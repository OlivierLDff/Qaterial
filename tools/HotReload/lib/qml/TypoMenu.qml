import QtQuick 2.12
import QtQuick.Controls 2.12
import Qt.labs.folderlistmodel 2.14
import Qaterial 1.0 as Qaterial

Qaterial.Menu
{
  id: root

  width: 250

  Repeater
  {
    model: ListModel {}

    delegate: Qaterial.ItemDelegate
    {
      height: Qaterial.Style.textTypeToPixelSize(model.textType) + 8
      contentItem: Qaterial.Label
      {
        text: model.text
        textType: model.textType
        verticalAlignment: Text.AlignVCenter

      }

      Qaterial.ToolTip
      {
        visible: parent.hovered
        text: `TextType.${model.text}`
        delay: 300
      }

      onClicked: function()
      {
        const textToCopy = `Qaterial.Style.TextType.${model.text}`
        Qaterial.Clipboard.text = textToCopy
        Qaterial.SnackbarManager.show(`Text Type Copied! \n'${textToCopy}'`)
        root.close()
      }
    }

    Component.onCompleted: function()
    {

      model.append({ textType: Qaterial.Style.TextType.Display3, text: "Display3" })
      model.append({ textType: Qaterial.Style.TextType.Display2, text: "Display2" })
      model.append({ textType: Qaterial.Style.TextType.Display1, text: "Display1" })
      model.append({ textType: Qaterial.Style.TextType.Heading, text: "Heading" })
      model.append({ textType: Qaterial.Style.TextType.Title, text: "Title" })
      model.append({ textType: Qaterial.Style.TextType.Subheading, text: "Subheading" })
      model.append({ textType: Qaterial.Style.TextType.ListText, text: "ListText" })
      model.append({ textType: Qaterial.Style.TextType.ListSecText, text: "ListSecText" })
      model.append({ textType: Qaterial.Style.TextType.Overline, text: "Overline" })
      model.append({ textType: Qaterial.Style.TextType.Body2, text: "Body2" })
      model.append({ textType: Qaterial.Style.TextType.Body1, text: "Body1" })
      model.append({ textType: Qaterial.Style.TextType.Caption, text: "Caption" })
      model.append({ textType: Qaterial.Style.TextType.Hint, text: "Hint" })
      model.append({ textType: Qaterial.Style.TextType.Button, text: "Button" })
      model.append({ textType: Qaterial.Style.TextType.Menu, text: "Menu" })
      model.append({ textType: Qaterial.Style.TextType.MenuHint, text: "MenuHint" })
    }
  }
}
