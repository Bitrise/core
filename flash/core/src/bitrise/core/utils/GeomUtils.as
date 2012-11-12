package bitrise.core.utils
{
	public class GeomUtils
	{
		
		public static function lineLength(x1:Number, y1:Number, x2:Number, y2:Number, factorX:Number = 1, factorY:Number = 1):Number
		{
			var dx:int = (x2 - x1) / factorX;
			var dy:int = (y2 - y1) / factorY;
			return Math.sqrt(dx * dx + dy * dy);
		}
		
	}
}