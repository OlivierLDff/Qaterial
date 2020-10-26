/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Rectangle
{
  id: _control

  property alias text: _text.text
  property alias overlineText: _overline.text
  property alias secondaryText: _info.text

  property bool alignTextRight: false
  property bool drawline: false
  property bool enabled: true
  property bool mirrored: false

  property double padding
  property double leftPadding: padding
  property double rightPadding: padding
  property double topPadding: padding
  property double bottomPadding: padding

  property bool onPrimary: false
  property bool colorReversed: onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary

  readonly property int lines: (secondaryText != "" ? _info.lineCount : 0) + 1
  property int elide: mirrored ? Text.ElideLeft : Text.ElideRight
  property int textAligment: mirrored ? alignTextRight ? Text.AlignLeft : Text.AlignRight : alignTextRight ? Text
    .AlignRight : Text.AlignLeft

  Qaterial.DebugRectangle
  {
    anchors.fill: parent
    border.color: "red"
    visible: _control.drawline
  } // DebugRectangle

  // Qaterial.Style.DelegateType.Default | Qaterial.Style.DelegateType.Overline | Qaterial.Style.DelegateType.Icon
  // Qaterial.Style.DelegateType.Round | Qaterial.Style.DelegateType.Square | Qaterial.Style.DelegateType.Large
  property int type: Qaterial.Style.DelegateType.Default

  color: "transparent"
  implicitHeight: _info.visible ? (_info.y + _info.implicitHeight) : (_text.implicitHeight)
  //implicitWidth: 180
  implicitWidth: Math.max(_overline.implicitWidth, _text.implicitWidth, _info.implicitWidth)

  function reanchors()
  {
    _text.reanchors()
  } // function reanchors()

  onMirroredChanged: Qt.callLater(reanchors)
  onTypeChanged: Qt.callLater(reanchors)
  onLinesChanged: Qt.callLater(reanchors)
  Component.onCompleted: reanchors()

  Qaterial.Label
  {
    id: _overline
    visible: text != ""
    enabled: _control.enabled
    textType: Qaterial.Style.TextType.Overline
    elide: _control.elide
    onPrimary: _control.onPrimary
    colorReversed: _control.colorReversed

    horizontalAlignment: _control.textAligment

    anchors.baseline: _control.top
    anchors.baselineOffset: Qaterial.Style.delegate.baselineOffsetOverline(_control.lines)
    anchors.left: _control.left
    anchors.right: _control.right
    anchors.leftMargin: _control.leftPadding
    anchors.rightMargin: _control.rightPadding

    Qaterial.DebugRectangle
    {
      anchors.fill: parent
      border.color: "orange"
      visible: _control.drawline
    } // DebugRectangle
  } // Label

  Qaterial.Label
  {
    id: _text
    visible: text != ""
    enabled: _control.enabled
    textType: Qaterial.Style.TextType.ListText
    elide: _control.elide
    onPrimary: _control.onPrimary
    colorReversed: _control.colorReversed

    horizontalAlignment: _control.textAligment

    readonly property bool centerBaseline: _control.secondaryText != "" || _control.overlineText != ""

    anchors.verticalCenter: _control.verticalCenter
    anchors.baselineOffset: centerBaseline ? Qaterial.Style.delegate.baselineOffsetText(_control.type, _control.lines) :
      0
    anchors.left: _control.left
    anchors.right: _control.right
    anchors.leftMargin: _control.leftPadding
    anchors.rightMargin: _control.rightPadding

    function reanchors()
    {
      anchors.baseline = undefined
      anchors.verticalCenter = undefined

      if(centerBaseline)
        anchors.baseline = _control.top
      else
        anchors.verticalCenter = _control.verticalCenter
    } // function reanchors()

    Qaterial.DebugRectangle
    {
      anchors.fill: parent
      border.color: "orange"
      visible: _control.drawline
    } // DebugRectangle
  } // Label

  Qaterial.Label
  {
    id: _info
    visible: text != ""
    enabled: _control.enabled
    textType: Qaterial.Style.TextType.ListSecText
    elide: _control.elide
    maximumLineCount: 2
    onPrimary: _control.onPrimary
    colorReversed: _control.colorReversed

    wrapMode: Text.WordWrap
    horizontalAlignment: _control.textAligment

    anchors.baseline: _control.top
    anchors.baselineOffset: Qaterial.Style.delegate.baselineOffsetSecText(_control.type, lineCount + 1)

    anchors.left: _control.left
    anchors.right: _control.right
    anchors.leftMargin: _control.leftPadding
    anchors.rightMargin: _control.rightPadding

    Qaterial.DebugRectangle
    {
      anchors.fill: parent
      border.color: "orange"
      visible: _control.drawline
    } // DebugRectangle
  } // Label

  Qaterial.DebugRectangle
  {
    anchors.fill: parent
    border.color: "red"
    visible: _control.drawline
  } // DebugRectangle
} // Rectangle
