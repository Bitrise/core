package bitrise.core.logger
{
	import bitrise.core.reflection.Reflection;

	public class LogTraceHandler extends LogHandler
	{
		public function LogTraceHandler(mask:uint)
		{
			super(mask);
		}
		
		override public function apply(header:LogHeader, time:uint, reporter:*, rest:Array):void {
			trace(time, "[", (header) ? header.name : "UNDEF", "]", Reflection.getSimpleClassName(reporter), ":", rest);
		}
		
		public function set mask(value:uint):void {
			_mask = value;
		}
	}
}