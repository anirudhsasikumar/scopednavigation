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
	import spark.components.supportClasses.DropDownController;
	
	public class ScopedDropDownController extends DropDownController
	{
		public var stayOpen:Boolean;
		
		public function ScopedDropDownController()
		{
			super();
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