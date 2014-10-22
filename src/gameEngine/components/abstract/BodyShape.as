package gameEngine.components.abstract
{
	import gameEngine.abstract.Component;
	import gameEngine.abstract.IInitalizable;
	import gameEngine.abstract.ILateInitializable;
	import gameEngine.components.RigidBody;
	import gameEngine.Entity;
	import gameEngine.utils.BodyShapeType;
	import gameEngine.utils.GraphicsConverter;
	import nape.shape.Shape;
	
	/**
	 * ...
	 * @author _monolith
	 */
	public class BodyShape extends Component implements IInitalizable, ILateInitializable
	{
		private var _shape : Shape;
		private var _collsionGroup : int = -1;
		private var _collsionMask : int = -1;
		private var _shapeType : String = BodyShapeType.Box;
		private var _rigidBody : RigidBody;
		
		public function BodyShape(entity:Entity, caller:Function)
		{
			super(entity, caller);
		}
		
		public function init():void
		{
			switch (_shapeType)
			{
				case BodyShapeType.Circle: 
				{
					_shape = GraphicsConverter.SpriteToCircle(_entity.raw.sprite);
				}break;
				case BodyShapeType.Polygon: 
				{
					_shape = GraphicsConverter.SpriteToPolygon(_entity.raw.sprite);
				}break;
				default :
				{
					_shape = GraphicsConverter.SpriteToBox(_entity.raw.sprite);
				}break;
			}
			
			_rigidBody.addShape(this);
		}
		
		public function lateInit():void
		{
			if (null != _rigidBody)
			{
				_rigidBody.body
			}
		}
		
		public function get shape():Shape 
		{
			return _shape;
		}
		
		public function get collsionGroup():int 
		{
			return _collsionGroup;
		}
		
		public function set collsionGroup(value:int):void 
		{
			_collsionGroup = value;
		}
		
		public function get collsionMask():int 
		{
			return _collsionMask;
		}
		
		public function set collsionMask(value:int):void 
		{
			_collsionMask = value;
		}
		
		public function get shapeType():String 
		{
			return _shapeType;
		}
		
		public function set shapeType(value:String):void 
		{
			_shapeType = value;
		}
		
		public function get rigidBody():RigidBody 
		{
			return _rigidBody;
		}
		
		public function set rigidBody(value:RigidBody):void 
		{
			_rigidBody = value;
		}
	
	}

}