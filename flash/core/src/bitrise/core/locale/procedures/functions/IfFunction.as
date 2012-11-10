package bitrise.core.locale.procedures.functions
{
	import bitrise.core.locale.LocaleProcedure;
	import bitrise.core.locale.procedures.FunctionProcedure;
	import bitrise.core.locale.utils.LocaleCondition;
	import bitrise.core.utils.StringUtils;
	
	public class IfFunction extends FunctionBase
	{
		
		private var conditionPosition:int = 0;
		private var contentPosition:int = 0;
		
		private var conditions:Vector.<LocaleCondition>;
		private var currentCondition:LocaleCondition;
		private var condition:Boolean = false;
		private var content:Boolean = false;
		
		public function IfFunction(procedure:FunctionProcedure)
		{
			super(procedure);
			conditions = new Vector.<LocaleCondition>();
		}
		
		override public function parser(c:String):void
		{
			if (!condition && c == "(")
			{
				content = false;
				condition = true;
				currentCondition = new LocaleCondition();
				conditions.push(currentCondition);
				conditionPosition++;
				return;
			}
			else if (condition && c == "(")
			{
				conditionPosition++;
			}
			else if (condition && c == ")")
			{
				conditionPosition--;
			}
			
			if (condition && conditionPosition == 0)
			{
				if (currentCondition)
				{
					condition = false;
					currentCondition.compileCondition();
					return;
				}
				else
				{
					throw new Error("Error \"IF\" function syntax: bad condition.");
				}
			}
			
			if (!content && c == "{")
			{
				condition = false;
				content = true;
				contentPosition++;
				return;
			}
			else if (content && c == "{")
			{
				contentPosition++;
			}
			else if (content && c == "}")
			{
				contentPosition--;
			}
			
			if (content && contentPosition == 0)
			{
				if (currentCondition)
				{
					content = false;
					currentCondition.compileContent();
					return;
				}
				else
				{
					throw new Error("Error \"IF\" function syntax: bad content.");
				}
			}
			
			if (condition)
			{
				if (currentCondition)
				{
					currentCondition.addConditionChar(c);
				}
				else
				{
					throw new Error("Error \"IF\" function syntax: bad condition.");
				}
			}
			else if (content)
			{
				if (currentCondition)
				{
					currentCondition.addContentChar(c);
				}
				else
				{
					throw new Error("Error \"IF\" function syntax: bad content.");
				}
			}
		}
		
		override public function holder(procedure:LocaleProcedure):void
		{
			if (condition)
			{
				if (currentCondition)
				{
					currentCondition.addConditionProcedure(procedure);
				}
				else
				{
					throw new Error("Error \"IF\" function syntax: bad condition.");
				}
			}
			else if (content)
			{
				if (currentCondition)
				{
					currentCondition.addContentProcedure(procedure);
				}
				else
				{
					throw new Error("Error \"IF\" function syntax: bad content.");
				}
			}
		}
		
		override public function invoke(label:String, data:*):String
		{
			for each (var condition:LocaleCondition in conditions)
			{
				if (condition.invokeCondition(label, data))
				{
					return condition.invokeContent(label, data);
				}
			}
			return "";
		}
		
	}
}