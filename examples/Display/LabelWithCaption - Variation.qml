import QtQuick 2.15
import QtQuick.Layouts 1.15

import Qaterial 1.0 as Qaterial

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
