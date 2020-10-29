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
  id: _control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    contentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    contentHeight + topPadding + bottomPadding)

  spacing: 1

  property color backgroundColor: onPrimary ? Qaterial.Style.primaryColor : Qaterial.Style.backgroundColor
  property color accentColor: !enabled ? (colorReversed ? Qaterial.Style.disabledTextColorReversed() : Qaterial.Style
      .disabledTextColor()) : highlighted ? Qaterial.Style.accentColor : colorReversed ? Qaterial.Style
    .primaryTextColorReversed() : Qaterial.Style.primaryTextColor()

  property bool highlighted: onPrimary ? Qaterial.Style.preferAccentOnPrimary : true

  property bool onPrimary: false
  property bool colorReversed: onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary

  property double elevation: position === TabBar.Footer ? Qaterial.Style.tabBar.elevation : 0

  contentItem: ListView
  {
    model: _control.contentModel
    currentIndex: _control.currentIndex

    spacing: _control.spacing
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

    highlight: Item
    {
      z: 2
      Rectangle
      {
        height: Qaterial.Style.tabBar.highlightHeight
        width: parent.width
        y: _control.position === TabBar.Footer ? 0 : parent.height - height
        color: _control.accentColor
        visible: _control.enabled
      } // Rectangle
    } // Item
  } // ListView

  background: Rectangle
  {
    color: _control.backgroundColor

    layer.enabled: _control.elevation > 0
    layer.effect: Qaterial.ElevationEffect
    {
      elevation: _control.elevation
      fullWidth: true
    } // ElevationEffect
  } // Rectangle
} // TabBar
