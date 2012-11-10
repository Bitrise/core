package bitrise.core.utils
{
	public class FileUtils
	{
		
		public static function getExtension(url:String):String {
			const pos:int = url.lastIndexOf(".");
			if (pos != -1) {
				var extension:String = url.substr(pos);
				if (extension.indexOf("/") == -1 && extension.indexOf("\\") == -1) {
					return extension.toLocaleLowerCase();
				}
			}
			return "";
		}
		
	}
}