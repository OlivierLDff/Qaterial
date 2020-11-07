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

T.TextArea
{
  id: _control

  property int textType: Qaterial.Style.TextType.ListText
  property int placeholderTextType: textType
  property bool onPrimary: false
  property bool colorReversed: onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary

  font.family: Qaterial.Style.textTypeToFontFamily(textType)
  font.styleName: Qaterial.Style.textTypeToStyleName(textType)
  font.pixelSize: Qaterial.Style.textTypeToPixelSize(textType)
  font.capitalization: Qaterial.Style.fontCapitalization(textType)
  font.letterSpacing: Qaterial.Style.textTypeToLetterSpacing(textType)

  // DEBUG
  property bool drawline: Qaterial.Style.debug.drawDebugButton

  Qaterial.DebugRectangle
  {
    anchors.fill: parent
    border.color: "pink"
    visible: _control.drawline
  } // DebugRectangle

  Qaterial.DebugRectangle
  {
    x: _control.leftPadding
    y: _control.topPadding
    width: _control.width - _control.leftPadding - _control.rightPadding
    height: _control.contentHeight
    border.color: "orange"
    visible: _control.drawline
  } // DebugRectangle

  Qaterial.DebugRectangle
  {
    x: _control.leftPadding
    y: _control.topPadding
    width: Math.min(_control.contentWidth, _control.width - _control.leftPadding - _control.rightPadding)
    height: _control.contentHeight
    border.color: "red"
    visible: _control.drawline
  } // DebugRectangle

  // SIZE
  implicitWidth: Math.max(contentWidth + leftPadding + rightPadding,
    implicitBackgroundWidth + leftInset + rightInset,
    placeholder.implicitWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(contentHeight + topPadding + bottomPadding,
    implicitBackgroundHeight + topInset + bottomInset,
    placeholder.implicitHeight + topPadding + bottomPadding)

  bottomPadding: 0

  // COLORS
  property alias textColor: _control.color
  color: enabled ? Qaterial.Style.primaryTextColor() : Qaterial.Style.hintTextColor()
  selectionColor: Qaterial.Style.accentColor
  placeholderTextColor: Qaterial.Style.hintTextColor()
  verticalAlignment: TextInput.AlignTop

  // BEHAVIOR
  selectByMouse: true
  wrapMode: TextEdit.Wrap

  // CURSOR
  cursorDelegate: Qaterial.CursorDelegate {}

  // PLACEHOLDER
  property bool forcePlaceholderOff: false
  Qaterial.PlaceholderText
  {
    id: placeholder
    x: _control.leftPadding
    y: _control.topPadding
    width: _control.width - (_control.leftPadding + _control.rightPadding)
    height: _control.height - (_control.topPadding + _control.bottomPadding)
    text: _control.placeholderText
    color: _control.placeholderTextColor
    textType: _control.placeholderTextType
    verticalAlignment: _control.verticalAlignment
    elide: Text.ElideRight
    wrapMode: _control.wrapMode
    renderType: _control.renderType
    readonly property bool shouldBeVisible: (!forcePlaceholderOff || _control.activeFocus) && !_control.length && !
      _control.preeditText && (!_control.activeFocus || _control.horizontalAlignment !== Qt.AlignHCenter)
    opacity: shouldBeVisible ? 1.0 : 0.0

    Behavior on opacity
    {
      NumberAnimation
      {
        easing.type: Easing.InQuad;
        duration: placeholder.shouldBeVisible ? 50 : 200
      } // NumberAnimation
    } // Behavior
  } // PlaceholderText

  background: Rectangle
  {
    id: _back
    implicitWidth: Qaterial.Style.textField.implicitWidth
    color: "transparent"
  } // Rectangle
} // TextArea
