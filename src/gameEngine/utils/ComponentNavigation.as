package gameEngine.utils 
{
	import gameEngine.abstract.Component;
	import gameEngine.Entity;
	/**
	 * ...
	 * @author _monolith
	 */
	public class ComponentNavigation 
	{
		/**
		 * Finding first component in entity or downwards in hierarchy.
		 * null if component not found.
		 * Not recomended to use this function in update routine in performance reasons 
		 * @param	entity 		source entity to finding
		 * @param	name		component name
		 * @return	first component in entity or its children with specific name
		 */
		public static function getComponentInChildernByName(entity : Entity, name : String) : Component
		{
			var component : Component = entity.getComponentByName(name);
			
			if (null != component)
			{
				return component;
			}
			
			var entities : Vector.<Entity> = entity.entities;
			
			for (var i : int = 0; i < entities.length; ++i)
			{
				component = entities[i].getComponentByName(name);
				
				if (null != component)
				{
					return component;
				}
			}
			
			return null;
		}
		
		/**
		 * Finding first component in entity or downwards in hierarchy.
		 * null if component not found,
		 * null if type is not derive from gameEngine.abstract::Component.
		 * Not recomended to use this function in update routine in performance reasons
		 * @param	entity 		source entity to finding
		 * @param	type		component type
		 * @return 	first component in entity or its children with specific type
		 */
		public static function getComponentInChildernByType(entity : Entity, type : Class) : Component
		{
			var component : Component = entity.getComponentByType(type);
			
			if (null != component)
			{
				return component;
			}
			
			var entities : Vector.<Entity> = entity.entities;
			
			for (var i : int = 0; i < entities.length; ++i)
			{
				component = entities[i].getComponentByType(type);
				
				if (null != component)
				{
					return component;
				}
			}
			
			return null;
		}
		
		/**
		 * [NOT IMPLEMENTED] Finding all component in entity or downwards in hierarchy. 
		 * Not recomended to use this function in update routine in performance reasons
		 * @param	entity  source entity to finding
		 * @param	name	component name
		 * @param	depth	hierarhicly depth
		 * @return	Enumeration with all found component
		 */
		public static function getAllComponentsInChildrenByName(entity : Entity, name:String, depth : uint = uint.MAX_VALUE) : Vector.<Component>
		{
			var components : Vector.<Component> = new Vector.<Component>();
			getAllComponentsInChildrenByNameRecursive(entity, name, components, depth);
			
			throw "Not implemented"
			
			return components;
		}
		
		private static function getAllComponentsInChildrenByNameRecursive(entity : Entity, name:String, components : Vector.<Component>, depth : uint = uint.MAX_VALUE) : void
		{
			
		}
		
		/**
		 * Finding component in entity or upwards in hierarchy.
		 * Not recomended to use this function in update routine in performance reasons
		 * @param	entity source entity to finding
		 * @param	name   component name
		 * @return  first component in entity or its parent with specific name
		 */
		public static function getComponetInParentsByName(entity : Entity, name : String) : Component
		{
			var component : Component = entity.getComponentByName(name);
			if (null != component)
			{
				return component;
			}
			
			if (null == entity.parent)
			{
				return null;
			}
			
			return getComponetInParentsByName(entity.parent, name);
		}
		
		/**
		 * Finding component in entity or upwards in hierarchy.
		 * Not recomended to use this function in update routine in performance reasons
		 * @param	entity source entity to finding
		 * @param	type   component type
		 * @return  first component in entity or its parent with specific type
		 */
		public static function getComponetInParentsByType(entity : Entity, type : Class) : Component
		{
			var component : Component = entity.getComponentByType(type);
			if (null != component)
			{
				return component;
			}
			
			if (null == entity.parent)
			{
				return null;
			}
			
			return getComponetInParentsByType(entity.parent, type);
		}
	}

}