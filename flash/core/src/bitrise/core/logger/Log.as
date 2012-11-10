package bitrise.core.logger
{
	import flash.utils.getTimer;

	use namespace bitrise_internal;
	
	public class Log
	{
		public static const trace:LogTraceHandler = new LogTraceHandler(uint.MAX_VALUE);
		
		private static const _levels:Object = {};
		private static const _handlers:Vector.<LogHandler> = new Vector.<LogHandler>();
		private static var _mask:uint = 0;
		
		{
			registerLevel(LogLevels.DEBUG, "DEBG");
			registerLevel(LogLevels.INFO, "INFO");
			registerLevel(LogLevels.WARNING, "WARN");
			registerLevel(LogLevels.ERROR, "EROR");
			registerLevel(LogLevels.CRITICAL, "CRIT");
			registerHandler(trace);
		}
		
		public static function log(level:uint, reporter:*, ...rest):void {
			$log(level, reporter, rest);
		}
		
		bitrise_internal static function registerLevel(level:uint, name:String, color:uint = 0, description:String = null):void {
			if ((_mask & level) != 0) 
				throw new ArgumentError("Bad level");
			if (getHeader(level))
				throw new ArgumentError("Bad name");
			_mask = _mask | level;
			_levels[level] = new LogHeader(level, name, color, description);
		}
		
		bitrise_internal static function unregisterLevel(level:uint):void {
			if ((_mask & level) == 0) 
				throw new ArgumentError("Bad level");
			_mask = _mask ^ level;
			delete _levels[level];
		}
		
		bitrise_internal static function getHeader(level:uint):LogHeader {
			return _levels[level];
		}
		
		bitrise_internal static function registerHandler(handler:LogHandler):void {
			const index:int = _handlers.indexOf(handler);
			if (index == -1)
				_handlers.push(handler);
			else
				throw new ArgumentError("Handler already added");
		}
		
		bitrise_internal static function unregisterHandler(handler:LogHandler):void {
			const index:int = _handlers.indexOf(handler);
			if (index != -1)
				_handlers.splice(index, 1);
			else
				throw new ArgumentError("Handler not exists");
		}
		
		bitrise_internal static function $log(level:uint, reporter:*, rest:Array):void {
			const header:LogHeader = getHeader(level);
			for each(var handler:LogHandler in _handlers) {
				if ((handler.mask & level) != 0) {
					handler.apply(header, getTimer(), reporter, rest);
				}
			}
		}
		
		
	}
}