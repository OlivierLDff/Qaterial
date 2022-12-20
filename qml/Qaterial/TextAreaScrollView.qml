/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls

// Qaterial
import Qaterial as Qaterial

T.ScrollView
{
  id: _view

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    contentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    contentHeight + topPadding + bottomPadding)

  property double implicitTopPadding
  property double implicitBottomPadding

  ScrollBar.vertical: Qaterial.TextAreaScrollBar
  {
    parent: _view
    x: _view.mirrored ? 0 : _view.width - width
    y: _view.topPadding + _view.implicitTopPadding
    height: _view.availableHeight - _view.implicitBottomPadding - _view.implicitTopPadding
    active: _view.ScrollBar.horizontal.active
  } // TextAreaScrollBar

  ScrollBar.horizontal: Qaterial.TextAreaScrollBar
  {
    parent: _view
    x: _view.leftPadding
    y: _view.height - height
    width: _view.availableWidth
    active: _view.ScrollBar.vertical.active
  } // TextAreaScrollBar
} // ScrollView
