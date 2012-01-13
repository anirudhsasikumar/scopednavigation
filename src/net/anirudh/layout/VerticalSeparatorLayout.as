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

package net.anirudh.layout
{
	import spark.components.supportClasses.GroupBase;
	import spark.layouts.VerticalLayout;
	

	
	public class VerticalSeparatorLayout extends VerticalLayout
	{
		private var _cachedItem:Object;
		
		public function VerticalSeparatorLayout()
		{
			super();
		}
		
		
		override public function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			if ( _cachedItem )
			{
				_cachedItem.visible = true;
				_cachedItem = null;
			}
			
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			var layoutTarget:GroupBase = target; 
			if (!layoutTarget)
				return;
			
			var count:uint = layoutTarget.numElements;
			
			if ((count == 0) || (unscaledWidth == 0) || (unscaledHeight == 0))
			{
			
				return;         
			}
			
			var rend: Object = layoutTarget.getElementAt(count - 1);
			
			if ( rend.hasOwnProperty("separator") )
			{
				rend["separator"].visible = false;
				_cachedItem = rend;
			}
		}
	}
}
