import QtQuick 2.12
import QtQml 2.14
import Qaterial 1.0 as Qaterial

Row
{
  id: root
  property real value

  Behavior on value
  {
    NumberAnimation { duration: 1000 }
  }

  Timer
  {
    interval: 1500;running: true;repeat: true
    onTriggered: function()
    {
      value = value ? 0 : 1
    }
  }

  Qaterial.Slider
  {
    id: slider1
    Binding on value { when: !slider1.pressed;value: root.value;restoreMode: Binding.RestoreBindingOrValue }
    orientation: Qt.Vertical
    color: Qaterial.Style.purple
  }
  Qaterial.Slider
  {
    id: slider2
    Binding on value { when: !slider2.pressed;value: root.value;restoreMode: Binding.RestoreBindingOrValue }
    orientation: Qt.Vertical
    height: 250
    color: Qaterial.Style.pink
  }
  Qaterial.Slider
  {
    id: slider3
    Binding on value { when: !slider3.pressed;value: root.value;restoreMode: Binding.RestoreBindingOrValue }
    orientation: Qt.Vertical
    height: 300
    color: Qaterial.Style.red
  }

  Column
  {
    Qaterial.Slider
    {
      id: slider4
      Binding on value { when: !slider4.pressed;value: root.value;restoreMode: Binding.RestoreBindingOrValue }
      color: Qaterial.Style.deepOrange
    }
    Qaterial.Slider
    {
      id: slider5
      Binding on value { when: !slider5.pressed;value: root.value;restoreMode: Binding.RestoreBindingOrValue }
      width: 300
      color: Qaterial.Style.orange
    }
    Qaterial.Slider
    {
      id: slider6
      Binding on value { when: !slider6.pressed;value: root.value;restoreMode: Binding.RestoreBindingOrValue }
      width: 400
      color: Qaterial.Style.amber
    }
    Qaterial.RangeSlider
    {
      id: rangeSlider1
      Binding on first.value
      {
        when: !rangeSlider1.pressed;value: root.value / 2;restoreMode: Binding
          .RestoreBindingOrValue
      }
      Binding on second.value
      {
        when: !rangeSlider1.pressed;value: 1 - root.value / 2;restoreMode: Binding
          .RestoreBindingOrValue
      }
      color: Qaterial.Style.yellow
    }
    Qaterial.RangeSlider
    {
      id: rangeSlider2
      Binding on first.value
      {
        when: !rangeSlider2.pressed;value: root.value / 2;restoreMode: Binding
          .RestoreBindingOrValue
      }
      Binding on second.value
      {
        when: !rangeSlider2.pressed;value: 1 - root.value / 2;restoreMode: Binding
          .RestoreBindingOrValue
      }
      width: 300
      color: Qaterial.Style.lime
    }
    Qaterial.RangeSlider
    {
      id: rangeSlider3
      Binding on first.value
      {
        when: !rangeSlider3.pressed;value: root.value / 2;restoreMode: Binding
          .RestoreBindingOrValue
      }
      Binding on second.value
      {
        when: !rangeSlider3.pressed;value: 1 - root.value / 2;restoreMode: Binding
          .RestoreBindingOrValue
      }
      width: 400
      color: Qaterial.Style.green
    }
  }
  Qaterial.RangeSlider
  {
    id: rangeSlider4
    Binding on first.value
    {
      when: !rangeSlider3.pressed;value: root.value / 2;restoreMode: Binding
        .RestoreBindingOrValue
    }
    Binding on second.value
    {
      when: !rangeSlider3.pressed;value: 1 - root.value / 2;restoreMode: Binding
        .RestoreBindingOrValue
    }
    orientation: Qt.Vertical
    height: 300
    color: Qaterial.Style.blue
  }
  Qaterial.RangeSlider
  {
    id: rangeSlider5
    Binding on first.value
    {
      when: !rangeSlider5.pressed;value: root.value / 2;restoreMode: Binding
        .RestoreBindingOrValue
    }
    Binding on second.value
    {
      when: !rangeSlider5.pressed;value: 1 - root.value / 2;restoreMode: Binding
        .RestoreBindingOrValue
    }
    orientation: Qt.Vertical
    height: 250
    color: Qaterial.Style.indigo
  }
  Qaterial.RangeSlider
  {
    id: rangeSlider6
    Binding on first.value
    {
      when: !rangeSlider6.pressed;value: root.value / 2;restoreMode: Binding
        .RestoreBindingOrValue
    }
    Binding on second.value
    {
      when: !rangeSlider6.pressed;value: 1 - root.value / 2;restoreMode: Binding
        .RestoreBindingOrValue
    }
    orientation: Qt.Vertical
    color: Qaterial.Style.deepPurple
  }

  Component.onCompleted: value = 1
}
