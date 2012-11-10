package bitrise.core.reflection
{
	
	import bitrise.core.reflection.fields.Accessor;
	import bitrise.core.reflection.fields.Method;
	import bitrise.core.reflection.fields.Variable;
	
	import flash.net.getClassByAlias;
	import flash.net.registerClassAlias;
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	public class Reflection
	{
		
		private static const hashClazz:Dictionary = new Dictionary();
		
		public static function describe(object:*):Clazz
		{
			if (!(object is Class))
				return describe(getClass(object));
			
			const oldClazz:Clazz = hashClazz[object];
			if (oldClazz)
				return oldClazz;
			
			const clazz:Clazz = new Clazz(object);
			hashClazz[object] = clazz;
			return clazz;
		}
		
		public static function getClass(object:*):Class
		{
			return getDefinitionByName(getQualifiedClassName(object)) as Class;
		}
		
		public static function getClassByName(name:String):Class
		{
			if (name == "*") 
				return Object;
			
			name = name.replace("::", ".");
			try
			{
				return getDefinitionByName(name) as Class;
			}
			catch(error:Error){}
			return null;
		}
		
		public static function getClassName(object:*):String
		{
			return getQualifiedClassName(object).replace("::", ".");
		}
		
		public static function getSimpleClassName(object:*):String
		{
			return getQualifiedClassName(object).split("::").pop();
		}
		
		public static function createClass(type:Class, arguments:Array = null):*
		{
			if (arguments == null)
				return new type();
			switch(arguments.length)
			{
				case 0:
					return new type();
				case 1:
					return new type(arguments[0]);
				case 2:
					return new type(arguments[0], arguments[1]);
				case 3:
					return new type(arguments[0], arguments[1], arguments[2]);
				case 4:
					return new type(arguments[0], arguments[1], arguments[2], arguments[3]);
				case 5:
					return new type(arguments[0], arguments[1], arguments[2], arguments[3], arguments[4]);
				case 6:
					return new type(arguments[0], arguments[1], arguments[2], arguments[3], arguments[4], arguments[5]);
				case 7:
					return new type(arguments[0], arguments[1], arguments[2], arguments[3], arguments[4], arguments[5], arguments[6]);
				case 8:
					return new type(arguments[0], arguments[1], arguments[2], arguments[3], arguments[4], arguments[5], arguments[6], arguments[7]);
				case 9:
					return new type(arguments[0], arguments[1], arguments[2], arguments[3], arguments[4], arguments[5], arguments[6], arguments[7], arguments[8]);
				case 10:
					return new type(arguments[0], arguments[1], arguments[2], arguments[3], arguments[4], arguments[5], arguments[6], arguments[7], arguments[8], arguments[9]);
				default:
					throw new Error("No support " + arguments.length + " arguments");
			}
			return null;
		}
		
//		public static function isSimple(object:*):uint
//		{
//			if (!(object is Class))
//				return isSimple(getClass(object));
//			
//			switch(object)
//			{
//				case uint:
//				case int:
//				case Number:
//				case String:
//				case Boolean:
//					return true;
//					break
//				default:
//					return false;
//			}
//		}
		
	}
}