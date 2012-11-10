package bitrise.core.utils
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;

	public class BitmapUtils
	{
		import flash.display.BitmapData;
		import flash.geom.Matrix;
		import flash.geom.Point;
		import flash.geom.Rectangle;
	
		static public const RESIZE_METHOD_SCALE:String = 'scale';
		static public const RESIZE_METHOD_REPEAT:String = 'repeat';
		
		static public function sliceAndPaste3(source:BitmapData, width:int, x1:int, x2:int, resizeMethod:String = RESIZE_METHOD_SCALE):BitmapData
		{
			return paste3(slice3(source, x1, x2), width, resizeMethod);
		}
		
		static public function slice3(source:BitmapData, x1:int, x2:int):Vector.<BitmapData>
		{
			var result:Vector.<BitmapData> = new Vector.<BitmapData>();
			
			var bitmap:BitmapData;
			
			bitmap = new BitmapData(x1, source.height, true, 0);
			bitmap.copyPixels(source, new Rectangle(0, 0, x1, source.height), new Point());
			result.push(bitmap);
			
			bitmap = new BitmapData(x2 - x1, source.height, true, 0);
			bitmap.copyPixels(source, new Rectangle(x1, 0, x2 - x1, source.height), new Point());
			result.push(bitmap);
			
			bitmap = new BitmapData(x1, source.height, true, 0);
			bitmap.copyPixels(source, new Rectangle(x2, 0, source.width - x2, source.height), new Point());
			result.push(bitmap);
			
			return result;
		}
		
		static public function paste3(source:Vector.<BitmapData>, width:int, resizeMethod:String = RESIZE_METHOD_SCALE):BitmapData
		{
			if(source == null || source.length != 3) 
				throw new Error('Invalid source.');
			
			var result:BitmapData = new BitmapData(width, source[0].height, true, 0);
			
			result.copyPixels(source[0], new Rectangle(0, 0, source[0].width, source[0].height), new Point());
			
			var centerWidth:Number = (width - source[0].width - source[2].width);
			if(centerWidth > 0)
			{
				var center:BitmapData = scale(source[1], centerWidth / source[1].width);
				result.copyPixels(center, new Rectangle(0, 0, center.width, center.height), new Point(source[0].width));
			}
			
			result.copyPixels(source[2], new Rectangle(0, 0, source[2].width, source[2].height), new Point(width - source[2].width));
			
			return result;
		}
		
		static public function scale(source:BitmapData, scaleX:Number = 1, scaleY:Number = 1):BitmapData
		{
			var matrix:Matrix = new Matrix();
			matrix.scale(scaleX, scaleY);
			
			var result:BitmapData = new BitmapData(source.width * scaleX, source.height * scaleY, true, 0);
			result.draw(source, matrix, null, null, null, true);
			
			return result;
		}
		
		static public function getBitmap(source:DisplayObject):BitmapData
		{
			var bitmap:BitmapData = new BitmapData(source.width, source.height, true, 0);
			bitmap.draw(source);
			return bitmap;
		}
		
		static public function cut(source:BitmapData, rect:Rectangle):BitmapData
		{
			var result:BitmapData = new BitmapData(rect.width, rect.height, true, 0);
			result.copyPixels(source, rect, new Point());
			return result;
		}
	}
}