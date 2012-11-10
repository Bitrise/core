package bitrise.core.locale.procedures
{
	import bitrise.core.locale.LocaleProcedure;
	import bitrise.core.utils.ObjectUtils;
	
	import mx.utils.StringUtil;
	
	public class VariableProcedure extends LocaleProcedure
	{
		
		public var constant:int = 0;
		public var name:String = "";
		private var paht:Array;
		public var value:Object = null;
		
		public function VariableProcedure()
		{
			super();
		}
		
		override public function addProcedure(procedure:LocaleProcedure):void
		{
			throw new Error("Error variable syntax");
		}
		
		override public function read(c:String):Boolean
		{
			if (c == "{")
			{
				value = "";
				constant += 1;
				return false;
			}
			else if (c == "}")
			{
				constant -= 1;
				return false;
			}
			else if (constant > 0)
			{
				value += c;
				return false;
			}
			else if (!value && c.match(/[\.a-zA-Z0-9_-]/) != null)
			{
				name += c;
				return false;
			}
			
			if (name.length == 0 && value == null)
				throw new Error("Error variable syntax: empty name or value");
			
			if (value)
				value = ObjectUtils.stringToObject(value.toString());
			
			return true;
		}
		
		public function real(data:*):Object
		{
			if (value)
				return value;
			else
			{
				if (!paht)
					paht = name.split(".");
				
				for(var i:uint = 0; i < paht.length; i++)
				{
					try
					{
						data = data[paht[i]];
					}
					catch(error:Error)
					{
						data = null;
						break;
					}
				}
				return data;
			}
		}
		
		override public function invoke(label:String, data:*):String
		{
			if (value)
				return value.toString();
			
			if (!paht)
				paht = name.split(".");
			
			for(var i:uint = 0; i < paht.length; i++)
			{
				try
				{
					data = data[paht[i]];
				}
				catch(error:Error)
				{
					data = null;
					break;
				}
			}
			
			if (data != null)
				return data.toString();
			else
				return "%" + name;
		}
		
	}
}