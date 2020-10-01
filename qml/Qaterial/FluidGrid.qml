import QtQuick 2.15
import Qaterial 1.0 as Qaterial

Qaterial.Grid
{
  id: root

  readonly property real preferredPadding:
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

  leftPadding: flow === Flow.LeftToRight ? preferredPadding : 0
  rightPadding: flow === Flow.LeftToRight ? preferredPadding : 0
  topPadding: flow === Flow.TopToBottom ? preferredPadding : 0
  bottomPadding: flow === Flow.TopToBottom ? preferredPadding : 0

  Behavior on leftPadding { NumberAnimation {duration: 100} }
  Behavior on rightPadding { NumberAnimation {duration: 100} }
  Behavior on topPadding { NumberAnimation {duration: 100} }
  Behavior on bottomPadding { NumberAnimation {duration: 100} }
}
