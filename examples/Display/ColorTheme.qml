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

import QtQuick 2.0
import QtQuick.Controls 2.0

import Qaterial 1.0 as Qaterial

Column
{
  width: 300
  spacing: 16

  Qaterial.ToolBar
  {
    anchors
    {
      left: parent.left
      right: parent.right
    }

    Qaterial.LabelHeadline6
    {
      anchors.fill: parent
      verticalAlignment: Text.AlignVCenter
      leftPadding: 16
      text: "Default App Bar"
    }
  }

  Qaterial.ToolBar
  {
    anchors
    {
      left: parent.left
      right: parent.right
    }

    Qaterial.LabelHeadline6
    {
      anchors.fill: parent
      verticalAlignment: Text.AlignVCenter
      leftPadding: 16
      text: "Primary App Bar"
    }
  }

  Qaterial.ToolBar
  {
    anchors
    {
      left: parent.left
      right: parent.right
    }

    Qaterial.LabelHeadline6
    {
      anchors.fill: parent
      verticalAlignment: Text.AlignVCenter
      leftPadding: 16
      text: "Accent App Bar"
    }
  }

  Row
  {
    spacing: 8

    Qaterial.FlatButton
    {
      text: "Default"
    }
    Qaterial.FlatButton
    {
      text: "Primary"
    }
    Qaterial.FlatButton
    {
      text: "Accent"
    }
    Qaterial.FlatButton
    {
      text: "Disabled"
      enabled: false
    }
  }

  Row
  {
    spacing: 8

    Qaterial.OutlineButton
    {
      text: "Default"
    }
    Qaterial.OutlineButton
    {
      text: "Primary"
    }
    Qaterial.OutlineButton
    {
      text: "Accent"
    }
    Qaterial.OutlineButton
    {
      text: "Disabled"
      enabled: false
    }
  }

  Row
  {
    spacing: 8

    Qaterial.RaisedButton
    {
      text: "Default"
    }
    Qaterial.RaisedButton
    {
      text: "Primary"
    }
    Qaterial.RaisedButton
    {
      text: "Accent"
    }
    Qaterial.RaisedButton
    {
      text: "Disabled"
      enabled: false
    }
  }

  Row
  {
    spacing: 8

    Qaterial.FabButton
    {
      icon.source: Qaterial.Icons.rocketOutline
    }
    Qaterial.FabButton
    {
      icon.source: Qaterial.Icons.rocketOutline
    }
    Qaterial.FabButton
    {
      icon.source: Qaterial.Icons.rocketOutline
    }
    Qaterial.FabButton
    {
      icon.source: Qaterial.Icons.rocketOutline
      enabled: false
    }
  }
}
