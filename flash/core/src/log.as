package {
	import bitrise.core.logger.Log;
	import bitrise.core.logger.LogLevels;
	
	public function log(level:uint, reporter:*, ...rest):void {
		Log.bitrise_internal::$log(level, reporter, rest);
	}
	
}