package gameEngine.components.abstract 
{
	import gameEngine.abstract.Component;
	import gameEngine.abstract.IDisableable;
	import gameEngine.abstract.IDisposable;
	import gameEngine.abstract.IEnableable;
	import gameEngine.abstract.IRenderable;
	import gameEngine.components.Renderer;
	import gameEngine.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author _monolith
	 */
	public class Renderable extends Component implements IRenderable, IEnableable, IDisableable, IDisposable
	{
		protected var _layer : int;
		protected var _graphics : Graphic;
		protected var _visible : Boolean;
		protected var _renderer : Renderer;
		
		public function Renderable(entity : Entity, caller : Function)
		{
			super(entity, caller);
		}
		
		public function enable():void 
		{
			_graphics.active = true;
			_graphics.visible = _visible;
		}
		
		public function disable():void 
		{
			_graphics.active = false;
			_graphics.visible = false;
		}			

		public function get graphics():Graphic
		{
			return _graphics;
		}
		
		public function get visible():Boolean 
		{
			return _visible;
		}
		
		public function dispose():void 
		{
			if (null != _renderer)
			{
				_renderer.remove(this);
			}
			
			_graphics = null;
		}		
		
		public function get layer():int 
		{
			return _layer;
		}
	}

}