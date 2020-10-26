/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Container
{
  id: _container
  property Qaterial.TextField textField
  property Qaterial.TextArea textArea
  property Qaterial.ComboBox comboBox
  width: list.contentWidth

  contentItem: ListView
  {
    id: list
    model: _container.contentModel
    snapMode: ListView.SnapOneItem
    orientation: ListView.Horizontal
  }

  function assignTextFieldToContentItem()
  {
    if(textField)
    {
      for(var i = 0; i < count; i++)
      {
        var item = itemAt(i)
        if(item && ((typeof item.textField) == "object"))
          item.textField = _container.textField
      }
    }
    if(textArea)
    {
      for(var i = 0; i < count; i++)
      {
        var item = itemAt(i)
        if(item && ((typeof item.textArea) == "object"))
          item.textArea = _container.textArea
      }
    }
    if(comboBox)
    {
      for(var i = 0; i < count; i++)
      {
        var item = itemAt(i)
        if(item && ((typeof item.comboBox) == "object"))
          item.comboBox = _container.comboBox
      }
    }
  } // function assignTextFieldToContentItem()
  onTextFieldChanged: assignTextFieldToContentItem()
} // Container
