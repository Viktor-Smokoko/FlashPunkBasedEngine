package gameEngine.reading.readers 
{
	import gameEngine.reading.ITypeReader;
	import gameEngine.utils.Separators;
	/**
	 * ...
	 * @author _monolith
	 */
	public class CollsionTypeTypeReader implements ITypeReader
	{
		public function read(source:String):* 
		{
			if ( -1 != source.indexOf(Separators.READER))
			{
				source = source.substr(0, source.indexOf(Separators.READER));
			}
			
			return null;
		}
		
	}

}