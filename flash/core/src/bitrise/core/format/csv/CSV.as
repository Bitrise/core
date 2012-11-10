package bitrise.core.format.csv
{
	public class CSV
	{
		
		public static const QUOTES:String = "\"";
		public static const SEPARATOR:String = ",";
		
		public static function parse(data:String):Vector.<Vector.<String>>
		{
			data += "\n";
			const result:Vector.<Vector.<String>> = new Vector.<Vector.<String>>();
			var current:Vector.<String> = new Vector.<String>();
			var quotes:Boolean = false;
			var cc:String = "";
			var nc:String = "";
			var value:String = "";
			for (var i:uint = 0; i < data.length; i++)
			{
				cc = data.charAt(i);
				if (cc == QUOTES)
				{
					if (quotes)
					{
						nc = data.charAt(i + 1);
						if (nc == QUOTES)
						{
							value += QUOTES;
							i+=1;
						}
						else
						{
							quotes = false;
						}
					}
					else
					{
						quotes = true;
					}
				}
				else if (cc == SEPARATOR)
				{
					if (quotes)
					{
						value += SEPARATOR;
					}
					else
					{
						current.push(value);
						value = "";
					}
				}
				else if (cc == "\n" || cc == "\r")
				{
					if (quotes)
					{
						value += cc;
					}
					else
					{
						if(value.length)
						{
							current.push(value);						
							result.push(current);
						}
						current = new Vector.<String>();
						value = "";
					}
				}
				else
				{
					value += cc;
				}
				
			}
			return result;
		}
	}
}