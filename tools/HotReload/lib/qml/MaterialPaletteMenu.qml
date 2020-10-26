import QtQuick 2.12
import QtQuick.Controls 2.12
import Qaterial 1.0 as Qaterial

Qaterial.Menu
{
  id: root

  implicitWidth: palette.implicitWidth + leftPadding + rightPadding
  implicitHeight: palette.implicitHeight + topPadding + bottomPadding

  leftPadding: 8
  rightPadding: 8

  Qaterial.MaterialColorPalette
  {
    id: palette

    cellWidth: 24
    cellHeight: 24

    showName: false
    showShade: false

    function camelize(str)
    {
      return str.replace(/(?:^\w|[A-Z]|\b\w)/g, function(word, index)
        {
          return index === 0 ? word.toLowerCase() : word.toUpperCase();
        })
        .replace(/\s+/g, '');
    }

    onAccepted: function(color, name, shade)
    {
      const colorProperty = `Qaterial.Colors.${camelize(name)}${shade}`
      Qaterial.Clipboard.text = colorProperty
      Qaterial.SnackbarManager.show(`Color copied! \n"${colorProperty}"`)
    }
  }

}
