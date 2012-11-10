package bitrise.core.crypto
{
	import flash.utils.ByteArray;

	public class CRC
	{
		
		private static const crc32Table:Vector.<uint> = makeCrc32Table();
		
		private static function makeCrc32Table():Vector.<uint> 
		{
			const table:Vector.<uint> = new Vector.<uint>;
			for (var n:int = 0; n < 256; n++) 
			{
				var c:uint = n;
				for (var k:int = 8; --k >= 0; ) 
				{
					if ((c & 1) != 0) 
						c = 0xEDB88320 ^ (c >>> 1);
					else 
						c = c >>> 1;
				}
				table[n] = c;
			}
			return table;
		}
		
		public static function encrypt32(bytes:ByteArray):uint
		{
			var offset:uint = 0;
			var length:uint = 0;
			var c:uint = 0;
			while(--length >= 0)
			{
				c = crc32Table[(c ^ bytes[offset++]) & 0xFF] ^ (c >>> 8);
			}
			return c;
		}
		
	}
}