import QtQuick 2.15
import Qaterial 1.0 as Qaterial

Qaterial.Grid
{
  id: root

  leftPadding: flow === Flow.LeftToRight ? padding : 0
  rightPadding: flow === Flow.LeftToRight ? padding : 0
  topPadding: flow === Flow.TopToBottom ? padding : 0
  bottomPadding: flow === Flow.TopToBottom ? padding : 0

  Behavior on spacing { NumberAnimation {duration: 100} }
  Behavior on leftPadding { NumberAnimation {duration: 100} }
  Behavior on rightPadding { NumberAnimation {duration: 100} }
  Behavior on topPadding { NumberAnimation {duration: 100} }
  Behavior on bottomPadding { NumberAnimation {duration: 100} }
}
