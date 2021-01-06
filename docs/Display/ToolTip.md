---
layout: default
title: 💬 ToolTip
---

# 💬 ToolTip

**Tooltips** display informative text when users hover over, focus on, or tap an element.

When activated, **Tooltips** display an element (default: label) such as a description of its function.

### Properties

Inherited from `QtQuick.Templates`, `Qaterial.ToolTip` owns different properties. Most of them come from **Popup** and main others are :

`QtQuick.Templates` properties

- `text`: text shown by the `contentItem` (default: "")
- `delay`: milliseconds before ToolTip apparition (default: 0)
- `timeout`: milliseconds after which the ToolTip is hidden. A ToolTip with a negative timeout does not hide automatically (default: -1)
- `contentItem`: default `Qaterial.Label`
- `background`: default `Rectangle`

`Qaterial` properties :

- `backgroundRadius`: radius of the background Rectangle (default: 4)
- `position`: ToolTip display position (default: on top of parent)

### ✏️ Position

TooltTip `position` property holds from `Qaterial.Style.Position` enum.

17 position are available like TopStart, Top or TopEnd. Check **ToolTips** examples for more details :

![tooltip_position](https://user-images.githubusercontent.com/66482761/86573922-55377c80-bf75-11ea-87ec-da4450c610cb.gif)

Or simply [check it live](https://tinyurl.com/yba5u44x) !



