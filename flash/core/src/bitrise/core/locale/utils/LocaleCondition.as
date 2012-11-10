package bitrise.core.locale.utils
{
	import bitrise.core.locale.LocaleProcedure;
	import bitrise.core.locale.procedures.TextProcedure;

	public class LocaleCondition
	{
		
		private var block:ConditionBlock;
		private var current:ConditionBlock;
		
		public function LocaleCondition()
		{
			block = new ConditionBlock(null);
			current = block;
		}
		
		private var priority:int = 0;
		private var operator:String = "";
		
		
		public function addConditionChar(c:String):void
		{
			if (c == "(")
			{
				const temp:ConditionBlock = new ConditionBlock(current);
				current.addBlock(temp);
				current = temp;
			}
			else if (c == ")")
			{
				current = current.parent;
			}
			else if ("<>!=&|".indexOf(c) != -1)
			{
				operator += c;
			}
			else if (c == " ")
			{
				if (current == null)
					throw new Error("Bad condition operator: ) or ( 0");
				
				if (operator != "")
				{
					current.addOperator(operator);
					operator = "";
				}
			}
			else
			{
				throw new Error("Bad condition operator: " + c );
			}
		}
		
		
		public function addConditionProcedure(procedure:LocaleProcedure):void
		{
			if (current == null)
				throw new Error("Bad condition operator: ) or ( 1");
			
			if (operator != "")
				current.addOperator(operator);
			current.addProcedure(procedure);
		}
		
		public function compileCondition():void
		{
			if (current.parent != null)
				throw new Error("Bad condition operator: ) or ( 2");
		}
		
		private var list:Vector.<LocaleProcedure> = new Vector.<LocaleProcedure>();
		private var currentText:TextProcedure;
		
		public function addContentChar(c:String):void
		{
			if (currentText == null)
			{
				currentText = new TextProcedure();
				list.push(currentText);
			}
			currentText.read(c);
		}
		
		public function addContentProcedure(procedure:LocaleProcedure):void
		{
			if (currentText)
			{
				currentText = null;
			}
			list.push(procedure);
		}
		
		public function compileContent():void
		{
			currentText = null;
		}
		
		public function invokeCondition(label:String, data:*):Boolean
		{
			return block.invoke(label, data);
		}
		
		public function invokeContent(label:String, data:*):String
		{
			var result:String = "";
			for each(var procedure:LocaleProcedure in list)
			{
				result += procedure.invoke(label, data);
			}
			return result;
		}
	}
}