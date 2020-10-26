import QtQuick 2.12
import QtQuick.Controls 2.12
import Qt.labs.folderlistmodel 2.14
import Qaterial 1.0 as Qaterial

Qaterial.Menu
{
  id: root

  implicitWidth: 320

  Qaterial.TextField
  {
    id: textField
    anchors.horizontalCenter: parent.horizontalCenter
    title: titleUp ? "Search" : "Search ..."
    leadingIconSource: Qaterial.Icons.magnify
    leadingIconInline: true
    focus: true

    onTextEdited: () => delaySearch.start()
  } // TextField

  GridView
  {
    id: grid
    clip: true

    width: parent.width
    height: 200

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
        let filter1 = ''
        let filter2 = '*'
        let filter3 = ''
        words.forEach(
          function(word)
          {
            const lowerCaseWord = word.toLowerCase()
            filter1 += `${lowerCaseWord}*`
            filter2 += `${lowerCaseWord}*`
            filter3 += `*${lowerCaseWord}`
          })
        //console.log(`filter: ${filter}`)
        folderModel.nameFilters = [`${filter1}.svg`, `${filter2}.svg`, `${filter3}.svg`]
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
        const textToCopy = `Qaterial.Icons.${fileNameToProperty(fileName)}`
        Qaterial.Clipboard.text = textToCopy
        Qaterial.SnackbarManager.show(`Icon Name Copied! \n"${textToCopy}"`)
      }

      Qaterial.ToolTip
      {

        text: `${fileNameToProperty(fileName)}`
        delay: 50
        visible: icon.hovered
      } // ToolTip
    } // AppBarButton
  } // GridView
}
