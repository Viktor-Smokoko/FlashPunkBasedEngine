package gameEngine 
{
	import flash.events.Event;
	import gameEngine.utils.Keywords;
	import nape.space.Space;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author _monolith
	 */
	public class Scene extends Engine
	{
		private var _napeSpace : Space;
		private var _fpWorld : World;		
		private var _scene : Entity;
		
		public function Scene(width : int, height : int, frameRate : int = 60) 
		{
			super(width, height, frameRate);			
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			_fpWorld = new World();
			_scene = new Entity(null);
			_scene.entityName = Keywords.SCENE;
		}
		
		override public function init():void 
		{
			_scene.init();
			_scene.lateInit();
		}
		
		private function addedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			FP.world = _fpWorld;
			FP.engine = this;
		}
		
		public function get scene():Entity 
		{
			return _scene;
		}
		
	}

}