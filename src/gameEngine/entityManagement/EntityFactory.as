package gameEngine.entityManagement 
{
	import gameEngine.Entity;
	import gameEngine.reading.ComponentReaderAttribute;
	/**
	 * ...
	 * @author _monolith
	 */
	public class EntityFactory 
	{		
		public static function createEntity(xml : XML) : Entity
		{
			var reader : ComponentReaderAttribute = new ComponentReaderAttribute();
			var entity : Entity = new Entity((null != xml.@unique) && (Boolean(xml.@unique)));
			var node : XML;
			
			entity.entityName = xml.@name;
			
			for each (node in xml.Components.Component)
			{
				reader.xml = node;
				reader.addComponent(entity);
			}
			
			for each (node in xml.Entities.Entity)
			{
				var child : Entity = createEntity(node);
				child.parent = entity;
			}
			
			return entity;
		}		
	}

}