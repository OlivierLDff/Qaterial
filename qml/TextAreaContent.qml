/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12

import Qaterial 1.0

T.TextArea
{
    id: control

    property int textType: Style.TextType.ListText
    property int placeholderTextType: textType
    property bool onPrimary: false
    property bool colorReversed: onPrimary && Style.shouldReverseForegroundOnPrimary

    font.family: Style.textTypeToFontFamily(textType)
    font.styleName: Style.textTypeToStyleName(textType)
    font.pixelSize: Style.textTypeToPixelSize(textType)
    font.capitalization: Style.fontCapitalization(textType)
    font.letterSpacing:  Style.textTypeToLetterSpacing(textType)

    // DEBUG
    property bool drawline: Style.debug.drawDebugButton
    DebugRectangle
    {
        anchors.fill: parent
        border.color: "pink"
        visible: control.drawline
    } // DebugRectangle
    DebugRectangle
    {
        x: control.leftPadding
        y: control.topPadding
        width: control.width - control.leftPadding - control.rightPadding
        height: control.contentHeight
        border.color: "orange"
        visible: control.drawline
    } // DebugRectangle
    DebugRectangle
    {
        x: control.leftPadding
        y: control.topPadding
        width: Math.min(control.contentWidth, control.width - control.leftPadding - control.rightPadding)
        height: control.contentHeight
        border.color: "red"
        visible: control.drawline
    } // DebugRectangle

    // SIZE
    implicitWidth: Math.max(contentWidth + leftPadding + rightPadding,
                            implicitBackgroundWidth + leftInset + rightInset,
                            placeholder.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(contentHeight + topPadding + bottomPadding,
                             implicitBackgroundHeight + topInset + bottomInset,
                             placeholder.implicitHeight + topPadding + bottomPadding)

    bottomPadding: 0

    // COLORS
    property alias textColor: control.color
    color: enabled ? Style.primaryTextColor() : Style.hintTextColor()
    selectionColor: Style.accentColor
    placeholderTextColor: Style.hintTextColor()
    verticalAlignment: TextInput.AlignTop

    // BEHAVIOR
    selectByMouse: true
    wrapMode: TextEdit.Wrap

    // CURSOR
    cursorDelegate: CursorDelegate { }

    // PLACEHOLDER
    property bool forcePlaceholderOff: false
    PlaceholderText
    {
        id: placeholder
        x: control.leftPadding
        y: control.topPadding
        width: control.width - (control.leftPadding + control.rightPadding)
        height: control.height - (control.topPadding + control.bottomPadding)
        text: control.placeholderText
        color: control.placeholderTextColor
        textType: control.placeholderTextType
        verticalAlignment: control.verticalAlignment
        elide: Text.ElideRight
        wrapMode: control.wrapMode
        renderType: control.renderType
        readonly property bool shouldBeVisible: (!forcePlaceholderOff || control.activeFocus) && !control.length && !control.preeditText && (!control.activeFocus || control.horizontalAlignment !== Qt.AlignHCenter)
        opacity: shouldBeVisible ? 1.0 : 0.0

        Behavior on opacity
        {
            NumberAnimation { easing.type: Easing.InQuad; duration: placeholder.shouldBeVisible ? 50 : 200 }
        }
    } // PlaceholderText

    background: Rectangle
    {
        id: _back
        implicitWidth: Style.textField.implicitWidth
        color: "transparent"
    } // Rectangle
} // TextArea
