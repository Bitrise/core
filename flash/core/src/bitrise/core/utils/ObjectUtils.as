package bitrise.core.utils
{
	import bitrise.core.reflection.Clazz;
	import bitrise.core.reflection.Field;
	import bitrise.core.reflection.Reflection;
	import bitrise.core.reflection.fields.Variable;

	public class ObjectUtils
	{
		
		public static function toType(data:Object, cls:Class):* {
			if (data is String) {
				
			} else if (data is Boolean) {
				
			} else if (data is Number) {
				
			} else if (data is Array || data is Vector) {
				
			} else {
				 
			}
			return null;
		}
		
		public static function toObject(data:*):Object {
			if (data is String) {
				return data;
			} else if (data is Boolean) {
				
			} else if (data is Number) {
				
			} else if (data is Array || data is Vector) {
				
			} else {
				
			}
			return null;
		}
		
		public static function stringToObject(value:String):Object {
			const lower:String = value.toLowerCase();
			const number:Number = Number(lower);
			if (!isNaN(number))
				return number;
			if (lower == "true")
				return true;
			if (lower == "false")
				return false;
			if (value == "" || value == null)
				return null;
			return value;
		}
	}
}