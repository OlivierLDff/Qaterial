/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtGraphicalEffects 1.12

// Qaterial
import Qaterial 1.0 as Qaterial

Rectangle
{
  id: _control

  // TEXT
  property alias text: _text.text
  property alias overlineText: _text.overlineText
  property alias secondaryText: _text.secondaryText

  // THUMBNAIL
  property string roundSource
  property string squareSource
  property string largeSource

  readonly property bool roundSourceSet: roundSource != ""
  readonly property bool squareSourceSet: squareSource != ""
  readonly property bool largeSourceSet: largeSource != ""

  property bool largeThumbnail: false

  // ICON
  property alias roundIcon: _icon.roundIcon
  property alias roundColor: _icon.roundColor
  property alias fillIcon: _icon.fill
  property alias outlinedIcon: _icon.outlined
  property alias highlightedIcon: _icon.highlighted
  property alias reverseHighlightIcon: _icon.reverseHighlight
  property alias iconSource: _icon.source
  property alias iconWidth: _icon.width
  property alias iconHeight: _icon.height
  property alias iconColor: _icon.color

  // ALIGNMENT
  property bool alignTextRight: false
  property bool drawline: false
  property bool enabled: true
  property bool mirrored: false
  property double spacing: 0

  property double padding
  property double leftPadding: padding
  property double rightPadding: padding
  property double topPadding: padding
  property double bottomPadding: padding

  property bool onPrimary: false
  property bool colorReversed: onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary

  readonly property alias lines: _text.lines

  // Qaterial.Style.DelegateType.Default | Qaterial.Style.DelegateType.Overline | Qaterial.Style.DelegateType.Icon
  // Qaterial.Style.DelegateType.Round | Qaterial.Style.DelegateType.Square | Qaterial.Style.DelegateType.Large
  readonly property int type: (icon.source != "") ? (roundIcon ? Qaterial.Style.DelegateType.RoundIcon : Qaterial.Style
      .DelegateType.Icon) : overlineText != "" ? Qaterial.Style.DelegateType.Overline : (roundSourceSet ||
      squareSourceSet) ? (largeThumbnail ? Qaterial.Style.DelegateType.Square : Qaterial.Style.DelegateType.Round) :
    largeSourceSet ? Qaterial.Style.DelegateType.Large : Qaterial.Style.DelegateType.Default

  property alias imageSourceSize: _image.sourceSize

  color: "transparent"
  implicitWidth: _icon.implicitWidth
  implicitHeight: _text.implicitHeight

  function reanchors()
  {
    _icon.reanchors()
    _virtualImage.reanchors()
  } // function reanchors()

  onMirroredChanged: reanchors()
  onTypeChanged: reanchors()
  Component.onCompleted: reanchors()

  Qaterial.RoundColorIcon
  {
    id: _icon
    visible: source != ""
    iconSize: Qaterial.Style.delegate.iconWidth
    highlighted: true
    enabled: _control.enabled

    fill: true
    width: roundIcon ? roundSize : iconSize
    height: roundIcon ? roundSize : iconSize

    anchors.top: _control.top
    anchors.topMargin: Qaterial.Style.delegate.topPadding(_control.type, _control.lines)
    anchors.left: _control.left

    function reanchors()
    {
      anchors.left = undefined
      anchors.right = undefined
      if(mirrored)
        anchors.right = _control.right
      else
        anchors.left = _control.left
    } // function reanchors()

    Qaterial.DebugRectangle
    {
      anchors.fill: parent
      border.color: "orange"
      visible: _control.drawline
    } // DebugRectangle
  } // RoundColorIcon

  Item
  {
    id: _virtualImage
    enabled: _control.enabled
    visible: _control.roundSourceSet || _control.squareSourceSet || _control.largeSourceSet
    width: _control.roundSourceSet ? Qaterial.Style.delegate.roundWidth(_control.largeThumbnail) : _control
      .squareSourceSet ? Qaterial.Style.delegate.squareWidth(_control.largeThumbnail) : _control.largeSourceSet ?
      Qaterial.Style.delegate.largeWidth() : 0
    height: _control.roundSourceSet ? Qaterial.Style.delegate.roundWidth(_control.largeThumbnail) : _control
      .squareSourceSet ? Qaterial.Style.delegate.squareWidth(_control.largeThumbnail) : _control.largeSourceSet ?
      Qaterial.Style.delegate.largeHeight() : 0

    anchors.top: _control.top
    anchors.topMargin: Qaterial.Style.delegate.topPadding(_control.type, _control.lines)
    anchors.left: _control.left

    function reanchors()
    {
      anchors.left = undefined
      anchors.right = undefined
      if(mirrored)
        anchors.right = _control.right
      else
        anchors.left = _control.left
    } //function reanchors()

    Image
    {
      id: _image
      fillMode: Image.PreserveAspectCrop
      width: parent.width
      height: parent.height
      anchors.centerIn: parent
      source: _control.roundSourceSet ? _control.roundSource : _control.squareSourceSet ? _control.squareSource :
        _control.largeSource

      sourceSize.width: width
      sourceSize.height: height

      layer.enabled: _control.roundSourceSet
      layer.effect: OpacityMask
      {
        maskSource: Rectangle
        {
          width: _image.width
          height: _image.height
          radius: _image.width / 2
        } // Rectangle
      } // OpacityMask
    } // Image

    Qaterial.DebugRectangle
    {
      anchors.fill: parent
      border.color: "orange"
      visible: _control.drawline
    } // DebugRectangle
  } // Item

  Qaterial.ListDelegateText
  {
    id: _text
    enabled: _control.enabled
    alignTextRight: _control.alignTextRight
    type: _control.type
    drawline: _control.drawline
    onPrimary: _control.onPrimary
    colorReversed: _control.colorReversed
    anchors.top: _control.top
    anchors.bottom: _control.bottom
    anchors.left: mirrored ? _control.left : (_icon.source != "" ? _icon.right : _image.source != "" ? _virtualImage
      .right : _control.left)
    anchors.right: mirrored ? (_icon.source != "" ? _icon.left : _image.source != "" ? _virtualImage.left : _control
      .right) : _control.right
    anchors.leftMargin: !mirrored ? _control.spacing : _control.leftPadding
    anchors.rightMargin: mirrored ? _control.spacing : _control.rightPadding
    mirrored: _control.mirrored
  } // ListDelegateText

  Qaterial.DebugRectangle
  {
    anchors.fill: parent
    border.color: "red"
    visible: _control.drawline
  } // DebugRectangle
} // Rectangle
