/** 
 * Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com 
 */

import QtQuick 2.12
import QtQuick.Controls 2.12

import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Core 1.12
import QQuickMaterialHelper.Components 1.12

TextArea
{
    id: control
    textArea: _textArea
    contentItem: TextAreaScrollView
    {
        id: view
        implicitBottomPadding: textAreaBottomPadding
        implicitTopPadding: textAreaTopPadding

        TextAreaContent
        {
            id: _textArea
            onPrimary: control.onPrimary
            colorReversed: control.colorReversed
            rightPadding: view.ScrollBar.vertical.implicitWidth
            topPadding:  control.textAreaTopPadding
            bottomPadding: control.textAreaBottomPadding

            leftPadding: control.textAreaLeftPadding

            onEditingFinished: control.editingFinished()
            onLinkActivated: control.linkActivated(link)
            onLinkHovered: control.linkHovered(link)

            forcePlaceholderOff: !control.titleUp
            textType: control.textType
            placeholderText: control.placeholderText
            text: control.text
            wrapMode: control.wrapMode
            cursorVisible: control.cursorVisible
            color: control.color
            selectionColor: control.selectionColor
            selectedTextColor: control.selectedTextColor
            placeholderTextColor: control.placeholderTextColor
            verticalAlignment: control.verticalAlignment
            renderType: control.renderType
        } // TextAreaContent
    } // TextAreaScrollView
}