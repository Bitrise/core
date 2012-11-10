package {
	import bitrise.core.logger.Log;
	import bitrise.core.logger.LogLevels;
	
	public function logWarning(reporter:*, ...rest):void {
		Log.bitrise_internal::$log(LogLevels.WARNING, reporter, rest);
	}
	
}