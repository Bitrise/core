package bitrise.core.utils
{

	public class StringUtils
	{
		public static function trim(str:String):String
		{
			if (str == null) return '';
			
			var startIndex:int = 0;
			while (isWhitespace(str.charAt(startIndex)))
				++startIndex;
			
			var endIndex:int = str.length - 1;
			while (isWhitespace(str.charAt(endIndex)))
				--endIndex;
			
			if (endIndex >= startIndex)
				return str.slice(startIndex, endIndex + 1);
			else
				return "";
		}
		
		public static function isWhitespace(character:String):Boolean
		{
			switch (character)
			{
				case " ":
				case "\t":
				case "\r":
				case "\n":
				case "\f":
					return true;
					
				default:
					return false;
			}
		}
		
		static public function numberFormat(number:*, separator:String = ','):String 
		{
			var i:int = 0
			var inc:Number = Math.pow(10, 2);
			var str:String = String(Math.round(inc * Number(number))/inc);
			var hasSep:Boolean = str.indexOf(".") == -1
			var sep:int = hasSep ? str.length : str.indexOf(".");
			var ret:String = (hasSep ? "" : separator) + str.substr(sep+1);
			
			while (i + 3 < (str.substr(0, 1) == "-" ? sep-1 : sep)) ret = separator + str.substr(sep - (i += 3), 3) + ret;
			return str.substr(0, sep - i) + ret;
		}
		
		static public function parseIntArray(string:String, separator:String = ','):Array
		{
			var strings:Array = string.split(separator);
			var result:Array = [];
			for(var i:int = 0; i < strings.length; i++)
			{
				var element:String = strings[i];
				element = trim(element);
				if (element.length > 0)
					result.push(int(element));
			}
			return result;
		}
		
		static public function parseStringArray(string:String, separator:String = ','):Array
		{
			var strings:Array = string.split(separator);
			var result:Array = [];
			for(var i:int = 0; i < strings.length; i++)
			{
				var element:String = strings[i];
				element = trim(element);
				if (element.length > 0)
					result.push(element);
			}
			return result;
		}
		
		public static function removeDouble(str:String, char:String = ' '):String
		{
			if (str == null) return '';
			
			var result:String = ""
			var i:uint = 0;
			var prev:Boolean = false;
			
			while(i < str.length)
			{
				const current:String = str.charAt(i);
				if (current == char)
				{
					if (!prev)
					{
						result = result.concat(current);
					}
					prev = true;
				}
				else
				{
					result = result.concat(current);
					prev = false;
				}
				i++;
			}
			
			return result;
		}
		
	}
}