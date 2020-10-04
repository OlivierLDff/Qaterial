import QtQuick 2.15
import Qaterial 1.0 as Qaterial

Flow
{
  id: root

  property alias type: _layout.type
  property alias columns: _layout.columns
  property alias smallBreakpoint: _layout.smallBreakpoint
  property alias mediumBreakpoint: _layout.mediumBreakpoint
  property alias largeBreakpoint: _layout.largeBreakpoint
  property alias extraLargeBreakpoint: _layout.extraLargeBreakpoint
  property alias layout: _layout

  property alias gutter: root.spacing
  property alias leftMargin: root.leftPadding
  property alias rightMargin: root.rightPadding
  property alias topMargin: root.topPadding
  property alias bottomMargin: root.bottomPadding

  spacing: 16

  padding:
  {
    switch(type)
    {
      case Qaterial.Layout.ExtraLarge: return 24
      case Qaterial.Layout.Large: return 24
      case Qaterial.Layout.Medium: return 16
      case Qaterial.Layout.Small: return 16
      case Qaterial.Layout.ExtraSmall: return 8
    }
  }

  function forceUpdate() { _layout.forceUpdate() }

  Qaterial.Layout
  {
    id: _layout

    items: root.children

    width: root.width
    height: root.height

    spacing: root.spacing

    leftPadding: root.leftPadding
    rightPadding: root.rightPadding
    topPadding: root.topPadding
    bottomPadding: root.bottomPadding

    layoutDirection: root.layoutDirection
    flow: root.flow
  }
}
