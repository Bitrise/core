package bitrise.core.locale.procedures.functions
{
	import bitrise.core.locale.LocaleProcedure;
	import bitrise.core.locale.procedures.FunctionProcedure;

	public class FunctionBase
	{
		
		protected var procedure:FunctionProcedure;
		
		public function FunctionBase(procedure:FunctionProcedure)
		{
			this.procedure = procedure;
		}
		
		public function parser(c:String):void
		{
			
		}
		
		public function holder(procedure:LocaleProcedure):void
		{
			
		}
		
		public function invoke(label:String, data:*):String
		{
			return "";
		}
		
	}
}