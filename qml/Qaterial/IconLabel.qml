/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Item
{
  id: _control
  property
  var icon: QtObject
  {
    property double width: 24
    property double height: width
    property string source: ""
    property color color: _control.color
  }
  property alias text: _label.text
  property color color
  property alias font: _label.font
  property alias textType: _label.textType
  property bool mirrored: false
  property double spacing: 0
  property int elide: Text.ElideNone
  property alias alignment: _label.horizontalAlignment
  property bool alwaysRenderIcon: false

  readonly property double iconWidth: (_icon.visible ? icon.width : 0)
  readonly property double iconHeight: (_icon.visible ? icon.height : 0)

  readonly property double labelWidth: (_label.visible ? _label.contentWidth : 0)
  readonly property double labelHeight: (_label.visible ? _label.contentHeight : 0)

  implicitWidth: iconOnTop ? Math.max(iconWidth, labelWidth) : iconWidth + labelWidth + spacing
  implicitHeight: iconOnTop ? iconHeight + labelHeight : Math.max(iconHeight, labelHeight)

  property bool drawline: Qaterial.Style.debug.drawDebugIconLabel

  // AbstractButton.IconOnly | AbstractButton.TextOnly | AbstractButton.TextBesideIcon | AbstractButton.TextUnderIcon
  property int display: AbstractButton.TextBesideIcon

  readonly property bool iconOnTop: display === AbstractButton.TextUnderIcon && _icon.visible

  Qaterial.DebugRectangle
  {
    anchors.fill: parent
    border.color: "green"
    visible: _control.drawline
  } // DebugRectangle

  Item
  {
    id: _iconItem
    width: _control.icon.width
    height: _control.icon.height
    visible: (_control.display != AbstractButton.TextOnly) && ((_icon.source != "") || alwaysRenderIcon)

    Qaterial.ColorIcon
    {
      id: _icon
      source: _control.icon.source
      width: _control.icon.width
      height: _control.icon.height
      iconSize: Math.max(width, height)
      color: _control.icon.color

      anchors.centerIn: parent
    } // ColorIcon

    Qaterial.DebugRectangle
    {
      anchors.fill: parent
      border.color: "orange"
      visible: _control.drawline
    } // DebugRectangle

    //readonly property bool textOnLeft: !_control.iconOnTop && _control.mirrored && _label.visible
    //readonly property bool textOnRight: !_control.iconOnTop && !_control.mirrored && _label.visible

    function reanchors()
    {
      anchors.left = undefined
      anchors.right = undefined

      var textOnLeft = !_control.iconOnTop && _control.mirrored && ((_control.display != AbstractButton.IconOnly) &&
        _label.text != "")
      var textOnRight = !_control.iconOnTop && !_control.mirrored && ((_control.display != AbstractButton.IconOnly) &&
        _label.text != "")

      if((!textOnLeft && !_control.iconOnTop) || _control.iconOnTop)
        anchors.left = _control.left

      if((!textOnRight && !_control.iconOnTop) || _control.iconOnTop)
        anchors.right = _control.right

      anchors.verticalCenter = undefined
      anchors.top = undefined
      if(_control.iconOnTop)
        anchors.top = _control.top
      else
        anchors.verticalCenter = _control.verticalCenter
    } // function reanchors()
    //Component.onCompleted: reanchors()
  } // Item

  Qaterial.Label
  {
    id: _label
    color: _control.color
    visible: (_control.display != AbstractButton.IconOnly) && (text != "")
    elide: _control.elide
    horizontalAlignment: Text.AlignHCenter

    readonly property bool iconOnLeft: !_control.iconOnTop && !_control.mirrored && _icon.visible
    readonly property bool iconOnRight: !_control.iconOnTop && _control.mirrored && _icon.visible

    anchors.left: iconOnLeft ? _iconItem.right : _control.left
    anchors.right: iconOnRight ? _iconItem.left : _control.right

    anchors.leftMargin: iconOnLeft ? _control.spacing : _control.anchors.leftMargin
    anchors.rightMargin: iconOnRight ? _control.spacing : _control.anchors.rightMargin
    anchors.baselineOffset: _control.iconOnTop ? _control.spacing : 0

    function reanchors()
    {
      anchors.verticalCenter = undefined
      anchors.baseline = undefined
      if(_control.iconOnTop)
      {
        anchors.baseline = _control.verticalCenter
      }
      else
        anchors.verticalCenter = _control.verticalCenter
    } // function reanchors()

    Qaterial.DebugRectangle
    {
      anchors.fill: parent
      border.color: "red"
      visible: _control.drawline
    } // DebugRectangle
  } // Label

  function reanchors()
  {
    _label.reanchors()
    _iconItem.reanchors()
  } // function reanchors()

  Component.onCompleted: reanchors()
  onIconOnTopChanged: reanchors()
  onTextChanged: reanchors()
} // Item
