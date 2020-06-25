pragma Singleton

import QtQml 2.12

QtObject
{
    readonly property string path: `qrc:/Qaterial/Icons`

    readonly property string menu: `${path}/menu.svg`

    readonly property string calendar: `${path}/calendar.svg`
    readonly property string calendar_clock: `${path}/calendar-clock.svg`
    readonly property string clock: `${path}/clock-outline.svg`

    readonly property string chevronDown: `${path}/chevron-down.svg`
    readonly property string chevronLeft: `${path}/chevron-left.svg`
    readonly property string chevronRight: `${path}/chevron-right.svg`
    readonly property string chevronUp: `${path}/chevron-up.svg`

    readonly property string formatHorizontalAlignCenter: `${path}/format-horizontal-align-center.svg`
    readonly property string formatHorizontalAlignLeft: `${path}/format-horizontal-align-left.svg`
    readonly property string formatHorizontalAlignRight: `${path}/format-horizontal-align-right.svg`
    readonly property string formatVerticalAlignBottom: `${path}/format-vertical-align-bottom.svg`
    readonly property string formatVerticalAlignCenter: `${path}/format-vertical-align-center.svg`
    readonly property string formatVerticalAlignTop: `${path}/format-vertical-align-top.svg`

    readonly property string fullscreen: `${path}/fullscreen.svg`
    readonly property string fullscreenExit: `${path}/fullscreen-exit.svg`

    readonly property string sync: `${path}/sync.svg`
    readonly property string folderOutline: `${path}/folder-outline.svg`
}
