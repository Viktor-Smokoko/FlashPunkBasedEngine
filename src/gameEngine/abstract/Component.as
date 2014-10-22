package gameEngine.abstract 
{
	import gameEngine.Entity;
	/**
	 * Basic class
	 * @author _monolith
	 */
	public class Component 
	{
		protected var _entity : Entity;
		protected var _name : String;
		
		/**
		 * Construnctor. Not call this function manually.
		 * Use entity.addComponent to create component
		 * @param	entity
		 * @param	caller
		 */
		public function Component(entity : Entity, caller : Function) 
		{
			if (null == entity)
			{
				throw new ArgumentError("entity must be not null");
			}
			
			if (caller != entity.addComponent)
			{
				throw new ArgumentError("call Entity::addComponents to create component")
			}
			
			_entity = entity;
		}
		
		/**
		 * Attached entity [read-only]
		 */
		public function get entity():Entity 
		{
			return _entity;
		}
		
		/**
		 * Name of the component.
		 * Usefull to determine component in entity with more then one component with one type 
		 */
		public function get name():String 
		{
			return _name;
		}
		
		/**
		 * Name of the component.
		 * Usefull to determine component in entity with more then one component with one type 
		 */
		public function set name(value:String):void 
		{
			_name = value;
		}
		
	}

}