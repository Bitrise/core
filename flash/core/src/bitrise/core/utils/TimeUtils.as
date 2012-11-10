package bitrise.core.utils
{
	import flash.globalization.DateTimeFormatter;
	import flash.globalization.LocaleID;

	public class TimeUtils
	{
		private static const DATE:Date = new Date();
		private static const DATE_FORMAT:DateTimeFormatter = new DateTimeFormatter(LocaleID.DEFAULT);
		
		public static function stampToFormat(stamp:uint, pattern:String):String {
			DATE.time = stamp;
			DATE_FORMAT.setDateTimePattern(pattern);
			return DATE_FORMAT.formatUTC(DATE);
		}
		
	}
}