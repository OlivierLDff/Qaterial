import QtQuick 2.15
import Qaterial 1.0 as Qaterial

Qaterial.Grid
{
  id: root

  readonly property real idealSize:
  {
    switch (type)
    {
      case Qaterial.Layout.ExtraLarge:
        return extraLargeBreakpoint
      case Qaterial.Layout.Large:
        return largeBreakpoint
      case Qaterial.Layout.Medium:
        return mediumBreakpoint
      case Qaterial.Layout.Small:
        return smallBreakpoint
      case Qaterial.Layout.ExtraSmall:
        return smallBreakpoint
    }
  }

  readonly property real idealSizePaddingLess: idealSize - padding * 2

  readonly property real fixedPadding: Math.floor(((flow === Flow.LeftToRight ? width : height) -
    idealSizePaddingLess) / 2)

  leftPadding: flow === Flow.LeftToRight ? fixedPadding : 0
  rightPadding: flow === Flow.LeftToRight ? fixedPadding : 0
  topPadding: flow === Flow.TopToBottom ? fixedPadding : 0
  bottomPadding: flow === Flow.TopToBottom ? fixedPadding : 0
}
