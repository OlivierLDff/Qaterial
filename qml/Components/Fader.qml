import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12
import QtQuick.Controls.Universal 2.12

import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Core 1.12

T.Slider {
    id: control

   
    property bool osc : true // to create an osc fader, same witdh for the handle and for the fader
   
    property bool highlighted  : true // for highlited the fader
    property bool accentRipple: false
    property int handleWidth : ((faderWidth*0.6) +2)*4
    property int faderWidth : 2

    readonly property int rawRippleColor: enabled ? MaterialStyle.RippleBackground.Accent : MaterialStyle.RippleBackground.Primary 

    property color rippleColor: MaterialStyle.rippleColor(accentRipple ? MaterialStyle.RippleBackground.AccentLight :  "rawRippleColor")


    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitHandleWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitHandleHeight + topPadding + bottomPadding)

    padding: 6

    property bool useSystemFocusVisuals: true

    handle: Item {
        id : _handleItem
        x: control.leftPadding + (control.horizontal ? control.visualPosition * (control.availableWidth - width) : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : control.visualPosition * (control.availableHeight - height))


    Rectangle {
        id : _rectangleHandle
        implicitWidth: control.horizontal ? 8 : osc ? faderWidth : handleWidth 
        implicitHeight: control.horizontal ? osc ? faderWidth :handleWidth  : 8
       
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        radius: width / 2
           color: control.pressed ? control.Universal.chromeHighColor :
               control.hovered ? control.Universal.chromeAltLowColor :
               control.enabled ? control.Universal.accent : control.Universal.chromeDisabledHighColor
       
        }
    
    Ripple {
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: _rectangleHandle.width
        height: _rectangleHandle.height
        active: control.pressed || control.hovered
        color: control.rippleColor

        scale: control.pressed ? 1.2 : 1

        Behavior on scale {
            NumberAnimation {
                duration: 250
            }
    }
}
}


    background: Item {
        implicitWidth: control.horizontal ? 200 : 18
        implicitHeight: control.horizontal ? 18 : 200

        x: control.leftPadding + (control.horizontal ? 0 : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : 0)
        width: control.horizontal ? control.availableWidth : implicitWidth
        height: control.horizontal ? implicitHeight : control.availableHeight

        scale: control.horizontal && control.mirrored ? -1 : 1

        Rectangle {
            x: control.horizontal ? 0 : (parent.width - width) / 2
            y: control.horizontal ? (parent.height - height) / 2 : 0
            width: control.horizontal ? parent.width : faderWidth // SliderTrackThemeHeight
            height: !control.horizontal ? parent.height : faderWidth // SliderTrackThemeHeight

            color: control.hovered && !control.pressed ? control.Universal.baseMediumColor :
                   control.enabled ? control.Universal.baseMediumLowColor : control.Universal.chromeDisabledHighColor
        }

        Rectangle {
            x: control.horizontal ? 0 : (parent.width - width) / 2
            y: control.horizontal ? (parent.height - height) / 2 : control.visualPosition * parent.height
            width: control.horizontal ? control.position * parent.width : faderWidth // SliderTrackThemeHeight
            height: !control.horizontal ? control.position * parent.height : faderWidth // SliderTrackThemeHeight

            color: control.enabled ? control.Universal.accent : control.Universal.chromeDisabledHighColor
        }
    }
}
