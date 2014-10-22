package gameEngine.abstract 
{
	/**
	 * ...
	 * @author _monolith
	 */
	public interface IUpdatable 
	{
		/**
		 * Component update with time
		 * @param 	deltaTime elapsed time from previous update
		 */
		function update(deltaTime : Number) : void	
	}

}