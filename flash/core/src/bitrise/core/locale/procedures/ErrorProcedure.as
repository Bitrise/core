package bitrise.core.locale.procedures
{
	import bitrise.core.locale.LocaleProcedure;
	
	public class ErrorProcedure extends LocaleProcedure
	{
		public function ErrorProcedure()
		{
			super();
		}
		
		override public function invoke(label:String, data:*):String
		{
			return label + " error syntax";
		}
	}
}