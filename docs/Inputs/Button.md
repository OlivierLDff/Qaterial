---
layout: default
title: Button
---

# 🔘 Button

Buttons allow users to take actions, and make choices, with a single tap.
Buttons communicate actions that users can take. They are typically placed throughout your UI, in places like:
- Dialogs
- Modal windows
- Forms
- Cards
- Toolbars

By default, the text displayed inside the Component is using `Qaterial.Style.TextType.Buttons`Typography.

## Flat Button

In Qaterial, **FlatButtons** are just Highlighted Text with `Ripple` effect

![FlatButton](https://user-images.githubusercontent.com/51703091/86791643-0b7c8e00-c06a-11ea-9163-866a665f7d81.gif)

## Outlined Button

**OutlineButtons** stand as **FlatButtons** whose area is delimited by a thin line. When clicked `accentRipple` effect is displayed :

![OutlineButton](https://user-images.githubusercontent.com/51703091/86791648-0cadbb00-c06a-11ea-925c-3aab0a96c142.gif)

## Raised Button

**RaisedButtons** are non-flat highlighted Buttons. Which means that their main color is `Qaterial.Style.accentColor`.

![RaisedButton](https://user-images.githubusercontent.com/51703091/86791658-0ddee800-c06a-11ea-9c88-53b70ca2529f.gif)

## Round Button

**RoundButtons** are usually used as Icon Buttons but can also displayed text :

![RoundButton](https://user-images.githubusercontent.com/51703091/86796843-492fe580-c06f-11ea-8b36-baddd9268977.gif)

## App Bar Button

**AppBarButtons** inherit **RoundButtons** but own a smaller padding :

![AppBarButton](https://user-images.githubusercontent.com/51703091/86800012-e3ddf380-c072-11ea-994a-eb4cc71aa735.gif)

## Advanced Use : RawMaterialButton

Every `Qaterial` Buttons are made from this `Component`. Inherited from *QtQuick.Templates* Button it owns some new properties as :

#### Debug Property :

- `drawline`: `bool` allowing to see `Qaterial.DebugRectangle` filling the Button and his background. (default: false)

#### Appearance Properties :

- `outlined`: `bool` changing the appearance, true for `OutlineButton` (default: false)
- `radius`:  background and ripple effect radius (default: 4)
- `elevation`: `double` creating the layer effect : `Qaterial.ElevationEffect` (default: depends on `flat`, `down` and `hovered`)

#### Color Properties :

- `foregroundColor`:  icon's `color`(default: depends on `enabled`, `flat` and `highlighted`)
- `backgroundColor`:  background's `color`  (default: depends on `enabled`, `flat`, `outlined`, `pressed` and `highlighted`)
- `rippleColor`:  Ripple's `color`  (default: depends on `accentRipple` and `flat`)
- `outlinedColor`:  background's border `color` (default: depends on `outlined`, `enabled` and `pressed`)
- `colorReversed`: `bool` which can reverse `foregroundColor`

#### Ripple Properties :

- `clipRipple`:  `bool` enabling Ripple's layer (default: true)
- `forceRipple`: `bool` forcing Ripple's active (default: false)
- `accentRipple`: `bool` changing Ripple's color (default: false)



