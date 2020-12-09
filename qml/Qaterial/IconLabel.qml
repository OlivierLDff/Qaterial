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
import QtQml 2.15
import Qaterial 1.0 as Qaterial

Item
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
  property real spacing: 8
  property color color: root.enabled ? Qaterial.Style.primaryTextColor() : Qaterial.Style.disabledTextColor()

  property int horizontalAlignment: Qt.AlignHCenter
  property int verticalAlignment: Qt.AlignVCenter

  property string text
  property int textType: Qaterial.Style.TextType.Body1
  property int elide: Text.ElideRight
  property int wrapMode: Text.NoWrap
  property int maximumLineCount: Number.MAX_SAFE_INTEGER
  property bool mirrored: false

  property Qaterial.IconDescription icon: Qaterial.IconDescription
  {
    color: root.color
  }

  // Component to be instanciated as render for icon
  property Item iconItem: Qaterial.Icon
  {
    icon: root.icon.source
    implicitWidth: icon.toString() ? root.icon.width : 0
    implicitHeight: icon.toString() ? root.icon.height : 0
    color: root.icon.color
    cached: root.icon.cache
  }

  property Item labelItem: Qaterial.Label
  {
    text: root.text
    textType: root.textType
    color: root.color
    elide: root.elide
    wrapMode: root.wrapMode
    maximumLineCount: root.maximumLineCount
  }

  implicitWidth: _positionner.implicitSize.width
  implicitHeight: _positionner.implicitSize.height

  Qaterial.IconLabelPositionner
  {
    id: _positionner

    display: root.display
    spacing: root.spacing
    mirrored: root.mirrored

    horizontalAlignment: root.horizontalAlignment
    verticalAlignment: root.verticalAlignment

    iconImplicitSize: root.icon.source.toString() && root.display !== IconLabel.Display.TextOnly ? Qt.size(root.icon.width, root.icon.height) : undefined
    labelImplicitSize: root.display !== IconLabel.Display.IconOnly ? Qt.size(root.labelItem.implicitWidth, root.labelItem.implicitHeight) : undefined

    Binding on containerSize
    {
      value: Qt.size(root.width, root.height)
      delayed: true
    }
  }

  // Qaterial.DebugRectangle
  // {
  //   id: rect
  //   anchors.fill: parent
  //   border.color: Qaterial.Colors.red
  // }

  children: [iconItem, labelItem]

  Binding
  {
    target: root.labelItem
    property: "visible"
    value: root.display !== IconLabel.Display.IconOnly
  }

  Binding
  {
    target: root.labelItem
    property: "x"
    value: _positionner.labelRect.x
  }

  Binding
  {
    target: root.labelItem
    property: "y"
    value: _positionner.labelRect.y
  }

  Binding
  {
    target: root.labelItem
    property: "width"
    value: _positionner.labelRect.width
  }

  Binding
  {
    target: root.iconItem
    property: "visible"
    value: root.display !== IconLabel.Display.TextOnly
  }

  Binding
  {
    target: root.iconItem
    property: "x"
    value: _positionner.iconRect.x
  }

  Binding
  {
    target: root.iconItem
    property: "y"
    value: _positionner.iconRect.y
  }

  Binding
  {
    target: root.iconItem
    property: "width"
    value: root.icon.width
  }

  Binding
  {
    target: root.iconItem
    property: "height"
    value: root.icon.height
  }
}
