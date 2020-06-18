pragma Singleton

import QtQml 2.12

QtObject
{
    readonly property string path: `qrc:/Qaterial/Icons`

    readonly property string calendar: `${path}/calendar.svg`

    readonly property string chevronDown: `${path}/chevron-down.svg`
    readonly property string chevronLeft: `${path}/chevron-left.svg`
    readonly property string chevronRight: `${path}/chevron-right.svg`
    readonly property string chevronUp: `${path}/chevron-up.svg`
}