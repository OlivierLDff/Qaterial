// MIT License
//
// Copyright (c) 2020 Olivier Le Doeuff
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQml 2.15
import Qaterial 1.0 as Qaterial

QQC2.Control
{
  id: root

  enum Display
  {
    IconOnly,
    TextOnly,
    TextBesideIcon,
    TextUnderIcon
  }

  property int display: IconLabel.Display.TextBesideIcon
  spacing: 8
  property color color: root.enabled ? Qaterial.Style.primaryTextColor() : Qaterial.Style.disabledTextColor()

  property int horizontalAlignment: Qt.AlignHCenter
  property int verticalAlignment: Qt.AlignVCenter

  property string text
  property int textType: Qaterial.Style.TextType.Body1
  property int elide: Text.ElideRight

  property Qaterial.IconDescription icon: Qaterial.IconDescription
  {
    color: root.color
  }

  // Component to be instanciated as render for icon
  property Component iconItem: Qaterial.Icon
  {
    icon: root.icon.source
    implicitWidth: icon.toString() ? root.icon.width : 0
    implicitHeight: icon.toString() ? root.icon.height : 0
    color: root.icon.color
    cached: root.icon.cache
  }

  property Component labelItem: Qaterial.Label
  {
    text: root.text
    textType: root.textType
    color: root.color
    elide: root.elide
  }

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + leftInset + rightInset,
    implicitContentHeight + leftPadding + rightPadding)

  contentItem: Item
  {
    id: _contentItem

    Qaterial.IconLabelPositionner
    {
      id: _positionner

      display: root.display
      spacing: root.spacing
      mirrored: root.mirrored

      horizontalAlignment: root.horizontalAlignment
      verticalAlignment: root.verticalAlignment

      Binding on iconImplicitSize
      {
        when: iconLoader.item && root.icon.source.toString()
        value: iconLoader.item ? Qt.size(iconLoader.item.width, iconLoader.item.height) : undefined
        restoreMode: Binding.RestoreBindingOrValue
      }

      Binding on labelImplicitSize
      {
        when: labelLoader.item
        value: labelLoader.item ? Qt.size(labelLoader.item.implicitWidth, labelLoader.item.implicitHeight) : undefined
        restoreMode: Binding.RestoreBindingOrValue
      }

      containerSize: Qt.size(_contentItem.width, _contentItem.height)
    }

    implicitWidth: _positionner.implicitSize.width
    implicitHeight: _positionner.implicitSize.height

    //Qaterial.DebugRectangle
    //{
    //  anchors.fill: parent
    //  border.color: Qaterial.Colors.blue
    //}

    Loader
    {
      id: labelLoader

      active: root.display !== IconLabel.Display.IconOnly
      sourceComponent: root.labelItem

      x: _positionner.labelRect.x
      y: _positionner.labelRect.y

      // ALl the trick is here !
      // We need to force the Label to evaluate its implicitWidth
      width: _positionner.labelRect.width || undefined

      //Qaterial.DebugRectangle
      //{
      //  anchors.fill: parent
      //  border.color: Qaterial.Colors.blue
      //}
    }

    Loader
    {
      id: iconLoader

      active: root.display !== IconLabel.Display.TextOnly
      sourceComponent: root.iconItem

      x: _positionner.iconRect.x
      y: _positionner.iconRect.y
      width: root.icon.width
      height: root.icon.height

      //Qaterial.DebugRectangle
      //{
      //  anchors.fill: parent
      //  border.color: Qaterial.Colors.orange
      //}
    }
  }
}
