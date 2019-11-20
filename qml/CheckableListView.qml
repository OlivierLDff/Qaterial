/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

ListView
{
	id: root
	/** Indicate if delegates need to appear as checkable or not */
	property bool checkBoxEnabled: false
	/** Array that store every checked delegate and in which order
	 * This list is reset when any data is added, moved or deleted from the model
	 * To ensure index are always valid */
	property var checkedItemIndexes: []
	/** How many delegates are checked */
	property int checkedItemCounter: 0
	/** Maximum number of delegate that can be checked (ie size of model) */
	readonly property int maxCheckedItemCounter: count

	function updateCheckedItemCounter() { checkedItemCounter = checkedItemIndexes.length }

	/** Check all the model item */
	function checkAllItem()
	{
		// 1) Clear the index array
		uncheckAllItem()

		// 2) Then add each object into the array
		for(var i = 0; i < model.rowCount(); ++i)
			checkedItemIndexes.push(i)

		updateCheckedItemCounter()
	}

	Shortcut
	{
		enabled: root.checkBoxEnabled
	    sequence: "Escape"
	    onActivated: root.checkBoxEnabled = false
	}

	/** Uncheck all of the item */
	function uncheckAllItem()
	{
		// 1) Clear the index array
		checkedItemIndexes = []
		updateCheckedItemCounter()
	}

	/** Push the index to the list of checked item. If the item is already
	 * checked it will be unchecked and rechecked at the end of the array to keep the
	 * order of checked actions */
	function checkItem(index)
	{
		// 1) Uncheck the item to be sure the index is at the end
		uncheckItem(index)

		// 2) Simply push the item at the end of the list
		checkedItemIndexes.push(index)
		updateCheckedItemCounter()
	}

	/** Uncheck an index from the list */
	function uncheckItem(index)
	{
		//console.log("uncheckItem " + index)
		// 1) Check if the item is present
		var indexOfItem = checkedItemIndexes.indexOf(index)

		// 2) The item is present so we need to remove it
		if(indexOfItem >= 0)
		{
			checkedItemIndexes.splice(indexOfItem, 1)
			updateCheckedItemCounter()
		}
	}

	/** Delete in the model all checked item */
	function deleteCheckedItem()
	{
		var objectToRemove = []
		for(var i = 0; i < checkedItemIndexes.length; ++i)
		{
			objectToRemove.push(model.get(checkedItemIndexes[i]))
			//console.log(checkedItemIndexes[i])
			//console.log(model.get(checkedItemIndexes[i]))
			//console.log(model.get(checkedItemIndexes[i]).qtObject)
		}
		for(var i = 0; i < objectToRemove.length; ++i)
		{
			model.remove(objectToRemove[i])
		}
		checkBoxEnabled = false
	}

	function isChecked(index)
	{
		return checkedItemIndexes.indexOf(index) >= 0
	}

	Connections
	{
		target: root.model
		onRowsAboutToBeInserted: root.uncheckAllItem()
		onRowsAboutToBeMoved: root.uncheckAllItem()
		onRowsAboutToBeRemoved: root.uncheckAllItem()
	}
	onCheckBoxEnabledChanged: uncheckAllItem()
}
