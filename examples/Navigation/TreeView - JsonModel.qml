import QtQuick 2.14
import QtQuick.Layouts 1.14
import QtQml 2.14

import Qaterial 1.0 as Qaterial

Qaterial.TreeView
{
  id: root

  width: 300
  height: parent ? Math.min(contentHeight, parent.height) : contentHeight

  model: ListModel
  {
    Component.onCompleted: function()
    {
      const data = [
      {
        "expanded": false,
        "children": [
        {
          "expanded": false,
          "children": [
          {
            "expanded": false,
            "depth": 0,
            "children": [

            ],
            "label": "101 (ubuntu-xenial)",
            "type": "lxc"
          },
          {
            "expanded": false,
            "depth": 0,
            "children": [

            ],
            "label": "100 (pvetest-stretch)",
            "type": "qemu"
          }],
          "label": "debianpro",
          "type": "node",
          "depth": 0
        }],
        "label": "debianpro",
        "type": "remote",
        "depth": 0
      },
      {
        "expanded": false,
        "children": [
        {
          "expanded": false,
          "children": [
          {
            "expanded": false,
            "depth": 0,
            "children": [

            ],
            "label": "103 (stretch01)",
            "type": "lxc"
          },
          {
            "expanded": false,
            "depth": 0,
            "children": [

            ],
            "label": "104 (ubuntu18-ct)",
            "type": "lxc"
          },
          {
            "expanded": false,
            "depth": 0,
            "children": [

            ],
            "label": "107 (no-ipv4)",
            "type": "lxc"
          },
          {
            "expanded": false,
            "depth": 0,
            "children": [

            ],
            "label": "100 (Win10MSEdge)",
            "type": "qemu"
          },
          {
            "expanded": false,
            "depth": 0,
            "children": [

            ],
            "label": "101 (Win7IE8)",
            "type": "qemu"
          },
          {
            "expanded": false,
            "depth": 0,
            "children": [

            ],
            "label": "102 (stretchdocker)",
            "type": "qemu"
          },
          {
            "expanded": false,
            "depth": 0,
            "children": [

            ],
            "label": "106 (ubuntu18-vm)",
            "type": "qemu"
          },
          {
            "expanded": false,
            "depth": 0,
            "children": [

            ],
            "label": "108 (pve5.2)",
            "type": "qemu"
          }],
          "label": "nena",
          "type": "node",
          "depth": 0
        }],
        "label": "nena",
        "type": "remote",
        "depth": 0
      },
      {
        "expanded": false,
        "children": [
        {
          "expanded": false,
          "children": [
          {
            "expanded": false,
            "depth": 0,
            "children": [

            ],
            "label": "101 (saltmaster)",
            "type": "lxc"
          },
          {
            "expanded": false,
            "depth": 0,
            "children": [

            ],
            "label": "102 (gitlab)",
            "type": "lxc"
          },
          {
            "expanded": false,
            "depth": 0,
            "children": [

            ],
            "label": "103 (aptcacher)",
            "type": "lxc"
          },
          {
            "expanded": false,
            "depth": 0,
            "children": [

            ],
            "label": "104 (psql1)",
            "type": "lxc"
          },
          {
            "expanded": false,
            "depth": 0,
            "children": [

            ],
            "label": "105 (monitor1)",
            "type": "lxc"
          },
          {
            "expanded": false,
            "depth": 0,
            "children": [

            ],
            "label": "106 (spads01)",
            "type": "lxc"
          },
          {
            "expanded": false,
            "depth": 0,
            "children": [

            ],
            "label": "111 (file01)",
            "type": "lxc"
          },
          {
            "expanded": false,
            "depth": 0,
            "children": [

            ],
            "label": "100 (win10)",
            "type": "qemu"
          }],
          "label": "srv01",
          "type": "node",
          "depth": 0
        }],
        "label": "srv01",
        "type": "remote",
        "depth": 0
      }]

      root.model.clear()
      data.forEach(function(row)
      {
        root.model.append(row);
      })
    }
  }

  itemDelegate: Qaterial.ItemDelegate
  {
    id: control

    property QtObject model
    property int depth
    property int index

    height: 24
    leftPadding: depth * 20

    contentItem: RowLayout
    {
      Qaterial.ColorIcon
      {
        source: Qaterial.Icons.chevronRight
        color: Qaterial.Style.hintTextColor()
        visible: control.model && control.model.children && control.model.children.count
        Binding on rotation
        {
          when: control.model && control.model.expanded
          value: 90
          restoreMode: Binding.RestoreBindingOrValue
        }
        Behavior on rotation { NumberAnimation { duration: 200;easing.type: Easing.OutQuart } }
      }
      Qaterial.Label
      {
        Layout.fillWidth: true
        text: control.model ? control.model.label : ""
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
      }
      Qaterial.Label
      {
        textType: Qaterial.Style.TextType.Caption
        text: control.model ? control.model.type : ""
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
      }
    }

    onClicked: function()
    {
      if(model.children.count !== 0)
        model.expanded = !model.expanded
    }
  }
}
