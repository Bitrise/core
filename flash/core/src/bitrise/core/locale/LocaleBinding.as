package bitrise.core.locale
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class LocaleBinding extends EventDispatcher
	{
		[Bindable]
		public var value:String;
		
		internal var label:String;
		internal var data:*;
		
		public function LocaleBinding(label:String, data:*, result:String) {
			this.label = label;
			this.data = data;
			value = result;
		}
		
	}
}