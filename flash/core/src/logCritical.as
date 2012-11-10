package {
	import bitrise.core.logger.Log;
	import bitrise.core.logger.LogLevels;
	
	public function logCritical(reporter:*, ...rest):void {
		Log.bitrise_internal::$log(LogLevels.CRITICAL, reporter, rest);
	}
	
}