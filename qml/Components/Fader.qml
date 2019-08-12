import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls.Universal 2.12

T.Slider {
    id: control

    property int faderWidth : 2
    property bool osc : true
    property int handleWidth : ((faderWidth*0.6) +2)*4
    



    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitHandleWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitHandleHeight + topPadding + bottomPadding)

    padding: 6

    property bool useSystemFocusVisuals: true

    handle: Rectangle {
        implicitWidth: control.horizontal ? 8 : osc ? faderWidth : handleWidth 
        implicitHeight: control.horizontal ? 24 : 8

        x: control.leftPadding + (control.horizontal ? control.visualPosition * (control.availableWidth - width) : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : control.visualPosition * (control.availableHeight - height))

        radius: 4
        color: control.pressed ? control.Universal.chromeHighColor :
               osc ?  control.Universal.chromeHighColor :
               control.hovered ? control.Universal.chromeAltLowColor :
               control.enabled ? control.Universal.accent : control.Universal.chromeDisabledHighColor

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
