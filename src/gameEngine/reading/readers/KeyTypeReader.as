package gameEngine.reading.readers 
{
	import gameEngine.reading.ITypeReader;
	import gameEngine.utils.Separators;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author _monolith
	 */
	public class KeyTypeReader implements ITypeReader 
	{		
		public function read(source:String):* 
		{
			if ( -1 != source.indexOf(Separators.READER))
			{
				source = source.substr(0, source.indexOf(Separators.READER));
			}
			return Key[source];
		}
		
	}

}