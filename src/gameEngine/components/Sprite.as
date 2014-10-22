package gameEngine.components 
{
	import gameEngine.abstract.IDisposable;
	import gameEngine.abstract.IInitalizable;
	import gameEngine.components.abstract.Renderable;
	import gameEngine.Entity;
	import gameEngine.utils.ComponentNavigation;
	import gameEngine.utils.GraphicsConverter;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author _monolith
	 */
	public class Sprite extends Renderable implements IInitalizable
	{
		public function Sprite(entity:Entity, caller:Function) 
		{
			super(entity, caller); 
		}
		
		public function init():void 
		{
			_graphics = GraphicsConverter.SpriteToImage(_entity.raw.sprite);
			_renderer = (ComponentNavigation.getComponetInParentsByType(_entity, Renderer) as Renderer);
			
			if (null != _renderer)
			{
				_renderer.add(this);
			}
		}
	}

}