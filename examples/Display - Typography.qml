import QtQuick 2.12
import QtQuick.Layouts 1.12
import Qaterial 1.0 as Qaterial

Item
{
  id: root
  width: _column.width
  height: _column.height

  ListModel
  {
    id: _typoModel

    Component.onCompleted:
    {
      append({type: "Display 3", textType: Qaterial.Style.TextType.Display3});
      append({type: "Display 2", textType: Qaterial.Style.TextType.Display2});
      append({type: "Display 1", textType: Qaterial.Style.TextType.Display1});
      append({type: "Heading", textType: Qaterial.Style.TextType.Heading});
      append({type: "Title", textType: Qaterial.Style.TextType.Title});
      append({type: "Subheading", textType: Qaterial.Style.TextType.Subheading});
      append({type: "List Text", textType: Qaterial.Style.TextType.ListText});
      append({type: "List Sec Text", textType: Qaterial.Style.TextType.ListSecText});
      append({type: "Overline", textType: Qaterial.Style.TextType.Overline});
      append({type: "Body 2", textType: Qaterial.Style.TextType.Body2});
      append({type: "Body 1", textType: Qaterial.Style.TextType.Body1});
      append({type: "Caption", textType: Qaterial.Style.TextType.Caption});
      append({type: "Hint", textType: Qaterial.Style.TextType.Hint});
      append({type: "Button", textType: Qaterial.Style.TextType.Button});
      append({type: "Menu", textType: Qaterial.Style.TextType.Menu});
    } // Component
  } // ListModel

  ColumnLayout
  {
    id: _column
    spacing: 20

    Repeater
    {
      model: _typoModel

      delegate: RowLayout
      {
        Qaterial.Label
        {
          Layout.preferredWidth: 65
          text: model.type
          textType: Qaterial.Style.TextType.Caption
          usePixelSize: false
        } // Label

        Qaterial.Label
        {
          text: `${font.styleName} ${font.pixelSize}sp`
          textType: model.textType
        } // Label
      } // RowLayout
    } // Repeater
  } // ColumnLayout
}