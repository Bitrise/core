package bitrise.core.locale
{
	import bitrise.core.locale.procedures.ErrorProcedure;
	import bitrise.core.locale.procedures.FunctionProcedure;
	import bitrise.core.locale.procedures.TextProcedure;
	import bitrise.core.locale.procedures.VariableProcedure;
	
	import flash.utils.Dictionary;
	
	public class Locale
	{
		private static const _locale:Object = new Object();
		private static const _weak:Dictionary = new Dictionary(true);
		
		bitrise_internal static function addAll(source:Object, update:Boolean = false):void {
			const vector:Vector.<String> = new Vector.<String>();
			for(var label:String in source) {
				if (update && label in _locale)
					vector.push(label);
				_locale[label] = handler(label, source[label]);
			}
			if (update)
				bitrise_internal::updateVector(vector);
		}
		
		bitrise_internal static function add(label:String, value:String, update:Boolean = false):void {
			_locale[label] = handler(label, value);
			if (update)
				bitrise_internal::update(label);
		}
		
		bitrise_internal static function updateAll():void {
			for(var key:Object in _weak) {
				key.value = text(key.label, key.data);
			}
		}
		
		bitrise_internal static function updateVector(vector:Vector.<String>):void {
			for each(var label:String in vector) {
				bitrise_internal::update(label);
			}
		}
		
		bitrise_internal static function update(label:String):void {
			for(var key:Object in _weak) {
				if (key.label == label)
					key.value = text(key.label, key.data);
			}
		}
		
		public static function text(label:String, data:* = null):String {
			const procedure:LocaleProcedure = _locale[label];
			if (procedure)
				return procedure.invoke(label, data);
			return label;
		}
		
		public static function bind(label:String, data:* = null):LocaleBinding {
			const binding:LocaleBinding = new LocaleBinding(label, data, text(label, data));
			_weak[binding] = true;
			return binding;
		}
		
		private static function handler(label:String, data:String):LocaleProcedure
		{
			try
			{
				const first:TextProcedure = new TextProcedure();
				var current:LocaleProcedure = first;
				for (var i:uint = 0; i < data.length; i++)
				{
					var cc:String = data.charAt(i);
					if (cc == "%")
					{
						const variable:VariableProcedure = new VariableProcedure();
						if (current)
							current.addProcedure(variable);
						current = variable;
					}
					else if (cc == "$")
					{
						const func:FunctionProcedure = new FunctionProcedure();
						if (current)
							current.addProcedure(func);
						current = func;
					}
					else
					{
						while(current.read(cc))
						{
							if (current.parent)
								current = current.parent;
							else
								break;
						}
					}
				}
				return first;
			}
			catch(error:Error)
			{
				logWarning(Locale, "Error syntax in \"", label, "\". ", error.message);
			}
			
			return new ErrorProcedure();
		}
		
	}
}