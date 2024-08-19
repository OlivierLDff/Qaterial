/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick
import QtQuick.Templates as T

// Qaterial
import Qaterial as Qaterial

T.SwipeView
{
  id: _control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    contentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    contentHeight + topPadding + bottomPadding)

  contentItem: ListView
  {
    model: _control.contentModel
    interactive: _control.interactive
    currentIndex: _control.currentIndex

    spacing: _control.spacing
    orientation: _control.orientation
    snapMode: ListView.SnapOneItem
    boundsBehavior: Flickable.StopAtBounds

    highlightRangeMode: ListView.StrictlyEnforceRange
    preferredHighlightBegin: 0
    preferredHighlightEnd: 0
    highlightMoveDuration: 250
    maximumFlickVelocity: 4 * (_control.orientation === Qt.Horizontal ? width : height)
  } // ListView
} // SwipeView
