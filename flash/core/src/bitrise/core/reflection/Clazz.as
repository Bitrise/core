package bitrise.core.reflection
{
	import bitrise.core.reflection.fields.Accessor;
	import bitrise.core.reflection.fields.Method;
	import bitrise.core.reflection.fields.Variable;
	
	import flash.utils.describeType;

	public class Clazz
	{
		
		private var cls:Class;
		private var xml:XML;
		
		public const methods:Vector.<Method> = new Vector.<Method>();
		public const variables:Vector.<Variable> = new Vector.<Variable>();
		public const accessors:Vector.<Accessor> = new Vector.<Accessor>();
		
		public const sMethods:Vector.<Method> = new Vector.<Method>();
		public const sVariables:Vector.<Variable> = new Vector.<Variable>();
		public const sAccessors:Vector.<Accessor> = new Vector.<Accessor>();
		
		public function Clazz(cls:Class)
		{
			this.cls = cls;
			xml = describeType(cls);
			
			for each(var variableStatic:XML in xml.variable)
			{
				sVariables.push(new Variable(variableStatic, cls, true));
			}
			
			for each(var accessorStatic:XML in xml.accessor)
			{
				sAccessors.push(new Accessor(accessorStatic, cls, true));
			}
			
			for each(var methodStatic:XML in xml.method)
			{
				sMethods.push(new Method(methodStatic, cls, true));
			}
			
			const factory:XML = xml.factory[0];
			
			for each(var variable:XML in factory.variable)
			{
				variables.push(new Variable(variable, cls));
			}
			
			for each(var accessor:XML in factory.accessor)
			{
				accessors.push(new Accessor(accessor, cls));
			}
			
			for each(var method:XML in factory.method)
			{
				methods.push(new Method(method, cls));
			}
			
			methods.sort(sort);
			accessors.sort(sort);
			variables.sort(sort);
			sMethods.sort(sort);
			sAccessors.sort(sort);
			sVariables.sort(sort);
			
		}
		
		private function sort(a:Field, b:Field):int 
		{
			if (a.name < b.name)
				return -1;
			else if (a.name > b.name)
				return 1;
			return 0;
		}
		
		public function get name():String
		{
			return Reflection.getClassName(cls);
		}
		
		public function create(...arg):*
		{
			return Reflection.createClass(cls, arg);
		}
		
	}
}