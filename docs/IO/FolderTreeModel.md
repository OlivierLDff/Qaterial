---
layout: default
title: 📁 FolderTreeModel
---

# 📁 FolderTreeModel

![folderTreeModel](https://user-images.githubusercontent.com/17255804/88556713-9deccd80-d029-11ea-97b7-4929753a4d85.gif)

`FolderTreeModel` mimic the API of `FolderListModel` but already exposed for a `TreeView`.

[QaterialOnline](https://tinyurl.com/y2sg6xp3)

## FolderTreeModel

### Properties

| Property          | Type         | Default    | Description                                                  |
| :---------------- | :----------- | :--------- | :----------------------------------------------------------- |
| path              | `url`        | *empty*    | The path property holds a URL for the folder that the model currently provides. |
| nameFilters       | `stringlist` | *empty*    | The nameFilters property contains a list of file name filters. The filters may include the ? and * wildcards. Example : `nameFilters: ["*.png", "*.jpg"]` |
| caseSensitive     | `bool`       | *true*     | Use case sensitive pattern matching.                         |
| showDrives        | `bool`       | *true*     | If true, drives are included in the model.                   |
| showDirs          | `bool`       | *true*     | If true, directories are included in the model; otherwise only files are included. |
| showFiles         | `bool`       | *true*     | If true, files are included in the model; otherwise only directories are included. |
| showDirsFirst     | `bool`       | *true*     | If true, if directories are included in the model they will always be shown first, then the files. |
| showDot           | `bool`       | *false*    | If true, the "." directory is included in the model; otherwise it is excluded. |
| showDotDot        | `bool`       | *false*    | If true, the ".." directory is included in the model; otherwise it is excluded. |
| showDotAndDotDot  | `bool`       | *false*    | If true, the "." and ".." directories are included in the model; otherwise they are excluded. |
| showHidden        | `bool`       | *false*    | If true, hidden files and directories are included in the model; otherwise they are excluded. |
| showOnlyReadable  | `bool`       | *false*    | If true, only readable files and directories are shown; otherwise all files and directories are shown. |
| sortCaseSensitive | `bool`       | *true*     | If set to true, the sort is case sensitive. This property is true by default. |
| sortReversed      | `bool`       | *false*    | If set to true, reverses the sort order. The default is false. |
| sortField         | `int`        | *Unsorted* | The sortField property contains field to use for sorting. sortField may be one of:<br/>- FolderTreeModel.Unsorted<br/>- FolderTreeModel.Name<br/>- FolderTreeModel.Time<br/>- FolderTreeModel.Size<br/>- FolderTreeModel.Type |
| status            | `int`        | *Null*     | This property holds the status of folder reading. It can be one of:<br/>- FolderTreeModel.Null - no folder has been set<br/>- FolderTreeModel.Ready - the folder has been loaded<br/>- FolderTreeModel.Loading - the folder is currently being loaded |

### Readonly Properties

| Property             | Type     | Description                                                  |
| -------------------- | -------- | ------------------------------------------------------------ |
| fileName             | `string` | Returns the name of the file, excluding the path.            |
| filePath             | `string` | Returns the file name, including the path (which is absolute). |
| fileBaseName         | `string` | Returns the base name of the file without the path.<br/>The base name consists of all characters in the file up to (but not including) the first '.' character.<br/>Example : "/tmp/archive.tar.gz" baseName is "archive"<br/>The base name of a file is computed equally on all platforms, independent of file naming conventions (e.g., ".bashrc" on Unix has an empty base name, and the suffix is "bashrc"). |
| fileCompleteBaseName | `string` | Returns the complete base name of the file without the path.<br/>The complete base name consists of all characters in the file up to (but not including) the last '.' character.<br/>Example : "/tmp/archive.tar.gz" baseName is "archive.tar" |
| fileSuffix           | `string` | Returns the suffix (extension) of the file.<br/>The suffix consists of all characters in the file after (but not including) the last '.'.<br/>Example : "/tmp/archive.tar.gz" return "gz"<br/>The suffix of a file is computed equally on all platforms, independent of file naming conventions (e.g., ".bashrc" on Unix has an empty base name, and the suffix is "bashrc"). |
| fileCompleteSuffix   | `string` | Returns the complete suffix (extension) of the file.<br/>The complete suffix consists of all characters in the file after(but not including) the first '.'.<br/>Example : "/tmp/archive.tar.gz" return "tar.gz" |
| fileSize             | `int64`  | Returns the file size in bytes. If the file does not exist or cannot be fetched, 0 is returned.<br/>If the file is a symlink, the size of the target file is returned (not the symlink). |
| fileModified         | `date`   | Returns the date and local time when the file was last modified.<br/>If the file is a symlink, the time of the target file is returned (not the symlink). |
| fileAccessed         | `date`   | Returns the date and local time when the file was last read (accessed).<br/>On platforms where this information is not available, returns the same as fileModified().<br/>If the file is a symlink, the time of the target file is returned (not the symlink). |
| fileIsDir            | `bool`   | Returns true if this object points to a directory or to a symbolic link to a directory; otherwise returns false.<br/>If the file is a symlink, this function returns true if the target is a directory (not the symlink). |

### Api

By default the model isn't populated, it's up to the user to explicitly call `fetch`.

> Warning : For now the code is only run in main thread. This will result in ui freeze.

## FolderTreeView

FolderTreeView provide a `TreeView` ready to explore a folder and subfolder. The default itemDelegate is a `FolderTreeViewItem`.

[QaterialOnline](https://tinyurl.com/y2sg6xp3)