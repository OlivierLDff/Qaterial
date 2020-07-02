import QtQuick 2.0
import Qt.labs.folderlistmodel 2.14
//import SortFilterProxyModel 0.2

import Qaterial 1.0 as Qaterial

Item
{
  width: grid.cellWidth*10
  height: grid.cellWidth*grid.model.count/10 + 20 + textField.height

  //Qaterial.DebugRectangle { anchors.fill: parent}

  function snakeToCamel(str)
  {
    return str.replace( /([-_][a-z0-9])/g,
        (group) => group.toUpperCase()
                    .replace('-', '')
                    .replace('_', '')
    );
  }

  function isAmongString(searchvalue, string)
  {
    return string.search(searchvalue) !== -1
  }

  GridView
  {
    id: grid
    anchors.fill: parent

    cellWidth: 50
    cellHeight: 50

    FolderListModel
    {
      id: folderModel
      folder: "qrc:/Qaterial/Icons/"
      nameFilters: ["*.svg", "*.jpg", "*.png"]
    }

    Component
    {
      id: fileDelegate
      Qaterial.AppBarButton
      {
        id: icon

        property string iconName: snakeToCamel(fileBaseName)
        property bool searched: false

        Binding on searched
        {
          when: textField.textChanged
          value: isAmongString(textField.text.toUpperCase(), iconName.toUpperCase())
        }
        //x: grid.cellWidth/2 - width/2
        icon.source: Qaterial.Icons[iconName]
        // "qrc:/Qaterial/Icons/" + fileName
        icon.color: Qaterial.Style.accentColor
        visible: searched

        Qaterial.ToolTip
        {
          text: `${iconName}`
          delay: 50
          visible: icon.hovered
        }

        onClicked: console.log(`"Qaterial.Icons.${iconName}" copy to clipboard`)

        //Component.onCompleted: () => console.log(`fileBaseName : ${fileBaseName}`)
      }
    }

    model: folderModel
    delegate: fileDelegate
  }

  Qaterial.TextField
  {
    id: textField
    anchors.horizontalCenter: parent.horizontalCenter
    y: parent.height - 10 - height
    width: 250
    title: "Search Icon"
    placeholderText: "Type a keyword for what you search"
  }
}