import QtQuick 2.12
import QtGraphicalEffects 1.12

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