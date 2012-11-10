package bitrise.core.locale.procedures.functions
{
	import bitrise.core.locale.Locale;
	import bitrise.core.locale.LocaleProcedure;
	import bitrise.core.locale.procedures.FunctionProcedure;
	import bitrise.core.locale.procedures.VariableProcedure;

	public class LocaleFunction extends FunctionBase
	{
		
		public function LocaleFunction(procedure:FunctionProcedure)
		{
			super(procedure);
		}
		
		override public function parser(c:String):void
		{
			
		}
		
		override public function holder(procedure:LocaleProcedure):void
		{
			
		}
		
		override public function invoke(label:String, data:*):String
		{
			const param:VariableProcedure = procedure.list[0];
			const prefix:VariableProcedure = procedure.list[1];
			const postfix:VariableProcedure = procedure.list[2];
			if (param)
			{
				var local:String = param.invoke(label, data);
				if (prefix)
					local = prefix.invoke(label, data) + local;
				if (postfix)
					local = local + postfix.invoke(label, data);
				return Locale.text(local, data); 
			}
			return "";
		}
	}
}