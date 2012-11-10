package bitrise.core.tools
{
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;

	public class Invalidator
	{
		
		private static const _invalidated:Dictionary = new Dictionary(true);
		private static const timer:Timer = new Timer(1);
		
		{
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		
		private static function onTimer(event:TimerEvent):void {
			for(var key:Object in _invalidated) {
				const method:Function = key as Function;
				if (method != null) {
					method();
				}
				delete _invalidated[key];
			}
		}
		
		public static function invalidate(method:Function):void {
			_invalidated[method] = true;
		}
	}
}