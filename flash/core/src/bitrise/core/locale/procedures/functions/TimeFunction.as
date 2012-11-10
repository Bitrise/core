package bitrise.core.locale.procedures.functions
{
	import bitrise.core.locale.Locale;
	import bitrise.core.locale.LocaleProcedure;
	import bitrise.core.locale.procedures.FunctionProcedure;
	import bitrise.core.locale.procedures.VariableProcedure;
	
	import flash.globalization.DateTimeFormatter;
	
	public class TimeFunction extends FunctionBase
	{
		public function TimeFunction(procedure:FunctionProcedure)
		{
			super(procedure);
		}
		
		override public function parser(c:String):void
		{
//			trace(c);
		}
		
		override public function holder(procedure:LocaleProcedure):void
		{
//			trace(procedure);
		}
		
		override public function invoke(label:String, data:*):String
		{
			const time:VariableProcedure = procedure.list[0];
			if (time)
			{
				const formatProcedure:VariableProcedure = procedure.list[1];
				var format:String = "";
				if (formatProcedure)
				{
					format = formatProcedure.invoke(label, data);
				}
				const date:uint = uint(time.invoke(label, data)) / 1000;
				var result:String = "";
				const hours:uint = uint(date / (60 * 60)) % 24;
				const minute:uint = uint(date / 60) % 60;
				const seconds:uint = date % 60;
				result += (hours < 10) ? "0" + hours : hours;
				result += ":";
				result += (minute < 10) ? "0" + minute : minute;
				result += ":";
				result += (seconds < 10) ? "0" + seconds : seconds;
				return result;
			}
			else
				return "ERROR TIME";
		}
	}
}