package gameEngine.reading.readers 
{
	import gameEngine.reading.ComponentReaderAttribute;
	import gameEngine.reading.ITypeReader;
	import gameEngine.utils.Separators;
	import nape.phys.BodyType;
	/**
	 * ...
	 * @author _monolith
	 */
	public class BodyTypeTypeReader implements ITypeReader
	{
		public function read(source:String):* 
		{
			if ( -1 != source.indexOf(Separators.READER))
			{
				source = source.substr(0, source.indexOf(Separators.READER));
			}
			
			var type : BodyType = BodyType[source];
			
			if (null == type)
			{
				throw new ArgumentError("Wrong bodyType: " + source + " in " + ComponentReaderAttribute.currentEntity.name);
			}
			
			return type;
		}
		
	}

}