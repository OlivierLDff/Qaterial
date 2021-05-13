import QtQuick 2.15
import QtQuick.Layouts 1.15
import Qaterial 1.0 as Qaterial

ColumnLayout
{
  Qaterial.Slider
  {
    id: slider
    Layout.fillWidth: true

    from: 0
    to: 16
    stepSize: 1
  }

  RowLayout
  {
    Layout.fillWidth: true

    Qaterial.LabelWithCaption
    {
      Layout.preferredWidth: 100
      spacing: slider.value

      text: "Title"
      caption: "Caption"
      maximumLineCount: 1
      wrapMode: Text.WordWrap

      Qaterial.DebugRectangle { anchors.fill: parent }
    }

    Qaterial.LabelWithCaption
    {
      Layout.preferredWidth: 100
      spacing: slider.value

      text: "Long title that should be elided"
      caption: "Caption that should be elided"
      maximumLineCount: 1
      wrapMode: Text.WordWrap

      Qaterial.DebugRectangle { anchors.fill: parent }
    }

    Qaterial.LabelWithCaption
    {
      Layout.preferredWidth: 100
      spacing: slider.value

      text: "Long title that should be elided"
      caption: "Caption with 2 line too long so elided"
      maximumLineCount: 2
      wrapMode: Text.WordWrap

      Qaterial.DebugRectangle { anchors.fill: parent }
    }
  }

  Qaterial.LabelWithCaption
  {
    spacing: slider.value
    Layout.fillWidth: true

    text: "Text only"
    maximumLineCount: 1
    wrapMode: Text.WordWrap

    Qaterial.DebugRectangle { anchors.fill: parent }
  }

  Qaterial.LabelWithCaption
  {
    spacing: slider.value
    Layout.fillWidth: true

    caption: "Caption only"
    maximumLineCount: 1
    wrapMode: Text.WordWrap

    Qaterial.DebugRectangle { anchors.fill: parent }
  }

  RowLayout
  {
    Layout.fillWidth: true

    Qaterial.LabelWithCaption
    {
      spacing: slider.value
      implicitWidth: 150
      Layout.preferredHeight: 56

      text: "AlignLeft"
      caption: "AlignLeft"
      horizontalAlignment: Text.AlignLeft

      Qaterial.DebugRectangle { anchors.fill: parent }
    }

    Qaterial.LabelWithCaption
    {
      spacing: slider.value
      implicitWidth: 150
      Layout.preferredHeight: 56

      text: "AlignLeft"
      horizontalAlignment: Text.AlignLeft

      Qaterial.DebugRectangle { anchors.fill: parent }
    }

    Qaterial.LabelWithCaption
    {
      spacing: slider.value
      implicitWidth: 150
      Layout.preferredHeight: 56

      caption: "AlignLeft"
      horizontalAlignment: Text.AlignLeft

      Qaterial.DebugRectangle { anchors.fill: parent }
    }
  }

  RowLayout
  {
    Layout.fillWidth: true

    Qaterial.LabelWithCaption
    {
      spacing: slider.value
      implicitWidth: 150
      Layout.preferredHeight: 56

      text: "AlignHCenter"
      caption: "AlignHCenter"
      horizontalAlignment: Text.AlignHCenter

      Qaterial.DebugRectangle { anchors.fill: parent }
    }

    Qaterial.LabelWithCaption
    {
      spacing: slider.value
      implicitWidth: 150
      Layout.preferredHeight: 56

      text: "AlignHCenter"
      horizontalAlignment: Text.AlignHCenter

      Qaterial.DebugRectangle { anchors.fill: parent }
    }

    Qaterial.LabelWithCaption
    {
      spacing: slider.value
      implicitWidth: 150
      Layout.preferredHeight: 56

      caption: "AlignHCenter"
      horizontalAlignment: Text.AlignHCenter

      Qaterial.DebugRectangle { anchors.fill: parent }
    }
  }

  RowLayout
  {
    Layout.fillWidth: true

    Qaterial.LabelWithCaption
    {
      spacing: slider.value
      implicitWidth: 150
      Layout.preferredHeight: 56

      text: "AlignRight"
      caption: "AlignRight"
      horizontalAlignment: Text.AlignRight

      Qaterial.DebugRectangle { anchors.fill: parent }
    }

    Qaterial.LabelWithCaption
    {
      spacing: slider.value
      implicitWidth: 150
      Layout.preferredHeight: 56

      text: "AlignRight"
      horizontalAlignment: Text.AlignRight

      Qaterial.DebugRectangle { anchors.fill: parent }
    }

    Qaterial.LabelWithCaption
    {
      spacing: slider.value
      implicitWidth: 150
      Layout.preferredHeight: 56

      caption: "AlignRight"
      horizontalAlignment: Text.AlignRight

      Qaterial.DebugRectangle { anchors.fill: parent }
    }
  }

  RowLayout
  {
    Layout.fillWidth: true

    Qaterial.LabelWithCaption
    {
      spacing: slider.value
      implicitWidth: 150
      Layout.preferredHeight: 56

      text: "AlignTop"
      caption: "AlignTop"
      verticalAlignment: Text.AlignTop

      Qaterial.DebugRectangle { anchors.fill: parent }
    }

    Qaterial.LabelWithCaption
    {
      spacing: slider.value
      implicitWidth: 150
      Layout.preferredHeight: 56

      text: "AlignTop"
      verticalAlignment: Text.AlignTop

      Qaterial.DebugRectangle { anchors.fill: parent }
    }

    Qaterial.LabelWithCaption
    {
      spacing: slider.value
      implicitWidth: 150
      Layout.preferredHeight: 56

      caption: "AlignTop"
      verticalAlignment: Text.AlignTop

      Qaterial.DebugRectangle { anchors.fill: parent }
    }
  }

  RowLayout
  {
    Layout.fillWidth: true

    Qaterial.LabelWithCaption
    {
      spacing: slider.value
      implicitWidth: 150
      Layout.preferredHeight: 56

      text: "AlignVCenter"
      caption: "AlignVCenter"
      verticalAlignment: Text.AlignVCenter

      Qaterial.DebugRectangle { anchors.fill: parent }
    }

    Qaterial.LabelWithCaption
    {
      spacing: slider.value
      implicitWidth: 150
      Layout.preferredHeight: 56

      text: "AlignVCenter"
      verticalAlignment: Text.AlignVCenter

      Qaterial.DebugRectangle { anchors.fill: parent }
    }

    Qaterial.LabelWithCaption
    {
      spacing: slider.value
      implicitWidth: 150
      Layout.preferredHeight: 56

      caption: "AlignVCenter"
      verticalAlignment: Text.AlignVCenter

      Qaterial.DebugRectangle { anchors.fill: parent }
    }
  }

  RowLayout
  {
    Layout.fillWidth: true

    Qaterial.LabelWithCaption
    {
      spacing: slider.value
      implicitWidth: 150
      Layout.preferredHeight: 56

      text: "AlignBottom"
      caption: "AlignBottom"
      verticalAlignment: Text.AlignBottom

      Qaterial.DebugRectangle { anchors.fill: parent }
    }

    Qaterial.LabelWithCaption
    {
      spacing: slider.value
      implicitWidth: 150
      Layout.preferredHeight: 56

      text: "AlignBottom"
      verticalAlignment: Text.AlignBottom

      Qaterial.DebugRectangle { anchors.fill: parent }
    }

    Qaterial.LabelWithCaption
    {
      spacing: slider.value
      implicitWidth: 150
      Layout.preferredHeight: 56

      caption: "AlignBottom"
      verticalAlignment: Text.AlignBottom

      Qaterial.DebugRectangle { anchors.fill: parent }
    }
  }
}
