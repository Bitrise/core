package bitrise.core.display
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.System;
	import flash.text.TextField;
	import flash.utils.getTimer;
	
	public class FPSCounter extends Sprite
	{
		
		public static var FPS:Number = 24;
		
		private static const MB:Number = 1024 * 1024;
		
		private var text:TextField;
		
		private var last:uint = 0;
		private var count:uint = 0;
		
		private var maxMem:Number = 0;
		
		public function FPSCounter()
		{
			super();
			mouseChildren = false;
			mouseEnabled = false;
			
			text = new TextField();
			text.width = 500;
			text.selectable = false;
			text.text = "FPS: ---- / -- \nMEM: ----- / ----- Mb";
			text.textColor = 0xFF0000;
			addChild(text);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			last = getTimer();
		}
		
		private function onEnterFrame(event:Event):void
		{
			count++;
			const time:uint = getTimer();
			const delta:uint = time - last;
			if (delta >= 1000)
			{
				FPS = count / delta * 1000;
				
				var string:String = "FPS: " + FPS.toFixed(1);
				if (stage)
				{
					string += " / " + stage.frameRate;
				}
				const currentMem:Number = System.totalMemoryNumber;
				if (currentMem > maxMem)
					maxMem = currentMem;
				string += "\nMEM: " + (currentMem / MB).toFixed(1) + " / " + (maxMem / MB).toFixed(1) + " Mb";
				text.text = string;
				count = 0;
				last = time;
			}
		}
	}
}