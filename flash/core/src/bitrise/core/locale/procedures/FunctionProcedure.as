package bitrise.core.locale.procedures
{
	import bitrise.core.locale.Locale;
	import bitrise.core.locale.LocaleProcedure;
	import bitrise.core.locale.procedures.functions.FunctionBase;
	import bitrise.core.locale.procedures.functions.IfFunction;
	import bitrise.core.locale.procedures.functions.LocaleFunction;
	import bitrise.core.locale.procedures.functions.TimeFunction;
	import bitrise.core.locale.procedures.functions.ForeachFunction;
	import bitrise.core.utils.StringUtils;
	
	import flash.utils.Dictionary;
	
	public class FunctionProcedure extends LocaleProcedure
	{
		
		private static const functions:Dictionary = new Dictionary();
		
		functions["locale"] = LocaleFunction;
		functions["if"] = IfFunction;
		functions["time"] = TimeFunction;
		functions["foreach"] = ForeachFunction;
		
		private var count:int = 0;
		private var init:Boolean = false;
		
		private var name:String = "";
		private var nameInit:Boolean = false;
		
		private var func:FunctionBase;
		
//		private var funcParser:Function;
//		private var funcHolder:Function;
//		private var funcInvoker:Function;
		
		private var close:Boolean = false;
		
		public function FunctionProcedure()
		{
			super();
		}
		
		override public function addProcedure(procedure:LocaleProcedure):void
		{
			super.addProcedure(procedure);
			func.holder(procedure);
		}
		
		override public function read(c:String):Boolean
		{
			if (close)
				return true;
			
			if (c != "{" && !init)
			{
				throw new Error("Error function syntax: first character { is not found");
			}
			else if (c == "{" && !init)
			{
				init = true;
				count++;
				return false;
			}
			
			
			if (c == "{")
				count++;
			else if (c == "}")
				count--;
			
			if (count == 0)
			{
				close = true;
				return false;
			}
			
			if (c == "(" && !nameInit)
			{
				name = StringUtils.trim(name);
				nameInit = true;
			}
			
			if (!nameInit)
				name += c;
			else
			{
				if (func == null)
				{
					const cls:Class = functions[name];
					if (cls)
					{
						func = new cls(this);
					}
					else
					{
						throw new Error("Error function syntax: unsupported function: \"" + name + "\".");
					}
				}
				
				func.parser(c);
			}
			
			return false;
		}
		
		override public function invoke(label:String, data:*):String
		{
			return func.invoke(label, data);
		}
		
	}
}