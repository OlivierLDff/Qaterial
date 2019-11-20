/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtGraphicalEffects 1.12

// Qaterial
import Qaterial 1.0

Image
{
    id: control
    height: MaterialStyle.card.mediaImplicitHeight
    width: MaterialStyle.card.mediaImplicitWidth
    fillMode: Image.PreserveAspectCrop

    property bool clipTop: false
    property double radius: MaterialStyle.card.radius

    layer.enabled: clipTop
    layer.effect: OpacityMask
    {
        maskSource: Rectangle
        {
            width: control.width
            height: control.height
            radius: control.radius

            Rectangle
            {
                width: parent.width
                y: control.radius
                height: parent.height-radius
            }
        }
    } // OpacityMask

    /*DebugRectangle
    {
        anchors.fill: control
        border.color: "blue"
        z: 10
    } // DebugRectangle*/
} // Image
