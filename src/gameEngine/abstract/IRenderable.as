package gameEngine.abstract 
{	
	import net.flashpunk.Graphic;
	/**
	 * ...
	 * @author _monolith
	 */
	public interface IRenderable 
	{
		/**
		 * Graphics component that be renrerered by Renderer
		 */
		function get graphics() : Graphic
		function get layer() : int;
	}
	
}