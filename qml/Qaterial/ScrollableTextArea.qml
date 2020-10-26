/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.TextArea
{
  id: _control
  textArea: _textArea

  contentItem: Qaterial.TextAreaScrollView
  {
    id: _view
    implicitBottomPadding: textAreaBottomPadding
    implicitTopPadding: textAreaTopPadding

    Qaterial.TextAreaContent
    {
      id: _textArea
      onPrimary: _control.onPrimary
      colorReversed: _control.colorReversed
      rightPadding: _view.ScrollBar.vertical.implicitWidth
      topPadding: _control.textAreaTopPadding
      bottomPadding: _control.textAreaBottomPadding

      leftPadding: _control.textAreaLeftPadding

      onEditingFinished: _control.editingFinished()
      onLinkActivated: _control.linkActivated(link)
      onLinkHovered: _control.linkHovered(link)

      forcePlaceholderOff: !_control.titleUp
      textType: _control.textType
      placeholderText: _control.placeholderText
      text: _control.text
      wrapMode: _control.wrapMode
      cursorVisible: _control.cursorVisible
      color: _control.color
      selectionColor: _control.selectionColor
      selectedTextColor: _control.selectedTextColor
      placeholderTextColor: _control.placeholderTextColor
      verticalAlignment: _control.verticalAlignment
      renderType: _control.renderType
    } // TextAreaContent
  } // TextAreaScrollView
} // TextArea
