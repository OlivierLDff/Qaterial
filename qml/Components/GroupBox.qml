/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the Qt Quick Controls 2 module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL3$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see http://www.qt.io/terms-conditions. For further
** information use the contact form at http://www.qt.io/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPLv3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU Lesser General Public License version 3 requirements
** will be met: https://www.gnu.org/licenses/lgpl.html.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 2.0 or later as published by the Free
** Software Foundation and appearing in the file LICENSE.GPL included in
** the packaging of this file. Please review the following information to
** ensure the GNU General Public License version 2.0 requirements will be
** met: http://www.gnu.org/licenses/gpl-2.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

// import QtQuick 2.12
// import QtQuick.Templates 2.12 as T
// import QtQuick.Controls.Material 2.12
// import QtQuick.Controls.Material.impl 2.12

// T.GroupBox {
//     id: control

//     implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
//                             contentWidth + leftPadding + rightPadding,
//                             implicitLabelWidth + leftPadding + rightPadding)
//     implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
//                              contentHeight + topPadding + bottomPadding)

//     spacing: 6
//     padding: 12
//     topPadding: Material.frameVerticalPadding + (implicitLabelWidth > 0 ? implicitLabelHeight + spacing : 0)
//     bottomPadding: Material.frameVerticalPadding

//     label: Text {
//         x: control.leftPadding
//         width: control.availableWidth

//         text: control.title
//         font: control.font
//         color: control.enabled ? control.Material.foreground : control.Material.hintTextColor
//         elide: Text.ElideRight
//         verticalAlignment: Text.AlignVCenter
//     }

//     background: Rectangle {
//         y: control.topPadding - control.bottomPadding
//         width: parent.width
//         height: parent.height - control.topPadding + control.bottomPadding

//         radius: 2
//         color: control.Material.elevation > 0 ? control.Material.backgroundColor : "transparent"
//         border.color: control.Material.frameColor

//         layer.enabled: control.enabled && control.Material.elevation > 0
//         layer.effect: ElevationEffect {
//             elevation: control.Material.elevation
//         }
//     }
// }

/** 
 * Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com 
 */

import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtGraphicalEffects 1.12

import QQuickMaterialHelper.Components 1.12
import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Core 1.12

T.GroupBox 
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    spacing:  MaterialStyle.card.spacing
    horizontalPadding: MaterialStyle.card.horizontalPadding
    verticalPadding: MaterialStyle.card.verticalPadding

    topPadding: verticalPadding + (inlineTitle ? (implicitLabelWidth > 0 ? implicitLabelHeight/2 + spacing : 0) : (implicitLabelWidth > 0 ? implicitLabelHeight + spacing : 0))

    property bool onPrimary: false
    property bool colorReversed: onPrimary && MaterialStyle.shouldReverseForegroundOnPrimary

    property color color: onPrimary ? MaterialStyle.primaryColor : MaterialStyle.backgroundColor
    property color borderColor: enabled ? MaterialStyle.dividersColor() : MaterialStyle.disabledDividersColor()
    property alias radius: _rect.radius

    property alias titleType: _label.textType

    property bool inlineTitle: false

    label: Label 
    {
        id: _label
        x: control.leftPadding + (control.inlineTitle ? (control.verticalPadding) : 0 )
        width: control.availableWidth - x

        text: control.title
        textType: MaterialStyle.TextType.Overline
        onPrimary: control.onPrimary
        colorReversed: control.colorReversed
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter

        property bool drawline: MaterialStyle.debug.drawDebugIconLabel
    }

    background: Rectangle 
    {
        id: _rect
        y: control.inlineTitle ? _label.implicitHeight/2 : (control.topPadding - control.bottomPadding)
        implicitWidth: 200
        width: parent.width
        height: parent.height + (control.inlineTitle ? (-_label.implicitHeight/2) : (-control.topPadding + control.bottomPadding))
        radius: MaterialStyle.card.radius
        color: control.inlineTitle ? "transparent" : control.color
        border.color: control.borderColor
        border.width: 1
        layer.enabled: control.inlineTitle && control.implicitLabelWidth
        layer.effect: OpacityMask 
        {
            invert: true
            maskSource: Rectangle
            {
                color: "transparent"
                width: _rect.width
                height: _rect.height
                Rectangle 
                {
                    width: _label.contentWidth + control.verticalPadding*2
                    height: _label.implicitHeight
                    x: control.leftPadding
                    y: -height/2
                } // Rectangle
            } // Rectangle
        } // OpacityMask
    } // Rectangle
} // Frame
