import QtQuick 2.0
import Qt.labs.folderlistmodel 2.14
import Qaterial 1.0 as Qaterial

Column
{
  width: 500

  function fileNameToProperty(str)
  {
    // snake to camel
    str = str.replace( /([-_][a-z0-9])/g,
        (group) => group.toUpperCase()
                    .replace('-', '')
                    .replace('_', '')
    );

    // remove extension
    str = str.replace(/\.[^/.]+$/, "")

    // append _ to forbidden keywords
    if(forbiddenKeywords.includes(str))
      return `${str}_`
    return str
  }

  readonly property var forbiddenKeywords: ['id','index','model','modelData','do','if','in','for','let','new','try','var','case','else','enum','eval','null','this','true','void','with','await','break','catch','class','const','false','super','throw','while','yield','delete','export','import','public','return','static','switch','typeof','default','extends','finally','package','private','continue','debugger','function','arguments','interface','protected','implements','instanceof']

  function isAmongString(searchvalue, string)
  {
    return string.search(searchvalue) !== -1
  }

  GridView
  {
    id: grid
    clip: true

    width: parent.width
    height: 500

    cellWidth: 50
    cellHeight: 50

    Timer
    {
      interval: 100
      repeat: true
      running: true
      onTriggered: folderModel.iconSearch = textField.text
    } // Timer

    model: FolderListModel
    {
      id: folderModel
      folder: "qrc:/Qaterial/Icons/"
      nameFilters: [`*${iconSearch}*.svg`]

      property string iconSearch
    } // FolderListModel

    delegate: Qaterial.AppBarButton
    {
      id: icon

      icon.source: `qrc:/Qaterial/Icons/${fileName}`
      Qaterial.ToolTip
      {
        text: `${fileNameToProperty(fileName)}`
        delay: 50
        visible: icon.hovered
      } // ToolTip
    } // AppBarButton
  } // GridView

  // To search icons
  Qaterial.TextField
  {
    id: textField
    anchors.horizontalCenter: parent.horizontalCenter
    width: 300
    title: titleUp ? "Search" : "Search ..."
    leadingIconSource: Qaterial.Icons.magnify
    leadingIconInline: true
    helperText: "Use * as a wild card"
  } // TextField
} // Item