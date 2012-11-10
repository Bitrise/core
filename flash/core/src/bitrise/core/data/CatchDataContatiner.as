package bitrise.core.data
{
	import bitrise.core.reflection.Clazz;
	import bitrise.core.reflection.Reflection;
	import bitrise.core.reflection.fields.Variable;
	
	import flash.errors.IllegalOperationError;

	public class CatchDataContatiner extends DataContainer
	{
		public function CatchDataContatiner()
		{
			super();
			catchChild();
		}
		
		private function catchChild():void {
			const clazz:Clazz = Reflection.describe(this);
			for each (var variable:Variable in clazz.variables) {
				var data:Data = this[variable.name];
				if (data)
				{
					const index:int = _childrens.indexOf(data);
					if (index == -1) {
						data._catch = true;
						data._parent = this;
						data._name = variable.name;
						_childrens.push(data);
					}
				}
			}
		}
	}
}