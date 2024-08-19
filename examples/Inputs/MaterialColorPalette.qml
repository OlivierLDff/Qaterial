import QtQuick
import Qaterial as Qaterial

Qaterial.MaterialColorPalette
{
  cellWidth: 48
  cellHeight: 48

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
    console.log(`Accept ${name} ${shade} (${color})`)
    const colorProperty = `Qaterial.Colors.${camelize(name)}${shade}`
    Qaterial.Clipboard.text = colorProperty
    Qaterial.SnackbarManager.show(`Color copied! \n"${colorProperty}"`)
  }
}
