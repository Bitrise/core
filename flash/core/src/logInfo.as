package {
	import bitrise.core.logger.Log;
	import bitrise.core.logger.LogLevels;
	
	public function logInfo(reporter:*, ...rest):void {
		Log.bitrise_internal::$log(LogLevels.INFO, reporter, rest);
	}
	
}