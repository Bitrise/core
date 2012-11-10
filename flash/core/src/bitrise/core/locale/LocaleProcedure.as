package bitrise.core.locale
{
	public class LocaleProcedure
	{
		
		public var list:Array;
		
		public var parent:LocaleProcedure;
		
		public function LocaleProcedure()
		{
			list = new Array();
		}
		
		public function read(c:String):Boolean
		{
			return false;
		}
		
		public function addProcedure(procedure:LocaleProcedure):void
		{
			procedure.parent = this;
			list.push(procedure);
		}
		
		public function invoke(label:String, data:*):String
		{
			var result:String = "";
			for (var i:uint = 0; i < list.length; i++)
			{
				const element:Object = list[i];
				if (element is LocaleProcedure)
					result += LocaleProcedure(element).invoke(label, data);
				else
					result += element.toString();
			}
			return result;
		}
		
	}
}