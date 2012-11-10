package bitrise.core.geom
{
	public class Quadrangle
	{
		
		public var x1:Number;
		public var x2:Number;
		public var x3:Number;
		public var x4:Number;
		
		public var y1:Number;
		public var y2:Number;
		public var y3:Number;
		public var y4:Number;
		
		public function Quadrangle(x1:Number = 0, y1:Number = 0, x2:Number = 0, y2:Number = 0, x3:Number = 0, y3:Number = 0, x4:Number = 0, y4:Number = 0)
		{
			this.x1 = x1;
			this.x2 = x2;
			this.x3 = x3;
			this.x4 = x4;
			
			this.y1 = y1;
			this.y2 = y2;
			this.y3 = y3;
			this.y4 = y4;
		}
		
		public function entryPoint(x:Number, y:Number):Boolean
		{
			if ((y1 - y2) * x + (x2 - x1) * y + (x1 * y2 - x2 * y1) < 0)
				return false;
			if ((y2 - y3) * x + (x3 - x2) * y + (x2 * y3 - x3 * y2) < 0)
				return false;
			if ((y3 - y4) * x + (x4 - x3) * y + (x3 * y4 - x4 * y3) < 0)
				return false;
			if ((y4 - y1) * x + (x1 - x4) * y + (x4 * y1 - x1 * y4) < 0)
				return false;
			
			return true;
		}
		
		public function intersectionQuadrangle(quadrangle:Quadrangle):Boolean
		{
			return entryPoint(quadrangle.x1, quadrangle.y1) || 
				entryPoint(quadrangle.x2, quadrangle.y2) ||
				entryPoint(quadrangle.x3, quadrangle.y3) || 
				entryPoint(quadrangle.x4, quadrangle.y4);
		}
		
		public function entryQuadrangle(quadrangle:Quadrangle):Boolean
		{
			return entryPoint(quadrangle.x1, quadrangle.y1) && 
				entryPoint(quadrangle.x2, quadrangle.y2) && 
				entryPoint(quadrangle.x3, quadrangle.y3) && 
				entryPoint(quadrangle.x4, quadrangle.y4);
		}
		
	}
}