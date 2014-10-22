package gameEngine.utils.linking.componentLinking 
{
	import gameEngine.abstract.Component;
	import gameEngine.abstract.IDisposable;
	import gameEngine.Entity;
	/**
	 * Resolver component reference to another component
	 * @author _monolith
	 */
	public class ComponentLink implements IDisposable
	{
		private var _enity : Entity;
		private var _target : Component;
		private var _propertyName : String;
		private var _componentName : String;
		
		/**
		 * Resolver component reference to another component
		 * @param	entity			owner of requested component
		 * @param	target			requesing component
		 * @param	propertyName	property to resolve reference
		 * @param	componentName	requested component name
		 */
		public function ComponentLink(entity : Entity, target : Component, propertyName : String, componentName : String)
		{
			_enity = entity;
			_target = target;
			_propertyName = propertyName;
			_componentName = componentName;
		}
		
		/**
		 * Linking components
		 */
		public function resolve() : void
		{
			_target[_propertyName] = _enity.getEntity(_componentName);
		}

		public function dispose():void 
		{
			_enity = null;
			_target = null;
			_propertyName = null;
			_componentName = null;
		}
	}

}