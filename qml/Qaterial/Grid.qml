import QtQuick 2.15
import Qaterial 1.0 as Qaterial

Flow
{
  id: root

  property alias type: _layout.type
  property alias columns: _layout.columns
  property alias layout: _layout

  spacing: 16
  leftPadding: flow === Flow.LeftToRight ? 16 : 0
  rightPadding: flow === Flow.LeftToRight ? 16 : 0
  topPadding: flow === Flow.TopToBottom ? 16 : 0
  bottomPadding: flow === Flow.TopToBottom ? 16 : 0

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
