---
layout: default
title: Slider
---

# Slider

## Slider Handle

![sliderhandle](https://user-images.githubusercontent.com/17255804/86526728-d4ef1980-be97-11ea-9a27-4cb365c7046e.gif)

Qaterial provide an easy to customize handle `SliderHandle` for your slider. It's a `Rectangle` and a `Ripple` that scale when pressed.

The `SliderHandle` is controlled with 4 properties:

* `enabled`: Enabled or disable behavior. When enabled the slider take `color`, other `disableColor` and no border.
* `hasFocus`: Act like hovered in current implementation
* `hovered`: Draw a ripple around the handle
* `pressed`: Do the ripple animation and scale the handle

```js
import Qaterial 1.0 as Qaterial

Qaterial.SliderHandle
{
  enabled: true
  hasFocus: true
  hovered: true
  pressed: root.pressed
}
```

To customize the handle, multiple control exists.

* `size`: If you wish to keep a circular handle, just modify the size
* `width`/`height`: If controlling with width and height, the size doesn't have any effect.
* `radius`: By default a circle. Can be overwritten to have a handle that look  more rectangular.
* `pressedScaleFactor`: Scale factor of the Rectangle when pressed
* `rippleScaleFactor`: Scale factor of the ripple compared to the Rectangle.
* `clipRipple`: Clip the ripple inside the Rectangle. When true it disable `rippleScaleFactor`.

Colors can also be customized:

* `color`: Main color of the handle when enabled
* `disabledColor`: Color of the handle when disabled
* `borderColor`: Color of the border. To take effect you also need to set `borderWidth`.