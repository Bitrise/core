package bitrise.core.logger
{
	public class LogHandler
	{
		
		protected var _mask:uint = 0;
		
		public function LogHandler(mask:uint)
		{
			_mask = mask;
		}
		
		public function get mask():uint {
			return _mask;
		}
		
		public function apply(header:LogHeader, time:uint, reporter:*, rest:Array):void {
			
		}
	}
}