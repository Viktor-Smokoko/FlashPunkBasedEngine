package gameEngine.abstract 
{
	/**
	 * ...
	 * @author _monolith
	 */
	public interface ILateInitializable 
	{
		/**
		 * Late initialization of component.
		 * Use this function to handle initialization of dependent components
		 */
		function lateInit() : void
	}

}