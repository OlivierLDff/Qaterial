import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.ApplicationWindow
{
  id: window

  width: 500
  height: 300

  minimumWidth: 100
  minimumHeight: 100

  // Save and restore x, y, width, height of window
  Qaterial.WindowLayoutSave { name: "MyCategory" }

  Column
  {
    anchors.centerIn: parent

    Qaterial.Label { text: `resolution : ${window.width}x${window.height}` }
    Qaterial.Label { text: `position : {${window.x},${window.y}}` }
    Qaterial.Label { text: `screen : ${window.screen.name}` }
  }
}
