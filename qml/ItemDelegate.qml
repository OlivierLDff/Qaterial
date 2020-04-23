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
  id: _control

  // TEXT
  property alias overlineText:    _content.overlineText
  property alias secondaryText:   _content.secondaryText

  // THUMBNAIL
  property alias roundSource:     _content.roundSource
  property alias squareSource:    _content.squareSource
  property alias largeSource:     _content.largeSource
  property alias largeThumbnail:  _content.largeThumbnail

  // ICON
  property alias roundColor: _content.roundColor
  property alias fillIcon: _content.fillIcon
  property alias outlinedIcon: _content.outlinedIcon
  property alias highlightedIcon: _content.highlightedIcon
  property alias reverseHighlightIcon: _content.reverseHighlightIcon
  property alias iconColor: _content.iconColor

  // ALIGNMENT
  property alias alignTextRight : _content.alignTextRight
  readonly property int lines: _content.lines
  readonly property int type:  _content.type

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

  leftPadding: !mirrored ? Qaterial.Style.delegate.leftPadding(_control.type, _control.lines) : Qaterial.Style.delegate.rightPadding(_control.type, _control.lines)
  rightPadding: mirrored ? Qaterial.Style.delegate.leftPadding(_control.type, _control.lines) : Qaterial.Style.delegate.rightPadding(_control.type, _control.lines)
  topPadding: 0
  bottomPadding: 0
  spacing: Qaterial.Style.delegate.spacing(_control.type, _control.lines)
  bottomInset: _separator.visible ? 1 : 0
  focusPolicy: Qt.StrongFocus

  property bool drawline: Qaterial.Style.debug.drawDebugDelegate
  Qaterial.DebugRectangle
  {
    anchors.fill: parent
    border.color: "pink"
    visible: _control.drawline
  } // DebugRectangle

  contentItem: Qaterial.ListDelegateContent
  {
    id: _content
    text: _control.text
    spacing: _control.spacing
    enabled: _control.enabled
    mirrored: _control.mirrored
    drawline: _control.drawline
    onPrimary: _control.onPrimary
    colorReversed: _control.colorReversed
    iconSource: _control.icon.source
  } // ListDelegateContent

  background: Qaterial.ListDelegateBackground
  {
    id: _background
    type: _control.type
    lines: _control.lines
    pressed: _control.pressed
    rippleActive: _control.down || _control.visualFocus || _control.hovered
    rippleAnchor: _control
    onPrimary: _control.onPrimary
    highlighted: _control.highlighted
  } // ListDelegateBackground

  property alias toolSeparatorLeftPadding: _separator.leftPadding
  property alias toolSeparatorRightPadding: _separator.rightPadding

  Qaterial.ToolSeparator
  {
    id: _separator
    anchors.right: _control.right
    anchors.left: _control.left
    anchors.bottom: _control.bottom
    verticalPadding: 0
    orientation: Qt.Horizontal
    visible: _control.forceDrawSeparator ||
        _control.drawSeparator && (_control.ListView.view ? (_control.ListView.view.count > 1 && index < (_control.ListView.view.count-1)) : false)
  } // ToolSeparator
} // ItemDelegate
