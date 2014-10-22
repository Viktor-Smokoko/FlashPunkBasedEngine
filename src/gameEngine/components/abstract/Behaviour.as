package gameEngine.components.abstract 
{
	import gameEngine.abstract.Component;
	import gameEngine.abstract.IDisableable;
	import gameEngine.abstract.IDisposable;
	import gameEngine.abstract.IEnableable;
	import gameEngine.abstract.IInitalizable;
	import gameEngine.abstract.ILateInitializable;
	import gameEngine.abstract.IUpdatable;
	import gameEngine.Entity;
	
	/**
	 * Basic class for creating custom entity behaviour
	 * @author _monolith
	 */
	public class Behaviour extends Component implements IInitalizable,
														ILateInitializable,
														IEnableable,
														IDisableable,
														IDisposable,
														IUpdatable 
	{
		
		public function Behaviour(entity:Entity, caller:Function) 
		{
			super(entity, caller);
			
		}
		
		/**
		 * Disposing object.
		 * Use this function to release resources and dependencies
		 */
		public override function dispose():void 
		{
			
		}
		
		/**
		 * Disable component.
		 * Use this function to handle deactivation of entity
		 */
		public override function disable():void 
		{
			
		}
		
		/**
		 * Enable component. 
		 * Use this function to handle activation of entity
		 */
		public override function enable():void 
		{
			
		}
		
		/**
		 * Second wave initialization of component.
		 * Use this function to handle initialization of dependent components
		 */
		public override function lateInit():void 
		{
			
		}
		
		/**
		 * Initialization of component.
		 * Use this function to handle initialization of independent components
		 */
		public override function init():void 
		{
			
		}
		
		/**
		 * Component update with time
		 * @param 	deltaTime elapsed time from previous update
		 */
		public function update(deltaTime:Number):void 
		{
			
		}
		
	}

}