package gameEngine.components.abstract 
{
	import gameEngine.abstract.Component;
	import gameEngine.abstract.IInitalizable;
	import gameEngine.abstract.ILateInitializable;
	import gameEngine.Entity;
	
	/**
	 * Basic Physics Joint class
	 * @author _monolith
	 */
	public class Joint extends Component implements IInitalizable 
	{
		
		public function Joint(entity:Entity, caller:Function) 
		{
			super(entity, caller);
			
		}

		/**
		 * Override this method to create physics joint
		 */
		override public function init():void 
		{
			
		}
		
	}

}