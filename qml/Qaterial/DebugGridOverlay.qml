import QtQuick 2.15
import Qaterial 1.0 as Qaterial

Loader
{
  id: root

  property real leftPadding
  property real rightPadding
  property real topPadding
  property real bottomPadding
  property real spacing
  property int columns
  property int flow

  sourceComponent: flow === Flow.LeftToRight ? verticalComponent : horizontalComponent
  opacity: 0.1

  Component
  {
    id: verticalComponent
    Qaterial.DebugGridOverlayVertical
    {
      leftPadding: root.leftPadding
      rightPadding: root.rightPadding
      spacing: root.spacing
      columns: root.columns
    }
  }

  Component
  {
    id: horizontalComponent
    Qaterial.DebugGridOverlayHorizontal
    {
      topPadding: root.topPadding
      bottomPadding: root.bottomPadding
      spacing: root.spacing
      columns: root.columns
    }
  }
}
