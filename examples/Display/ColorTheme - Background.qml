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
  Grid
  {
    width: 300
    spacing: 16

    columns: 2

    Repeater
    {
      model: [0, 1, 2, 3, 4, 6, 8, 12, 16, 24]

      delegate: Qaterial.Card
      {
        id: card

        Qaterial.Theme.elevation: modelData
        elevation: Qaterial.Theme.elevation
        outlined: Qaterial.Theme.elevation === 0
        backgroundColor: Qaterial.Style.colorTheme.getElevatedColor(Qaterial.Style.colorTheme.background0, Qaterial.Theme.elevation)
        width: 112
        height: 112

        Qaterial.LabelSubtitle1
        {
          anchors
          {
            left: parent.left
            top: parent.top

            leftMargin: 12
            topMargin: 12
          }

          text: `${card.Qaterial.Theme.elevation}dp`
        }

        Qaterial.LabelCaption
        {
          anchors
          {
            right: parent.right
            bottom: parent.bottom

            rightMargin: 12
            bottomMargin: 12
          }

          text: `Overlay : ${(Qaterial.Style.colorTheme.getOverlayForElevation(card.Qaterial.Theme.elevation)*100).toFixed(0)}%`
        }
      }
    }
  }

}
