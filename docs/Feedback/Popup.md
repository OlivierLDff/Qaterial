---
layout: default
title: 🗨️ Popup
---

# 🗨️ Popup

## Popup Menu

Display a popup with a little arrow pointing to the origin.
It should be opened with the `openAt(origin, transformOrigin)` function.
* transformOrigin can be any of `Item.Top`, `Item.Bottom`, `Item.Right`, `Item.Left`.
* origin must be the coordinate of the origin in `Overlay`. You should use the function `mapToItem(Overlay.overlay, x, y)` to get the origin.

![popupmenu](https://user-images.githubusercontent.com/17255804/93909825-81ef6a80-fd00-11ea-96fb-14fe1ee6a579.gif)

### Popup Menu Item

Dedicated Button for popup menu.

![popupmenuitem](https://user-images.githubusercontent.com/17255804/93981917-de926a00-fd80-11ea-8de2-9160e69f422c.gif)
