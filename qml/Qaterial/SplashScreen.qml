import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Rectangle
{
  id: root

  property real from
  property real to
  property real value
  property bool indeterminate: true

  property real padding
  property url image
  property string text
  property string version

  implicitWidth: 400
  implicitHeight: 200

  color: Qaterial.Style.backgroundColor

  Image
  {
    id: logo
    source: root.image
    width: parent.width - root.padding * 2
    anchors.centerIn: parent
    fillMode: Image.PreserveAspectFit
  }

  Qaterial.Label
  {
    id: stateText

    anchors.bottom: progressBar.top
    anchors.left: parent.left
    anchors.bottomMargin: Qaterial.Style.card.verticalPadding
    anchors.leftMargin: Qaterial.Style.card.horizontalPadding

    text: root.text
    textType: Qaterial.Style.TextType.Caption
  }

  Qaterial.Label
  {
    id: hintText

    anchors.right: parent.right
    anchors.baseline: stateText.baseline
    anchors.rightMargin: Qaterial.Style.card.horizontalPadding

    text: root.version
    textType: Qaterial.Style.TextType.Caption
  }

  Qaterial.ProgressBar
  {
    id: progressBar

    anchors.bottom: parent.bottom
    anchors.right: parent.right
    anchors.left: parent.left

    from: root.from
    to: root.to
    value: root.value
    indeterminate: root.indeterminate
  }
}
