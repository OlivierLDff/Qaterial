---
layout: default
title: 🗨️ System Dialog
---

# 🗨️ System Dialog

## File Dialog

![systemDialog](https://user-images.githubusercontent.com/17255804/89714390-8bb24e00-d99e-11ea-80bc-47d26183d135.gif)

# 💾 Save File Dialog

```js
import Qaterial 1.0 as Qaterial

Qaterial.Button
{
  id: root
  text: "Save File Dialog"
  onClicked: function()
  {
    Qaterial.DialogManager.showSaveFileDialog({
      context: root,
      title: qsTr("Save File ..."),
      folder: "file://",
      nameFilters: ["Text file (*.txt)", "Json file (*.json)"],
      onAccepted: (path) => console.log(`Accept path ${path}`),
      onRejected: () => console.log("Reject save file dialog")
    })
  }
}
```

# 📁 Open File Dialog

```js
import Qaterial 1.0 as Qaterial

Qaterial.Button
{
  id: root
  text: "Open File Dialog"
  onClicked: function()
  {
    Qaterial.DialogManager.showOpenFileDialog({
      context: root,
      title: qsTr("Load File ..."),
      folder: "file://",
      nameFilters: ["Text file (*.txt)", "Json file (*.json)"],
      onAccepted: (path) => console.log(`Accept path ${path}`),
      onRejected: () => console.log("Reject open file dialog")
    })
  }
}
```

# 📁 Open Files Dialog

```js
import Qaterial 1.0 as Qaterial

Qaterial.Button
{
  id: root
  text: "Open Files Dialog"
  onClicked: function()
  {
    Qaterial.DialogManager.showOpenFilesDialog({
      context: root,
      title: qsTr("Load Files ..."),
      folder: "file://",
      nameFilters: ["Text file (*.txt)", "Json file (*.json)"],
      onAccepted: (paths) => console.log(`Accept path ${paths}`),
      onRejected: () => console.log("Reject open files dialog")
    })
  }
}
```

# 📂 Open Folder Dialog

```js
import Qaterial 1.0 as Qaterial

Qaterial.Button
{
  id: root
  text: "Open Folder Dialog"
  onClicked: function()
  {
    Qaterial.DialogManager.showFolderDialog({
      context: root,
      title: qsTr("Pick Folder ..."),
      folder: "file://",
      onAccepted: (path) => console.log(`Accept folder ${path}`),
      onRejected: () => console.log("Reject folder dialog")
    })
  }
}
```

