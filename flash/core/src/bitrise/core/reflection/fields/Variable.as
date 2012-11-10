package bitrise.core.reflection.fields
{
	import bitrise.core.reflection.Field;
	import bitrise.core.reflection.Reflection;
	
	public class Variable extends Field
	{
		
		private var _type:Class;
		
		public function Variable(describe:XML, parent:Class, isStatic:Boolean = false)
		{
			super(describe, parent, isStatic);
			_type = Reflection.getClassByName(describe.@type);
		}
		
		public function get type():Class
		{
			return _type;
		}
		
		public function create():* {
			return Reflection.createClass(_type);
		}
		
	}
}