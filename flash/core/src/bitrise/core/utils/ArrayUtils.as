package bitrise.core.utils
{
	public class ArrayUtils
	{
		
		public static function dynamicToArray(object:Object):Array
		{
			const array:Array = new Array();
			for each(var item:Object in object)
			{
				array.push(item);
			}
			return array;
		}
		
		public static function stringComparison(list1:Array, list2:Array):Boolean
		{
			if (list1.length != list2.length)
				return false;
			for (var i:uint = 0; i < list1.length; i++)
			{
				if (StringUtils.trim(list1[i].toString()) != StringUtils.trim(list2[i].toString()))
					return false;
			}
			return true;
		}
		
	}
}