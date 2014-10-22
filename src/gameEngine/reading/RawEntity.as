package gameEngine.reading 
{
	import flash.display.Sprite;
	import gameEngine.abstract.IDisposable;
	/**
	 * Entity constructing materials and instruction
	 * @author _monolith
	 */
	public class RawEntity implements IDisposable
	{
		/**
		 * Represents constructing materials
		 */
		public var sprite : Sprite;
		
		/**
		 * Represents constructing instruction
		 */
		public var xml : XML;
		
		public function dispose():void 
		{
			sprite = null;
			xml = null;
		}
	}

}