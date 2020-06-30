import QtQuick 2.12
import Qaterial 1.0 as Qaterial

Row
{
  spacing: 100
  Column
  {
    spacing: 24
    Qaterial.Label
    {
      text: "Mini"
      textType: Qaterial.Style.TextType.Title
      horizontalAlignment: Text.AlignHCenter
    }
    Qaterial.MiniFabButton
    {
      icon.source: Qaterial.Icons.sync
      highlighted: true
      flat: false
    }
    Qaterial.MiniFabButton
    {
      icon.source: Qaterial.Icons.menu
      flat: false
    }
    Qaterial.MiniFabButton
    {
      icon.source: Qaterial.Icons.calendar
      highlighted: true
    }
    Qaterial.MiniFabButton
    {
      icon.source: Qaterial.Icons.clockOutline
    }
  }
  Column
  {
    spacing: 10
    Qaterial.Label
    {
      text: "Default"
      textType: Qaterial.Style.TextType.Title
      horizontalAlignment: Text.AlignHCenter
    }
    Qaterial.FabButton
    {
      icon.source: Qaterial.Icons.sync
    }
    Qaterial.FabButton
    {
      icon.source: Qaterial.Icons.menu
      highlighted: false
    }
    Qaterial.FabButton
    {
      icon.source: Qaterial.Icons.calendar
      flat: true
    }
    Qaterial.FabButton
    {
      icon.source: Qaterial.Icons.clockOutline
      flat: true
      highlighted: false
    }
  }
  Column
  {
    spacing: 10
    Qaterial.Label
    {
      text: "Fab To Extended"
      textType: Qaterial.Style.TextType.Title
      anchors.horizontalCenter: parent.horizontalCenter
    }
    Qaterial.ExtendedFabButton
    {
      anchors.horizontalCenter: parent.horizontalCenter
      icon.source: Qaterial.Icons.sync
      text: "Extended"
      extendedOnHovered: true
    }
    Qaterial.ExtendedFabButton
    {
      anchors.horizontalCenter: parent.horizontalCenter
      icon.source: Qaterial.Icons.menu
      highlighted: false
      text: "Extended"
      extendedOnHovered: true
    }
    Qaterial.ExtendedFabButton
    {
      anchors.horizontalCenter: parent.horizontalCenter
      icon.source: Qaterial.Icons.calendar
      flat: true
      text: "Extended"
      extendedOnHovered: true
    }
    Qaterial.ExtendedFabButton
    {
      anchors.horizontalCenter: parent.horizontalCenter
      icon.source: Qaterial.Icons.clockOutline
      flat: true
      highlighted: false
      text: "Extended"
      extendedOnHovered: true
    }
  }
}
