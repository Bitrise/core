package bitrise.core.utils
{
	import flash.display.Stage;
	import flash.errors.IllegalOperationError;
	import flash.system.Security;

	public class FlashVars
	{
		private static var _init:Boolean = false;
		private static var _vars:Object = new Object();
		
		public static function get(variable:String):String {
			return _vars[variable];
		}
		
		public static function apply(stage:Stage):void {
			if (_init)
				throw new IllegalOperationError("FlashVars alreay init");
			
			if (stage) {
				const data:Object = stage.loaderInfo.parameters;
				for(var key:String in data) {
					_vars[key] = data[key];
				}
				_init = true;
			} else {
				throw new ArgumentError("stage is null");
			}
		}
		
		public static function get init():Boolean {
			return _init;
		}
		
	}
}