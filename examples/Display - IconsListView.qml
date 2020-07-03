import QtQuick 2.0
import Qt.labs.folderlistmodel 2.14

import SortFilterProxyModel 1.0
import Qaterial 1.0 as Qaterial

Item
{
  width: grid.cellWidth*10
  height: grid.cellWidth*grid.model.count/10 + 20 + textField.height

  // function to get IconName from fileName
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

    // Use FolderListModel to get every icons file name
    FolderListModel
    {
      id: folderModel
      folder: "qrc:/Qaterial/Icons/"
      nameFilters: ["*.svg", "*.jpg", "*.png"]
    } // FolderListModel

    // Use SortFilterProxyModel library to
    SortFilterProxyModel
    {
      id: personProxyModel
      sourceModel: folderModel
      filters: RegExpFilter
      {
        id: regExpFilter
        roleName: "fileName"
        caseSensitivity: Qt.CaseInsensitive
      }
      sorters: StringSorter { roleName: "fileName" }
    } // SortFilterProxyModel

    // To make QaterialHotReload fluider
    Timer
    {
      interval: 100
      repeat: true
      running: true
      onTriggered: regExpFilter.pattern = textField.text
    } // Timer

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
        icon.source: Qaterial.Icons[iconName]
        icon.color: Qaterial.Style.accentColor
        visible: searched

        Qaterial.ToolTip
        {
          text: `${iconName}`
          delay: 50
          visible: icon.hovered
        } // ToolTip

        onClicked: console.log(`"Qaterial.Icons.${iconName}" copy to clipboard`)

        //Component.onCompleted: () => console.log(`fileBaseName : ${fileBaseName}`)
      } // AppBarButton
    } // Component

    model: personProxyModel
    delegate: fileDelegate
  } // GridView

  // To search icons
  Qaterial.TextField
  {
    id: textField
    anchors.horizontalCenter: parent.horizontalCenter
    y: parent.height - 10 - height
    width: 250
    title: "Search Icon"
    placeholderText: "Keyword"
  } // TextField
} // Item