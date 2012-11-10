package bitrise.core.reflection.fields
{
	import bitrise.core.reflection.Field;
	
	public class Method extends Field
	{
		public function Method(describe:XML, parent:Class, isStatic:Boolean = false)
		{
			super(describe, parent, isStatic);
		}
	}
}