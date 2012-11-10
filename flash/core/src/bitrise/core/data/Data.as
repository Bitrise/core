package bitrise.core.data
{
	import bitrise.core.tools.Invalidator;
	
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class Data implements IEventDispatcher
	{
		
		private static var count:uint = 0;
		
		internal var _name:String = "insatance" + ++count;
		internal var _catch:Boolean = false;
		internal var _parent:DataContainer;
		
		private var _main:MainData;
		private var _dispatcher:EventDispatcher;
		
		public function Data() {
			_dispatcher = new EventDispatcher(this);
		}
		
		public function get parent():DataContainer {
			return _parent;
		}
		
		public function get name():String {
			return _name;
		}
		
		public function set name(value:String):void {
			if (_catch)
				throw new IllegalOperationError("Data has been catched");
			_name = value;
		}
		
		public function get main():MainData {
			return _main;
		}
		
		internal function set $main(value:MainData):void {
			if (_main == value)
				return;
			
			_main = value;
			if (_main) {
				if (hasEventListener(DataEvent.ADDED_TO_MAIN))
					dispatchEvent(new DataEvent(DataEvent.ADDED_TO_MAIN));
			} else {
				if (hasEventListener(DataEvent.REMOVED_FROM_MAIN))
					dispatchEvent(new DataEvent(DataEvent.REMOVED_FROM_MAIN));
			}
		}
		
		internal function get $main():MainData {
			return _main;
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int = 0, useWeakReference:Boolean = true):void {
			_dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void {
			_dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):Boolean {
			var result:Boolean = _dispatcher.dispatchEvent(event);
			
			if (_parent && event.bubbles) {
				if (!_parent.dispatchEvent(event))
					result = false;
			}
			return result;
		}
		
		public function hasEventListener(type:String):Boolean {
			return _dispatcher.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean {
			return _dispatcher.willTrigger(type);
		}
	}
}