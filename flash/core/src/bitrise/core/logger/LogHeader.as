package bitrise.core.logger
{
	public class LogHeader
	{
		private var _level:uint = 0;
		private var _name:String;
		private var _color:uint;
		private var _description:String;
		
		public function LogHeader(level:uint, name:String, color:uint, description:String)
		{
			_level = level;
			_name = name;
			_color = color;
			_description = description;
		}

		public function get description():String
		{
			return _description;
		}

		public function get color():uint
		{
			return _color;
		}

		public function get name():String
		{
			return _name;
		}

		public function get level():uint
		{
			return _level;
		}

	}
}