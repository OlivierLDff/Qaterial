/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0

T.ItemDelegate
{
    id: control

    // TEXT
    property alias overlineText:    _content.overlineText
    property alias secondaryText:   _content.secondaryText

    // THUMBNAIL
    property alias roundSource:     _content.roundSource
    property alias squareSource:    _content.squareSource
    property alias largeSource:     _content.largeSource
    property alias largeThumbnail:  _content.largeThumbnail

    // ICON
    property alias roundColor: _content.roundColor
    property alias fillIcon: _content.fillIcon
    property alias outlinedIcon: _content.outlinedIcon
    property alias highlightedIcon: _content.highlightedIcon
    property alias reverseHighlightIcon: _content.reverseHighlightIcon
    property alias iconColor: _content.iconColor

    // ALIGNMENT
    property alias alignTextRight : _content.alignTextRight
    readonly property int lines: _content.lines
    readonly property int type:  _content.type

    // COLOR
    property alias backgroundColor: _background.color
    property bool onPrimary: false
    property bool colorReversed: onPrimary && MaterialStyle.shouldReverseForegroundOnPrimary

    // SEPARATOR
    property bool drawSeparator: forceDrawSeparator
    property bool forceDrawSeparator: false

    implicitWidth: Math.max(background ? implicitBackgroundWidth : 0,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(background ? implicitBackgroundHeight : 0,
                             Math.max(implicitContentHeight,
                                      indicator ? indicator.implicitHeight : 0) + topPadding + bottomPadding) + bottomInset

    leftPadding: !mirrored ? MaterialStyle.delegate.leftPadding(control.type, control.lines) : MaterialStyle.delegate.rightPadding(control.type, control.lines)
    rightPadding: mirrored ? MaterialStyle.delegate.leftPadding(control.type, control.lines) : MaterialStyle.delegate.rightPadding(control.type, control.lines)
    topPadding: 0
    bottomPadding: 0
    spacing: MaterialStyle.delegate.spacing(control.type, control.lines)
    bottomInset: _separator.visible ? 1 : 0
    focusPolicy: Qt.StrongFocus

    property bool drawline: MaterialStyle.debug.drawDebugDelegate
    DebugRectangle
    {
        anchors.fill: parent
        border.color: "pink"
        visible: control.drawline
    }

    contentItem: ListDelegateContent
    {
        id: _content
        text: control.text
        spacing: control.spacing
        enabled: control.enabled
        mirrored: control.mirrored
        drawline: control.drawline
        onPrimary: control.onPrimary
        colorReversed: control.colorReversed
        iconSource: control.icon.source
    }

    background: ListDelegateBackground
    {
        id: _background
        type: control.type
        lines: control.lines
        pressed: control.pressed
        rippleActive: control.down || control.visualFocus || control.hovered
        rippleAnchor: control
        onPrimary: control.onPrimary
        highlighted: control.highlighted
    } // Rectangle

    property alias toolSeparatorLeftPadding: _separator.leftPadding
    property alias toolSeparatorRightPadding: _separator.rightPadding

    ToolSeparator
    {
        id: _separator
        anchors.right: control.right
        anchors.left: control.left
        anchors.bottom: control.bottom
        verticalPadding: 0
        orientation: Qt.Horizontal
        visible: control.forceDrawSeparator ||
            control.drawSeparator && (control.ListView.view ? (control.ListView.view.count > 1 && index < (control.ListView.view.count-1)) : false)
    }
}
