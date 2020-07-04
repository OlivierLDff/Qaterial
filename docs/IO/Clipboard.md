---
layout: default
title: 📋 Clipboard
---

# 📋 Clipboard

The clipboard offers a simple mechanism to copy and paste data between applications.

`Clipboard` is provided as a Singleton.

## Copy Text

The Clipboard have a `text` property that is used to read and write to the clipboard. An additional `owns` property tells if the text have been written by our application, or by an other application.

```js
import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.Label
{
    // Read last text in clipboard
    text: Qaterial.Clipboard.text
    
    // React to clipboard text changed
    Connections
    {
        target: Qaterial.Clipboard
        function onTextChanged() 
        { 
            console.log(`new text in clipboard: ${Qaterial.Clipboard.text}`) 
        }
    }
    
    // Write some text to the clipboard
    Component.onCompleted: () => Qaterial.Clipboard.text = "my text"
}
```

The example `IO/Clipboard.qml` demonstrate how to copy text and how to list everything that have been copied.

## Copy Url

> Not supported yet

## Copy Html

> Not supported yet

## Copy Image

> Not supported yet