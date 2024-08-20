import QtQuick
import QtQuick.Layouts 1.15

import Qaterial as Qaterial

ColumnLayout
{
  Qaterial.LabelWithCaption
  {
    Layout.preferredWidth: 150

    text: "text"
    caption: "caption"
    maximumLineCount: 1
    wrapMode: Text.WordWrap

    Qaterial.DebugRectangle { anchors.fill: parent }
  }

  Qaterial.CaptionWithLabel
  {
    Layout.preferredWidth: 150

    text: "text"
    caption: "caption"
    maximumLineCount: 1
    wrapMode: Text.WordWrap

    Qaterial.DebugRectangle { anchors.fill: parent }
  }

  Qaterial.OverlineWithLabel
  {
    Layout.preferredWidth: 150

    text: "text"
    caption: "caption"
    maximumLineCount: 1
    wrapMode: Text.WordWrap

    Qaterial.DebugRectangle { anchors.fill: parent }
  }
}
