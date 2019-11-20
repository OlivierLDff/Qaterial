/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qaterial
import Qaterial 1.0

Image
{
    id: root
    fillMode: Image.PreserveAspectFit

    sourceSize.width: width
    sourceSize.height: height

    property bool rounded: true

    layer.enabled: rounded
    layer.effect: OpacityMask
    {
        maskSource: Rectangle
        {
            width: root.width
            height: root.height
            radius: root.width/2
        }
    } // OpacityMask
}
