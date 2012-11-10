package bitrise.core.utils
{
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	

	public class FunctionUtils
	{
		
		private static const memory:Dictionary = new Dictionary();
		
		public static function callLeter(parent:*, func:Function, delay:uint, arg:Array = null):void
		{
			const timer:Timer = new Timer(delay, 1);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
			memory[timer] = [parent, func, arg || []];
		}
		
		public static function callLeterLambda(delay:uint, func:Function):void
		{
			if (delay == 0)
			{
				func();
			}
			else
			{
				const timer:Timer = new Timer(delay, 1);
				const invoke:Function = function():void {
					timer.removeEventListener(TimerEvent.TIMER, invoke);
					timer.stop();
					func();
				};
				timer.addEventListener(TimerEvent.TIMER, invoke);
				timer.start();
			}
		}
		
		private static function onTimer(event:TimerEvent):void
		{
			const timer:Timer = event.target as Timer;
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, onTimer);
			const array:Array = memory[timer];
			const parent:* = array[0];
			const func:Function = array[1];
			const arg:Array = array[2];
			delete memory[timer];
			func.apply(parent, arg);
		}
	}
}