package bitrise.core.tools
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	import flash.net.SharedObject;

	[Event(name="change", type="flash.events.Event")]
	
	public class SecondWindow extends EventDispatcher
	{
		
		private var _connection:LocalConnection;
		private var _key:String;
		private var _session:uint
		
		public function SecondWindow(key:String)
		{
			_key = key;
			const sharedObject:SharedObject = SharedObject.getLocal(_key);
			if (!sharedObject.data.session)
				sharedObject.data.session = 0;
			_session = sharedObject.data.session + 1;
			for (var i:int = _session - 10; i < _session; i++)
			{
				if (i > 0)
					close(i);
			}
			sharedObject.data.session = _session;
			sharedObject.flush();
			
			_connection = new LocalConnection();
			_connection.allowDomain("*");
			_connection.client = this;
			_connection.addEventListener(StatusEvent.STATUS, function(event:Event):void{});
			_connection.connect(_key + _session);
		}
		
		private function close(old:uint):void
		{
			if (old)
			{
				const session:String = _key + old;
				const sender:LocalConnection = new LocalConnection();
				sender.addEventListener(StatusEvent.STATUS, function(event:Event):void{});
				sender.send(session, "remove");
			}
		}
		
		public function remove():void
		{
			_connection.close();
			dispatchEvent(new Event(Event.CHANGE));
		}
		
	}
}