package {
	import bitrise.core.logger.Log;
	import bitrise.core.logger.LogLevels;
	
	public function logDebug(reporter:*, ...rest):void {
		Log.bitrise_internal::$log(LogLevels.DEBUG, reporter, rest);
	}
	
}