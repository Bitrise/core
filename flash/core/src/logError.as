package {
	import bitrise.core.logger.Log;
	import bitrise.core.logger.LogLevels;
	
	public function logError(reporter:*, ...rest):void {
		Log.bitrise_internal::$log(LogLevels.ERROR, reporter, rest);
	}
	
}