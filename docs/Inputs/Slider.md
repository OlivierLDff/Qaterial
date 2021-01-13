---
layout: default
title: 🎚️ Slider
---

# 🎚️ Slider

![sliderhandleorientation](https://user-images.githubusercontent.com/17255804/86527361-74afa600-be9e-11ea-8c1b-f1ffb4b32b34.gif)

##  Slider

`Slider` is used to select a value by sliding a handle along a track.

In the example below, custom [from](https://doc.qt.io/qt-5/qml-qtquick-controls2-slider.html#from-prop), [value](https://doc.qt.io/qt-5/qml-qtquick-controls2-slider.html#value-prop), and [to](https://doc.qt.io/qt-5/qml-qtquick-controls2-slider.html#to-prop) values are set:

```js
Slider
{
  from: 1
  value: 25
  to: 100
  orientation: Qt.Vertical // or Qt.Horizontal
}
```

The [position](https://doc.qt.io/qt-5/qml-qtquick-controls2-slider.html#position-prop) property is expressed as a fraction of the control's size, in the range `0.0 - 1.0`. The [visualPosition](https://doc.qt.io/qt-5/qml-qtquick-controls2-slider.html#visualPosition-prop) property is the same, except that it is reversed in a [right-to-left](https://doc.qt.io/qt-5/qtquick-positioning-righttoleft.html) application. The [visualPosition](https://doc.qt.io/qt-5/qml-qtquick-controls2-slider.html#visualPosition-prop) is useful for positioning the handle when styling Slider. In the example above, [visualPosition](https://doc.qt.io/qt-5/qml-qtquick-controls2-slider.html#visualPosition-prop) will be `0.24` in a left-to-right application, and `0.76` in a right-to-left application.

### Continuous Slider

![continousSlider](https://user-images.githubusercontent.com/17255804/86528037-c1967b00-bea4-11ea-8a86-ff618c0739d1.gif)

[QaterialOnline](https://tinyurl.com/y8rklqz8)

### Discrete Slider

*todo*

### Custom Mark

*todo*

### ToolTip

*todo*

### Inverted Track

*todo*

### Customized Slider

#### Large Slider

`LargeSlider` is a built in `Slider` variant. The Large slider background scale to the height/width of the Slider. The handle also scale to follow the height/width.

![largeSlider](https://user-images.githubusercontent.com/17255804/86570596-73e74480-bf70-11ea-9bd7-8eed399da591.gif)

* `radius`: Radius of the background
* `handleSize`: control the width of the handle in `Qt.Vertical` or height of the handle in `Qt.Horizontal`
* `handleRadius`: Radius of the handle
* `handleBorderColor`: Border color of the handle
* `inlineBorderWidth`: Width between external and inline rectangle (then one that indicate where value is.

```js
LargeSlider
{
  from: 1
  value: 25
  to: 100
  orientation: Qt.Vertical // or Qt.Horizontal
}
```

#### Gradient Slider

`GradientSlider` is based on `LargeSlider`. It have an additional `gradient` property the will come on the fader. By default the background is `transparent`.

![gradientSlider](https://user-images.githubusercontent.com/17255804/86573433-b0b53a80-bf74-11ea-9dad-c26485381bc8.gif)

The gradient will be embedded inside a [LinearGradient](https://doc.qt.io/qt-5/qml-qtgraphicaleffects-lineargradient.html).

```js

Qaterial.GradientSlider
{
  // color of the handle
  color: Qaterial.Style.teal

  from: 1
  value: 25
  to: 100
  orientation: Qt.Vertical // or Qt.Horizontal

  // Rainbow Gradient
  gradient: Gradient
  {
    GradientStop {
       position: 0.000
       color: Qt.rgba(1, 0, 0, 1)
    }
    GradientStop {
       position: 0.167
       color: Qt.rgba(1, 1, 0, 1)
    }
    GradientStop {
       position: 0.333
       color: Qt.rgba(0, 1, 0, 1)
    }
    GradientStop {
       position: 0.500
       color: Qt.rgba(0, 1, 1, 1)
    }
    GradientStop {
       position: 0.667
       color: Qt.rgba(0, 0, 1, 1)
    }
    GradientStop {
       position: 0.833
       color: Qt.rgba(1, 0, 1, 1)
    }
    GradientStop {
       position: 1.000
       color: Qt.rgba(1, 0, 0, 1)
    }
  }
}
```

#### Flat Slider

*todo*

#### Flat Gradient Slider

*todo*

## Range Slider

`RangeSlider` is used to select a range specified by two values, by sliding each handle along a track.

In the example below, custom [from](https://doc.qt.io/qt-5/qml-qtquick-controls2-rangeslider.html#from-prop) and [to](https://doc.qt.io/qt-5/qml-qtquick-controls2-rangeslider.html#to-prop) values are set, and the initial positions of the [first](https://doc.qt.io/qt-5/qml-qtquick-controls2-rangeslider.html#first-prop) and [second](https://doc.qt.io/qt-5/qml-qtquick-controls2-rangeslider.html#second-prop) handles are set:

```js
RangeSlider
{
  from: 1
  to: 100
  first.value: 25
  second.value: 75
}
```

In order to perform an action when the value for a particular handle changes, use the following syntax:

```
first.onMoved: console.log("first.value changed to " + first.value)
```

The [first.position](https://doc.qt.io/qt-5/qml-qtquick-controls2-rangeslider.html#first.position-prop) and [second.position](https://doc.qt.io/qt-5/qml-qtquick-controls2-rangeslider.html#second.position-prop) properties are expressed as fractions of the control's size, in the range `0.0 - 1.0`. The [first.visualPosition](https://doc.qt.io/qt-5/qml-qtquick-controls2-rangeslider.html#first.visualPosition-prop) and [second.visualPosition](https://doc.qt.io/qt-5/qml-qtquick-controls2-rangeslider.html#second.visualPosition-prop) properties are the same, except that they are reversed in a [right-to-left](https://doc.qt.io/qt-5/qtquick-positioning-righttoleft.html) application. The `visualPosition` is useful for positioning the handles when styling RangeSlider. In the example above, [first.visualPosition](https://doc.qt.io/qt-5/qml-qtquick-controls2-rangeslider.html#first.visualPosition-prop) will be `0.24` in a left-to-right application, and `0.76` in a right-to-left application.

### Inverted Track

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