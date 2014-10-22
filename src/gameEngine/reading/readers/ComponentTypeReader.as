package gameEngine.reading.readers 
{
	import gameEngine.Entity;
	import gameEngine.reading.ComponentReaderAttribute;
	import gameEngine.reading.ITypeReader;
	import gameEngine.utils.ComponentNavigation;
	import gameEngine.utils.linking.componentLinking.ComponentLink;
	import gameEngine.utils.Separators;
	/**
	 * ...
	 * @author _monolith
	 */
	public class ComponentTypeReader implements ITypeReader
	{
		public function read(source:String) : * 
		{
			if ( -1 != source.indexOf(Separators.READER))
			{
				source = source.substr(0, source.indexOf(Separators.READER));
			}
			
			var componentName : String = source.split(Separators.COMPONENT)[1];
			var path : Array = (source.split(Separators.COMPONENT)[0]).split(Separators.ENTITY);
			var entity : Entity = ComponentReaderAttribute.currentEntity;
			
			while (path.length > 0)
			{
				entity.getEntity(path[0]);
				path.splice(0, 1);
			}
			
			entity.addComponentLink(new ComponentLink(entity, ComponentReaderAttribute.currentComponent, ComponentReaderAttribute.currentProperty.@name, componentName));
			
			return null;
		}
		
	}

}