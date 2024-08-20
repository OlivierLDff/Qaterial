---
layout: default
title: 💦 Splash Screen
---

# 💦 Splash Screen

![splash](https://user-images.githubusercontent.com/17255804/88462135-58a19200-cea9-11ea-9d4d-23c0a5ef7f62.gif)

A **splash screen** is a [graphical control element](https://en.wikipedia.org/wiki/Graphical_control_element) consisting of a [window](https://en.wikipedia.org/wiki/Window_(computing)) containing an [image](https://en.wikipedia.org/wiki/Image), a logo, and the current version of the software. A splash screen usually appears while a game or program is launching. A **splash page** is an introduction page on a [website](https://en.wikipedia.org/wiki/Website). A splash screen may cover the entire [screen](https://en.wikipedia.org/wiki/Computer_screen) or web page; or may simply be a rectangle near the center of the screen or page. The splash screens of [operating systems](https://en.wikipedia.org/wiki/Operating_systems) and some applications that expect to be run in full screen usually cover the entire screen.

## SplashScreen

The `SplashScreen` component contain an `image`, a `text` and a `version` string. Loading is shown with a `ProgressBar`, and can be controlled with `from`, `to`, `value`, `indeterminate`.

It is based on `Rectangle`.

```js
import Qaterial as Qaterial

Qaterial.SplashScreen
{
  width: 480
  height: 270
  image: "https://cdn.pixabay.com/photo/2018/11/14/20/50/hd-3816045_960_720.jpg"

  text: "Loading ..."
  version: Qaterial.Version.readable
}
```

## SplashScreenWindow

A `SplashScreenWindow` is a `Window` showing a `SplashScreen`. It has special flags to appear as a Splash Screen on most Os.

The `SplashScreenWindow`  turn visible as soon as the window finished to load.

## How to show SplashScreen then ApplicationWindow

The easiest way to show a SplashScreen then your main application is to use `SplashScreenApplication`.

```js
import QtQuick
import Qaterial as Qaterial

Qaterial.SplashScreenApplication
{
  splashScreen: Qaterial.SplashScreenWindow { }
  window: Qaterial.ApplicationWindow { Component.onCompleted: () => visible = true }
}
```

A more advance example can be found in `Main.qml` of `tools/HotReload/app/qml/Main.qml`.
