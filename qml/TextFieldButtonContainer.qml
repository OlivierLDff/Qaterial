/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

import QtQuick 2.12
import QtQuick.Controls 2.12

import Qaterial 1.0

Container
{
    id: container
    property TextField textField
    property TextArea textArea
    property ComboBox comboBox
    width: list.contentWidth
    contentItem: ListView
    {
        id: list
        model: container.contentModel
        snapMode: ListView.SnapOneItem
        orientation: ListView.Horizontal
    }

    function assignTextFieldToContentItem()
    {
        if(textField)
        {
            for (var i = 0; i < count; i++)
            {
                var item = itemAt(i)
                if(item && ((typeof item.textField) == "object"))
                    item.textField = container.textField
            }
        }
        if(textArea)
        {
            for (var i = 0; i < count; i++)
            {
                var item = itemAt(i)
                if(item && ((typeof item.textArea) == "object"))
                    item.textArea = container.textArea
            }
        }
        if(comboBox)
        {
            for (var i = 0; i < count; i++)
            {
                var item = itemAt(i)
                if(item && ((typeof item.comboBox) == "object"))
                    item.comboBox = container.comboBox
            }
        }
    }

    onTextFieldChanged: assignTextFieldToContentItem()
}
