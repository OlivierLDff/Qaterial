import QtQuick 2.0
import Qt.labs.folderlistmodel 2.14
import QtQuick.Controls 2.12
import Qaterial 1.0 as Qaterial

Column
{
  width: 520

  GridView
  {
    id: grid
    clip: true

    width: parent.width
    height: 500

    cellWidth: 50
    cellHeight: 50

    ScrollBar.vertical: Qaterial.ScrollBar { x: 32;policy: ScrollBar.AlwaysOn }

    Timer
    {
      id: delaySearch
      interval: 100
      onTriggered: function()
      {
        const words = textField.text.split(' ')
        let filter = '*'
        words.forEach((word) => filter += `${word.toLowerCase()}*`)
        console.log(`filter: ${filter}`)
        folderModel.nameFilters = [`${filter}.svg`]
      }
    } // Timer

    model: FolderListModel
    {
      id: folderModel
      folder: 'qrc:/Qaterial/Icons/'
      nameFilters: ['*.svg']

      //property string iconSearch
    } // FolderListModel

    delegate: Qaterial.AppBarButton
    {
      id: icon

      readonly property
      var forbiddenKeywords: ['id', 'index', 'model', 'modelData', 'console', 'do', 'if', 'in', 'for', 'let', 'new',
        'try', 'var', 'case', 'else', 'enum', 'eval', 'null', 'this', 'true', 'void', 'with', 'await', 'break',
        'catch', 'class', 'const', 'false', 'super', 'throw', 'while', 'yield', 'delete', 'export', 'import',
        'public', 'return', 'static', 'switch', 'typeof', 'default', 'extends', 'finally', 'package', 'private',
        'continue', 'debugger', 'function', 'arguments', 'interface', 'protected', 'implements', 'instanceof'
      ]

      function fileNameToProperty(str)
      {
        // snake to camel
        str = str.replace(/([-_][a-z0-9])/g,
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

      icon.source: `qrc:/Qaterial/Icons/${fileName}`

      onClicked: function()
      {
        const textToCopy = `${fileNameToProperty(fileName)}`
        Qaterial.Clipboard.text = textToCopy
        Qaterial.SnackbarManager.show(`Icon Name Copied! \n'${textToCopy}'`)
      }

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

    onTextEdited: () => delaySearch.start()
  } // TextField
} // Item
