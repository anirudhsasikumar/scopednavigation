/*
* The contents of this file are subject to the Mozilla Public License Version
* 1.1 (the "License"); you may not use this file except in compliance with
* the License. You may obtain a copy of the License at
* http://www.mozilla.org/MPL/
*
* Software distributed under the License is distributed on an "AS IS" basis,
* WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
* for the specific language governing rights and limitations under the
* License.
*
* The Original Code is the ScopedNavigation component.
*
* The Initial Developer of the Original Code is
* Anirudh Sasikumar (http://anirudhs.chaosnet.org/).
* Portions created by the Initial Developer are Copyright (C) 2008
* the Initial Developer. All Rights Reserved.
*
* Contributor(s):
*
*/
	
package net.anirudh.controls
{
	import flash.events.MouseEvent;
	
	import mx.core.IVisualElement;
	import mx.core.mx_internal;
	
	import spark.components.DropDownList;
	import spark.components.IItemRenderer;
	
	use namespace mx_internal;
	
	/* Hacks DropDownList to avoid closing the drop down when 
	   stayOpen is true. This is done by intercepting the list
	  selection and the controller closeDropDown function.*/
	public class ScopedDropDown extends DropDownList
	{
		private var _stayOpen:Boolean;
		
	
		public function ScopedDropDown()
		{
			super();
			dropDownController = new ScopedDropDownController();
		}
		
	
		public function get stayOpen():Boolean
		{
			return _stayOpen;
		}

		public function set stayOpen(value:Boolean):void
		{
			_stayOpen = value;
			dropDownController['stayOpen'] = _stayOpen;
		}

		/**
		 *  @private
		 *  Returns true if v is null or an empty Vector.
		 */
		private function isEmpty(v:Vector.<int>):Boolean
		{
			return v == null || v.length == 0;
		}
		
		private function calculateSelectedIndicesInterval(renderer:IVisualElement, shiftKey:Boolean, ctrlKey:Boolean):Vector.<int>
		{
			var i:int; 
			var interval:Vector.<int> = new Vector.<int>();  
			var index:Number = dataGroup.getElementIndex(renderer); 
			
			if (!shiftKey)
			{
				if (ctrlKey)
				{
					if (!isEmpty(selectedIndices))
					{
						// Quick check to see if selectedIndices had only one selected item
						// and that item was de-selected
						if (selectedIndices.length == 1 && (selectedIndices[0] == index))
						{
							// We need to respect requireSelection 
							if (!requireSelection)
								return interval; 
							else 
							{
								interval.splice(0, 0, selectedIndices[0]); 
								return interval; 
							}
						}
						else
						{
							// Go through and see if the index passed in was in the 
							// selection model. If so, leave it out when constructing
							// the new interval so it is de-selected. 
							var found:Boolean = false; 
							for (i = 0; i < selectedIndices.length; i++)
							{
								if (selectedIndices[i] == index)
									found = true; 
								else if (selectedIndices[i] != index)
									interval.splice(0, 0, selectedIndices[i]);
							}
							if (!found)
							{
								// Nothing from the selection model was de-selected. 
								// Instead, the Ctrl key was held down and we're doing a  
								// new add. 
								interval.splice(0, 0, index);   
							}
							return interval; 
						} 
					}
						// Ctrl+click with no previously selected items 
					else
					{ 
						interval.splice(0, 0, index); 
						return interval; 
					}
				}
					// A single item was newly selected, add that to the selection interval.  
				else 
				{ 
					interval.splice(0, 0, index); 
					return interval; 
				}
			}
			else // shiftKey
			{
				// A contiguous selection action has occurred. Figure out which new 
				// indices to add to the selection interval and return that. 
				var start:int = (!isEmpty(selectedIndices)) ? selectedIndices[0] : 0; 
				var end:int = index; 
				if (start < end)
				{
					for (i = start; i <= end; i++)
					{
						interval.splice(0, 0, i); 
					}
				}
				else 
				{
					for (i = start; i >= end; i--)
					{
						interval.splice(0, 0, i); 
					}
				}
				return interval; 
			}
		}
		
		override protected function item_mouseDownHandler(event:MouseEvent):void
		{
			//super.item_clickHandler(event);
			var newIndex:Number; 
			
			if (!allowMultipleSelection)
			{
				// Single selection case, set the selectedIndex 
				newIndex = dataGroup.getElementIndex(event.currentTarget as IVisualElement);  
				
				var currentRenderer:IItemRenderer;
				if (caretIndex >= 0)
				{
					currentRenderer = dataGroup.getElementAt(caretIndex) as IItemRenderer;
					if (currentRenderer)
						currentRenderer.showsCaret = false;
				}
				
				// Check to see if we're deselecting the currently selected item 
				if (event.ctrlKey && selectedIndex == newIndex)
					selectedIndex = NO_SELECTION;
					// Otherwise, select the new item 
				else
					selectedIndex = newIndex;
			}
			else 
			{
				// Multiple selection is handled by the helper method below				
				selectedIndices = calculateSelectedIndicesInterval(event.currentTarget as IVisualElement, event.shiftKey, event.ctrlKey); 
			}
			userProposedSelectedIndex = selectedIndex;
			if ( !stayOpen )
			{
				closeDropDown(true);
			}
			
		}
		
		override public function closeDropDown(commit:Boolean):void
		{
			if ( !stayOpen )
			{
				super.closeDropDown(commit);
			}
		}
		
	}
}