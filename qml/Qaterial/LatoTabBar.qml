/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick
import QtQuick.Controls
import QtQuick.Templates as T
import QtGraphicalEffects

// Qaterial
import Qaterial 1.0 as Qaterial

T.TabBar
{
  id: control

  implicitWidth: contentWidth + leftPadding + rightPadding
  implicitHeight: contentHeight + topPadding + bottomPadding

  contentItem: ListView
  {
    model: control.contentModel
    currentIndex: control.currentIndex

    spacing: control.spacing
    orientation: ListView.Horizontal
    boundsBehavior: Flickable.StopAtBounds
    flickableDirection: Flickable.AutoFlickIfNeeded
    snapMode: ListView.SnapToItem

    highlightMoveDuration: 250
    highlightResizeDuration: 0
    highlightFollowsCurrentItem: true
    highlightRangeMode: ListView.ApplyRange
    preferredHighlightBegin: 48
    preferredHighlightEnd: width - 48
  } // ListView
} // TabBar
