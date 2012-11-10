package bitrise.core.data
{
	import flash.events.Event;
	
	public class DataEvent extends Event
	{
		
		public static const ADDED:String = "added";
		public static const REMOVED:String = "removed";
		public static const ADDED_TO_MAIN:String = "addedToMain";
		public static const REMOVED_FROM_MAIN:String = "removedFromMain";
		public static const SWAPPED:String = "swapped";
		public static const CHANGE:String = "change";
		
		internal var _stop:Boolean = false;
		private var _data:*;
		
		public function DataEvent(type:String, data:* = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			_data = data;
		}
		
		public function get data():* {
			return _data;
		}
		
		override public function clone():Event {
			return new DataEvent(type, _data, bubbles, cancelable);
		}
		
		override public function stopImmediatePropagation():void {
			super.stopImmediatePropagation();
			_stop = true;
		}
		
		override public function stopPropagation():void {
			super.stopPropagation();
			_stop = true;
		}
	}
}