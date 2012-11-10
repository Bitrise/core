package bitrise.core.reflection
{
	public class Field
	{
		
		private var _name:String;
		private var _parent:Class;
		private var _isStatic:Boolean;
		
		public function Field(describe:XML, parent:Class, isStatic:Boolean = false)
		{
			_name = String(describe.@name);
			_parent = parent;
			_isStatic = isStatic;
		}
		
		public function get isStatic():Boolean
		{
			return _isStatic;
		}
		
		public function get parent():Class
		{
			return _parent;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function toString():String
		{
			return "[Field " + _name + " isStatic: " + _isStatic + "]";
		}

	}
}