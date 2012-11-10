package bitrise.core.locale.utils
{
	import bitrise.core.locale.LocaleProcedure;
	import bitrise.core.locale.procedures.VariableProcedure;
	import bitrise.core.utils.ObjectUtils;

	public class ConditionBlock
	{
		
		public var parent:ConditionBlock;
		
		private var list:Array = new Array();
		private var group:Array = new Array();
		
		public function ConditionBlock(parent:ConditionBlock)
		{
			this.parent = parent;
			list.push(group);
		}
		
		public function addOperator(operator:String):void
		{
			switch(operator)
			{
				case "!":
				case "==":
				case "=":
				case "<>":
				case "!=":
				case ">":
				case "<":
				case ">=":
				case "<=":
					group.push(operator);
					break;
				case "&&":
				case "&":
				case "||":
				case "|":
					group = new Array();
					list.push(operator, group);
					break;
				default:
					throw new Error("Bad condition operator: " + operator);
			}
		}
		
		public function addBlock(block:ConditionBlock):void
		{
			if (!block)
				throw new Error("Error condition block");
			group.push(block);
		}
		
		public function addProcedure(procedure:LocaleProcedure):void
		{
			if (!procedure)
				throw new Error("Error condition procedure");
			group.push(procedure);
		}
		
		public function invoke(label:String, data:*):Boolean
		{
			const length:uint = list.length;
			var local:Boolean = false;
			var result:Boolean = true;
			var first:Boolean = true;
			if (length == 1)
				return toValue(list[0], label, data)
			else for(var i:uint = 0; i < length; i++)
			{
				const item:Object = list[i];
				if (item is String)
				{
					switch(item)
					{
						case "&&":
						case "&":
							if (first)
							{
								first = false;
								result = toValue(list[i - 1], label, data) && toValue(list[i + 1], label, data);
							}
							else
								result = result && toValue(list[i + 1], label, data);
							break;
						case "||":
						case "|":	
							if (first)
							{
								first = false;
								result = toValue(list[i - 1], label, data) || toValue(list[i + 1], label, data);
							}
							else
								result = result || toValue(list[i + 1], label, data);
							break;
					}
				}
			}
			return result;
		}
		
		private function toValue(object:Object, label:String, data:*):Object
		{
			if (!object)
				return null;
			if (object is ConditionBlock)
				return ConditionBlock(object).invoke(label, data);
			if (object is VariableProcedure)
				return VariableProcedure(object).real(data);
			if (object is LocaleProcedure)
				return ObjectUtils.stringToObject(LocaleProcedure(object).invoke(label, data));
			if (object is Array)
			{
				const array:Array = object as Array;
				const length:uint = array.length;
				
				if (length == 1)
					return toValue(array[0], label, data)
				else for(var i:uint = 0; i < length; i++)
				{
					const item:Object = array[i];
					if (item is String)
					{
						switch(item)
						{
							case "!":
								return !toValue(array[i + 1], label, data);
								break;
							case "==":	
							case "=":	
								return toValue(array[i - 1], label, data) == toValue(array[i + 1], label, data);
								break;
							case "<>":
							case "!=":	
								return toValue(array[i - 1], label, data) != toValue(array[i + 1], label, data);
								break;
							case ">":	
								return toValue(array[i - 1], label, data) > toValue(array[i + 1], label, data);
								break;
							case "<":	
								return toValue(array[i - 1], label, data) < toValue(array[i + 1], label, data);
								break;
							case ">=":	
								return toValue(array[i - 1], label, data) >= toValue(array[i + 1], label, data);
								break;
							case "<=":	
								return toValue(array[i - 1], label, data) <= toValue(array[i + 1], label, data);
								break;
						}
					}
				}
			}
			return null;
		}
	}
}
