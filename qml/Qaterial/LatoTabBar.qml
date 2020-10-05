/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Templates 2.12 as T
import QtGraphicalEffects 1.12

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
