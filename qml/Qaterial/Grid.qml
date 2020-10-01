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

  spacing: 16

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
