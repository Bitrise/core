package bitrise.core.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.FrameLabel;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.utils.describeType;

	public class DisplayUtils
	{
		
		public static function stopOrPlayAnimation(container:DisplayObjectContainer, animation:Boolean):void
		{
			if (container)
			{
				const length:uint = container.numChildren;
				for(var i:uint = 0; i < length; i++)
				{
					stopOrPlayAnimation(container.getChildAt(i) as DisplayObjectContainer, animation);
				}
				const clip:MovieClip = container as MovieClip;
				if (clip)
				{
					if (animation)
						clip.play();
					else
						clip.stop();
				}
			}
		}
		
		public static function goToFrame(object:DisplayObject, frame:uint):void
		{
			if (object is MovieClip)
			{
				const clip:MovieClip = object as MovieClip;
				clip.gotoAndPlay(frame % clip.totalFrames);
			}
			if (object is DisplayObjectContainer)
			{
				const container:DisplayObjectContainer = object as DisplayObjectContainer;
				for (var i:uint = 0; i < container.numChildren; i++)
				{
					const child:DisplayObject = container.getChildAt(i);
					goToFrame(child, frame);
				}
			}
		}
		
	}
}