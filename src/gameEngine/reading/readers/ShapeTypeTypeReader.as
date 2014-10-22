package gameEngine.reading.readers 
{
	import gameEngine.reading.ComponentReaderAttribute;
	import gameEngine.reading.ITypeReader;
	import gameEngine.utils.BodyShapeType;
	import gameEngine.utils.Separators;
	/**
	 * 
	 * @author _monolith
	 */
	public class ShapeTypeTypeReader implements ITypeReader
	{		
		public function read(source:String):* 
		{
		 	var type : String = BodyShapeType[source.substr(0, source.indexOf(Separators.READER))];
			
			if (null == type)
			{
				throw new ArgumentError("Wrong shapeType: " + source + " in " + ComponentReaderAttribute.currentEntity.name);
			}
		}
		
	}

}