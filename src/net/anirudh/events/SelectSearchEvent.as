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

package net.anirudh.events
{
	import flash.events.Event;
	
	public class SelectSearchEvent extends Event
	{
		public static const SEARCH:String = "search";
		public static const SELECT:String = "navselect";
		
		public var searchText:String;
		public var selectedIndex:int;
		public var selectedItem:*;
		
		public function SelectSearchEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, searchText:String="", selectedIndex:int=-1,selectedItem:*=null)
		{
			this.searchText = searchText;
			this.selectedIndex = selectedIndex;
			this.selectedItem = selectedItem;
			super(type, bubbles, cancelable);
			
		}
		
		override public function clone():Event
		{
			return new SelectSearchEvent(type, bubbles, cancelable, searchText, selectedIndex, selectedItem);
		}
	}
}