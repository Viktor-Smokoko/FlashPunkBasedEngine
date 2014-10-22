package racingEngine.reading.readers 
{
	import gameEngine.reading.ITypeReader;
	import gameEngine.utils.Separators;
	/**
	 * Interface implementing custom cast type parsing
	 * @author _monolith
	 */
	public class GroundLineStyleTypeReader implements ITypeReader
	{
		public function read(source : String) : *
		{
			if ( -1 != source.indexOf(Separators.READER))
			{
				source = source.substr(0, source.indexOf(Separators.READER));
			}
		}
	}

}