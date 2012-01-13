// Feel free to use this code in any way you see fit
// www.warmforestflash.com
// Anirudh Sasikumar: Made it a GraphicElement so that Flex 4 can use it.
package com.warmforestflash.drawing
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import spark.primitives.supportClasses.GraphicElement;

;
	
	public class DottedLine extends GraphicElement
	{
		private var _w:Number;
		private var _h:Number;
		private var _color:uint;
		private var _colorChanged:Boolean;
		private var _argb:uint = 0;
		private var _dotAlpha:Number;
		private var _dotWidth:Number;
		private var _spacing:Number;
				
		//0x969696
		//============================================================================================================================
		public function DottedLine(w:Number = 100, h:Number = 1, color:uint = 0x000000, dotAlpha:Number = 1, dotWidth:Number = 1, spacing:Number = 1)
			//============================================================================================================================
		{
			_w = w;
			_h = h;
			_color = color;
			this.alpha = dotAlpha;
			_dotWidth = dotWidth;
			_spacing = spacing;
			//drawDottedLine();
		}
		
		//============================================================================================================================

		public function get dotAlpha():Number
		{
			return _dotAlpha;
		}

		public function set dotAlpha(value:Number):void
		{
			if ( _dotAlpha != value )
			{
				_dotAlpha = value;
				this.alpha = _dotAlpha;
			}
		}

		public function get color():uint
		{
			return _color;
		}

		public function set color(value:uint):void
		{
			if ( _color != value )
			{
				_color = value;
				_colorChanged = true;
				invalidateProperties();
			}
		}
		
		override protected function commitProperties() : void
		{
			super.commitProperties();
			if ( _colorChanged )
			{
				_colorChanged = false;
				//trace("changed color");
				_argb = returnARGB(_color, 255);
				invalidateDisplayList();
			}
		}

		private function drawDottedLine(graphics:Graphics):void
			//============================================================================================================================
		{
			//graphics.clear();
			var tile:BitmapData = new BitmapData(_dotWidth + _spacing, _h + 1, true);
			var r1:Rectangle = new Rectangle(0, 0, _dotWidth, _h);
			if ( _argb == 0 )
				_argb = returnARGB(_color, 255);
			tile.fillRect(r1, _argb);
			var r2:Rectangle = new Rectangle(_dotWidth, 0, _dotWidth + _spacing, _h);
			tile.fillRect(r2, 0x00000000);
			graphics.beginBitmapFill(tile, null, true);
			graphics.drawRect(0, 0, _w, _h);
			graphics.endFill();
		}
		
		
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			if (!drawnDisplayObject || !(drawnDisplayObject is Sprite))
				return;
			//trace("drawing dotted line");
			// The base GraphicElement class has cleared the graphics for us.    
			var g:Graphics = (drawnDisplayObject as Sprite).graphics;
			_w = unscaledWidth;
			_h = unscaledHeight;
			drawDottedLine(g);
		}
		
		//============================================================================================================================
		private function returnARGB(rgb:uint, newAlpha:uint):uint
			//============================================================================================================================
		{
			var argb:uint = 0;
			argb += (newAlpha<<24);
			argb += (rgb);
			return argb;
		}
		
	}
}