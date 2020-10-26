/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

T.ItemDelegate
{
  id: control

  // TEXT
  property alias overlineText: _content.overlineText
  property alias secondaryText: _content.secondaryText

  // THUMBNAIL
  property alias roundSource: _content.roundSource
  property alias squareSource: _content.squareSource
  property alias largeSource: _content.largeSource
  property alias largeThumbnail: _content.largeThumbnail

  // ICON
  property alias roundColor: _content.roundColor
  property alias fillIcon: _content.fillIcon
  property alias outlinedIcon: _content.outlinedIcon
  property alias highlightedIcon: _content.highlightedIcon
  property alias reverseHighlightIcon: _content.reverseHighlightIcon
  property alias iconColor: _content.iconColor

  // ALIGNMENT
  property alias alignTextRight: _content.alignTextRight
  readonly property int lines: _content.lines
  readonly property int type: _content.type

  // COLOR
  property alias backgroundColor: _background.color
  property bool onPrimary: false
  property bool colorReversed: onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary

  // SEPARATOR
  property bool drawSeparator: forceDrawSeparator
  property bool forceDrawSeparator: false

  implicitWidth: Math.max(background ? implicitBackgroundWidth : 0,
    implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(background ? implicitBackgroundHeight : 0,
    Math.max(implicitContentHeight,
      indicator ? indicator.implicitHeight : 0) + topPadding + bottomPadding) + bottomInset

  leftPadding: !mirrored ? Qaterial.Style.delegate.leftPadding(control.type, control.lines) : Qaterial.Style.delegate
    .rightPadding(control.type, control.lines)
  rightPadding: mirrored ? Qaterial.Style.delegate.leftPadding(control.type, control.lines) : Qaterial.Style.delegate
    .rightPadding(control.type, control.lines)
  topPadding: 0
  bottomPadding: 0
  spacing: Qaterial.Style.delegate.spacing(control.type, control.lines)
  bottomInset: _separator.visible ? 1 : 0
  focusPolicy: Qt.StrongFocus

  property bool drawline: Qaterial.Style.debug.drawDebugDelegate
  Qaterial.DebugRectangle
  {
    anchors.fill: parent
    border.color: "pink"
    visible: control.drawline
  } // DebugRectangle

  contentItem: Qaterial.ListDelegateContent
  {
    id: _content
    text: control.text
    spacing: control.spacing
    enabled: control.enabled
    mirrored: control.mirrored
    drawline: control.drawline
    onPrimary: control.onPrimary
    colorReversed: control.colorReversed
    iconSource: control.icon.source
  } // ListDelegateContent

  background: Qaterial.ListDelegateBackground
  {
    id: _background
    type: control.type
    lines: control.lines
    pressed: control.pressed
    rippleActive: control.down || control.visualFocus || control.hovered
    rippleAnchor: control
    onPrimary: control.onPrimary
    highlighted: control.highlighted
  } // ListDelegateBackground

  property alias toolSeparatorLeftPadding: _separator.leftPadding
  property alias toolSeparatorRightPadding: _separator.rightPadding

  Qaterial.ToolSeparator
  {
    id: _separator
    anchors.right: control.right
    anchors.left: control.left
    anchors.bottom: control.bottom
    verticalPadding: 0
    orientation: Qt.Horizontal
    visible:
    {
      if(control.forceDrawSeparator)
        return true

      if(control.drawSeparator)
      {
        if(control.ListView.view.verticalLayoutDirection === ListView.TopToBottom)
        {
          // No separator for last element (top of the list)
          return control.ListView.view.count > 1 &&
            index < (control.ListView.view.count - 1)
        }
        else
        {
          // No separator for first element (bottom of the list)
          return control.ListView.view.count > 1 && index
        }
      }
      return false
    }
  } // ToolSeparator
} // ItemDelegate
