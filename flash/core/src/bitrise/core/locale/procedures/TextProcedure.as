package bitrise.core.locale.procedures
{
	import bitrise.core.locale.LocaleProcedure;
	
	public class TextProcedure extends LocaleProcedure
	{
		
		private var value:String = "";
		
		public function TextProcedure()
		{
			super();
		}
		
		override public function addProcedure(procedure:LocaleProcedure):void
		{
			if (value.length > 0)
				list.push(value);
			value = "";
			super.addProcedure(procedure);
		}
		
		override public function read(c:String):Boolean
		{
			value += c;
			return false;
		}
		
		override public function invoke(label:String, data:*):String
		{
			if (value.length != 0)
			{
				list.push(value);
				value = "";
			}
			return super.invoke(label, data);
		}
		
	}
}