import QtQuick 2.12
import QtQuick.Controls 2.12

/**
 * This item is a delegate container that contain a normal and a checked Delegate
 * This object needs to be inside a CheckableListView
 */
Item
{
    id: root

    implicitHeight: root.ListView.view.checkBoxEnabled ? (checkLoader.item ? checkLoader.item.implicitHeight : 0) : (defaultLoader.item ? defaultLoader.item.implicitHeight : 0)

    signal clicked()

    /** If the delegate is checked */
    property bool checked: false
    property alias defaultDelegate: defaultLoader.sourceComponent
    property alias checkDelegate: checkLoader.sourceComponent

    Component.onCompleted: updateCheckFromList()

    /** Enable the checkbox into the checkableListView */
    function enableCheckBox()
    {
        ListView.view.checkBoxEnabled = true
        ListView.view.checkItem(index)
    }

    function updateCheckFromList()
    {
        if(root.ListView.view.checkBoxEnabled)
        {
            var newChecked = root.ListView.view.isChecked(index)
            if(newChecked !== root.checked)
                root.checked = newChecked
        }       
    }

    /** Uncheck to be sure next time it is checked it will be uncheck or check */
    Connections
    {
        target: root.ListView.view
        onCheckBoxEnabledChanged:
        {
            if(!root.ListView.view.checkBoxEnabled && root.checked)
                root.checked = false
        }

        onCheckedItemCounterChanged: updateCheckFromList()
    }

    Loader
    {
        id: defaultLoader
        anchors.fill: parent
        visible: !root.ListView.view.checkBoxEnabled
    }
    Loader
    {
        id: checkLoader
        anchors.fill: parent
        visible: root.ListView.view.checkBoxEnabled
    }
}