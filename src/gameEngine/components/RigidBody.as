package gameEngine.components 
{
	import gameEngine.abstract.Component;
	import gameEngine.abstract.IInitalizable;
	import gameEngine.abstract.ILateInitializable;
	import gameEngine.components.abstract.BodyShape;
	import gameEngine.Entity;
	import nape.dynamics.InteractionFilter;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	/**
	 * ...
	 * @author _monolith
	 */
	public class RigidBody extends Component implements IInitalizable, ILateInitializable
	{	
		private var _body : Body;
		private var _mass : Number;
		private var _bodyType : BodyType = BodyType.DYNAMIC;
		private var _material : Material;
		private var _filter : InteractionFilter;
		private var _staticFriction : Number;
		private var _dynamicFriction : Number;
		
		private var _bodyShapes : Vector.<BodyShape>;
		
		public function RigidBody(entity:Entity, caller:Function) 
		{
			super(entity, caller);
		}
		
		public function init():void 
		{
			_body = new Body(_bodyType, Vec2.weak(_entity.x, _entity.y));
		}		
		
		public function addShape(bodyShape:BodyShape):void 
		{
			_bodyShapes.push(bodyShape);
		}		

		public function lateInit():void 
		{
			for (var i : int = 0; i < _bodyShapes.length; ++i)
			{
				_body.shapes.add(_bodyShapes[i].shape);
				_bodyShapes[i].entity.removeComponent(_bodyShapes[i]);
				_bodyShapes[i] = null;
			}
			
			_bodyShapes.length = 0;
			_bodyShapes = null;
		}
		
		public function get body():Body 
		{
			return _body;
		}
		
		public function get mass():Number 
		{
			return _mass;
		}
		
		public function set mass(value:Number):void 
		{
			_mass = value;
		}
		
		public function get bodyType():BodyType 
		{
			return _bodyType;
		}
		
		public function set bodyType(value:BodyType):void 
		{
			_bodyType = value;
		}
		
		public function get staticFriction():Number 
		{
			return _staticFriction;
		}
		
		public function set staticFriction(value:Number):void 
		{
			_staticFriction = value;
		}
		
		public function get dynamicFriction():Number 
		{
			return _dynamicFriction;
		}
		
		public function set dynamicFriction(value:Number):void 
		{
			_dynamicFriction = value;
		}
	}

}