package bitrise.core.data
{
	import flash.errors.IllegalOperationError;

	public class MainData extends DataContainer
	{
		
		public static const instance:MainData = new MainData();
		
		public function MainData()
		{
			super();
			if (instance)
				throw new IllegalOperationError("");
			$main = this;
		}
	}
}