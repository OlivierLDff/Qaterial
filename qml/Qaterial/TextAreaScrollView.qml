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
