package gameEngine.components 
{
	import gameEngine.abstract.Component;
	import gameEngine.abstract.IDisableable;
	import gameEngine.abstract.IDisposable;
	import gameEngine.abstract.IEnableable;
	import gameEngine.abstract.ILateInitializable;
	import gameEngine.abstract.IRenderable;
	import gameEngine.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	
	/**
	 * Graphic rendering component
	 * @author _monolith
	 */
	public class Renderer extends Component implements ILateInitializable, IDisposable, IEnableable, IDisableable
	{
		private var _layer : int;
		private var _graphics : Graphiclist;
		private var _visible : Boolean;
		
		private var _renderable : Vector.<IRenderable>;
		
		public function Renderer(entity:Entity, caller:Function) 
		{
			super(entity, caller);
			_renderable = new Vector.<IRenderable>();
		}
		
		public function add(graphics : IRenderable) : void
		{
			_renderable.push(graphics);
			
			if (null != _graphics)	// if initialized
			{
				_graphics.removeAll();
				FP.sortBy(_renderable, "layer");
				for each(var r : IRenderable in _renderable)
				{
					_graphics.add(r.graphics);
				}
			}
		}
		
		public function remove(graphics : IRenderable) : void
		{
			var index : int = _renderable.indexOf(graphics);
			if ( -1 == index)
			{
				return;
			}
			
			_graphics.remove(graphics.graphics);
			_renderable.splice(index, 1);
		}
		
		public function clear() : void
		{
			_graphics.removeAll();
		}
		
		public function dispose():void 
		{
			clear();
			_entity.graphic = null;
			_graphics = null;
			_renderable.splice(0, int.MAX_VALUE);
			_renderable = null;
			_entity = null;
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
		
		public function lateInit():void 
		{
			FP.sortBy(_renderable, "layer");
			_graphics = new Graphiclist();
			
			for each(var r : IRenderable in _renderable)
			{
				_graphics.add(r.graphics);
			}
			
			_entity.layer = _layer;
		}
		
		public function get visible():Boolean 
		{
			return _visible;
		}
		
		public function set visible(value:Boolean):void 
		{
			_visible = value;
			if (_graphics.active)
			{
				_graphics.visible = _visible;
			}
		}
		
		public function get layer():int 
		{
			return _layer;
		}
		
		public function set layer(value:int):void 
		{
			_layer = value;
			if (null != _graphics)
			{
				_entity.layer = layer;
			}
		}
	}

}