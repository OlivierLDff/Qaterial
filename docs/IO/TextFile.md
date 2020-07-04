---
layout: default
title: 📰 TextFile
---

# 📰 TextFile

The `TextFile` object provides an interface for reading from and writing to text files. This object goal isn't to do complex file manipulation, but simple write/read of strings. For example reading or writing a json file.

## Open Mode

|          **Mode**           |           Description           |
| :-------------------------: | :-----------------------------: |
|   Qaterial.TextFile.Write   | The device is open for writing. |
|   Qaterial.TextFile.Read    | The device is open for reading. |
| Qaterial.TextFile.ReadWrite |      *Not implemented yet*      |
|  Qaterial.TextFile.Append   |      *Not implemented yet*      |

## Properties

* `fileUrl`: Readonly file url. It can be modified with `open()` function.
* `isOpen`: True when the file is opened, false otherwise.
* `fileName`: Filename without extension
* `fileType`: Extension of the file.
* `error`: Readable last error.

## Functions

`bool open(url, mode)`: open the file at `url` with `mode`. Url can be absolute or relative.

* `file:foo.txt`, `foo.txt` are relative
* `file:/foo.txt`, `/foo.txt` are absolute.

`bool close()`: Close the file. If file is in write mode, then the text is really committed to the disk.

`bool write(string)`: Append a string in the file.

`string readAll()`: Read all the file and return the content in a string.

## ✍️ Write text

To write to a file:

* Open the file with `open(url, Qaterial.TextFile.Write)`.
* Write text with `write(string)`.
* Close the file with `close()`.

```js
import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.FlatButton
{
  text: "Write text to file"
  
  onClicked: function()
  {
    textFile.open('foo.txt', Qaterial.TextFile.Write)
    textFile.write('Some Text')
    textFile.close()
  }

  Qaterial.TextFile
  {
    id: textFile
    onErrorChanged: () => console.warn('io error : ${error}')
  }
}
```

If any of the operation fail, the readable error is available with `error` property.

## 📖 Read text

To read a file:

* Open the file with `open(url, Qaterial.TextFile.Read)`.
* Read the content with `readAll()`.
* Close the file with `close()`.

```js
import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.FlatButton
{
  text: "Read text from file"

  onClicked: function()
  {
    textFile.open('foo.txt', Qaterial.TextFile.Read)
    const readText = textFile.readAll()
    textFile.close()

    console.log(`read text: ${readText}`)
  }

  Qaterial.TextFile
  {
    id: textFile
    onErrorChanged: () => console.warn('io error : ${error}')
  }
}
```