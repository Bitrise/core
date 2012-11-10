package bitrise.core.utils
{
	public class MathUtil
	{
		/**
		 * Возвращает псевдослучайное число n, где lowest <= n <= highest.
		 * @param lowest Минимальное число, которое может вернутся.
		 * @param highest Максимальное число, которое может вернутся.
		 */
		public static function random(lowest:int, highest:int):int
		{
			return Math.floor(Math.random() * (highest - lowest + 1)) + lowest;
		}
		
		/**
		 * Вычисляет знак числа: 1 если оно положительно, -1 если оно отрицательно, и 0 если оно равно нулю.
		 * @param val Число знак которого возвращается.
		 */
		public static function sign(val:Number):int
		{
			var result:int;
			
			if (val != 0)
			{
				if (val > 0)
					result = 1;
				else
					result = -1;
			}
			else
			{
				result = 0;
			}
			
			return result;
		}
		
		/**
		 * Итерационное экспоненциальное приближение от <code>from</code> до <code>to</code>.
		 * @param from Число от которого производится смещение.
		 * @param to Число к которому производится приближение.
		 * @param min Минимальное значение отступа.
		 * @param speed Скорость экспоненциального приближения [0, 1].
		 * <p>
		 * Обычно используется для задания плавного приближения одного числа к другому по событию ENTER_FRAME.
		 * </p>
		 * <p>
		 * При значении <code>speed = 0</code> приближение становится линейным со сдвигом равным <code>min</code>.
		 * При значении <code>speed = 1</code> приближение приводит результат в точку <code>to</code> за одну итерацию.
		 * </p>
		 */
		public static function motion(from:Number, to:Number, min:Number = 0, speed:Number = 0):Number
		{
			var delta:Number = Math.abs(to - from);
			var shift:Number = Math.max(delta*speed, Math.min(min, delta)) * MathUtil.sign(to - from);
			return from + shift;
		}
	}
}