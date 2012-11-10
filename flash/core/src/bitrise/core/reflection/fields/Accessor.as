package bitrise.core.reflection.fields
{
	import bitrise.core.reflection.Field;
	
	public class Accessor extends Field
	{
		public function Accessor(describe:XML, parent:Class, isStatic:Boolean = false)
		{
			super(describe, parent, isStatic);
		}
	}
}