// Qt

import Qaterial 1.0 as Qaterial

Qaterial.ApplicationWindow
{
  id: window

  width: 400
  height: 200

  visible: true

  Qaterial.Label
  {
    text: 'Hello World'
    anchors.centerIn: parent
  }
}
