package gameEngine 
{
	import flash.display.Sprite;
	import gameEngine.abstract.Component;
	import gameEngine.abstract.IDisableable;
	import gameEngine.abstract.IDisposable;
	import gameEngine.abstract.IEnableable;
	import gameEngine.abstract.IInitalizable;
	import gameEngine.abstract.ILateInitializable;
	import gameEngine.abstract.IUpdatable;
	import gameEngine.reading.RawEntity;
	import gameEngine.utils.Command;
	import gameEngine.utils.Keywords;
	import gameEngine.utils.linking.componentLinking.ComponentLink;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author _monolith
	 */
	public final class Entity extends net.flashpunk.Entity implements IDisposable, IInitalizable
	{
		private var _raw : RawEntity;
		
		private var _parent : Entity;
		private var _scene : Entity;
		
		private var _unique : Boolean;
		
		private var _links : Vector.<ComponentLink>;
		
		private var _entities : Vector.<Entity>;
		private var _components : Vector.<Component>;
		
		private var _initCommand : Command;
		private var _lateInitCommand : Command;
		private var _updateCommand : Command;
		private var _enableCommand : Command;
		private var _disableCommand : Command;
		private var _disposeCommand : Command;
		
		private var _entityName : String;
		
		/**
		 * Creating new componetn
		 * @param	scene root of entity hierarchy
		 */
		public function Entity(unique : Boolean = false, scene : Entity = null) 
		{
			super();
			_unique = unique;
			_scene = scene;
			
			_links = new Vector.<ComponentLink>();
			
			_entities = new Vector.<Entity>();
			_components = new Vector.<Component>();
			
			_initCommand = new Command();
			_lateInitCommand = new Command();
			_updateCommand = new Command();
			_enableCommand = new Command();
			_disableCommand = new Command();
			_disposeCommand = new Command();
		}
		
		/**
		 * Creating new component
		 * @param	type componet type
		 * @return created component
		 */
		public function addComponent(type : Class) : Component
		{
			var component : Component = new type(this, arguments.callee) as Component;
			
			if (null == component)
			{
				throw new ArgumentError("type is not Component");
			}
			
			_components.push(component);
			
			//adding to lists
			if (component is IUpdatable)
			{
				_updateCommand.add((component as IUpdatable).update);
			}
			
			if (component is IInitalizable)
			{
				_initCommand.add((component as IInitalizable).init);
			}
			
			if (component is ILateInitializable)
			{
				_initCommand.add((component as ILateInitializable).lateInit);
			}
			
			if (component is IDisposable)
			{
				_disposeCommand.add((component as IDisposable).dispose);
			}
			
			if (component is IEnableable)
			{
				_enableCommand.add((component as IEnableable).enable);
			}
			
			if (component is IDisableable)
			{
				_disableCommand.add((component as IDisableable).disable);
			}
			
			return component;
		}
		
		/**
		 * Adding component link to resolve references
		 * @param	link	link to resolve
		 */
		public function addComponentLink(link : ComponentLink) : void
		{
			_links.push(link);
		}
		
		/**
		 * Addnig raw graphics data
		 * @param	sprite
		 */
		public function addRawGraphics(sprite : Sprite) : void
		{
			_raw.sprite = sprite;
			
			for each(var e : Entity in _entities)
			{
				e.addRawGraphics(sprite[e._entityName]);
			}
		}
		
		/**
		 * Removing component fron entity
		 * @param	component	componetn to remove
		 */
		public function removeComponent(component : Component) : void
		{
			if (this != component.entity)
			{
				return;
			}
			
			_components.splice(_components.indexOf(component), 1);
			
			if (component is IDisposable)
			{
				(_components as IDisposable).dispose();
			}
		}
		
		/**
		 * Get component by specific name
		 * @param	name Name of requested component 
		 * @return	Component with specified name. 
		 * 			null if no component with specified name found
		 */
		public function getComponentByName(name : String) : Component
		{
			for (var i : int = 0; i < _components.length; ++i)
			{
				var component : Component = _components[i];
				if (name == component.name)
				{
					return component;
				}
			}
			
			return null;
		}
		
		/**
		 * Get component by specific type
		 * @param	type requested type
		 * @return	component with specified type.
		 * 			null if type is not Component
		 * 			null if no component with specified type found
		 */
		public function getComponentByType(type : Class) : Component
		{
			if (!(type is Component))
			{
				return null;
			}
			
			for (var i : int = 0; i < _components.length; ++i)
			{
				var component : Component = _components[i];
				if (component is type)
				{
					return component;
				}
			}
			
			return null;
		}
		
		/**
		 * @private net.flashpunk.Entity override
		 */
		override public function added():void 
		{
			_enableCommand.execute();
		}
		
		/**
		 * @private net.flashpunk.Entity override
		 */
		override public function removed():void 
		{
			_disableCommand.execute();
		}
		
		/**
		 * @private net.flashpunk.Entity override
		 */
		override public function update():void 
		{
			_updateCommand.execute(FP.elapsed);
		}
		
		/**
		 * Disposing entity
		 */
		public function dispose():void 
		{
			for (var i : int = 0; i < _entities.length; ++i)
			{
				_entities[i].dispose();
			}
			_disposeCommand.execute();
			
			_entities.length = 0;
			_components.length = 0;
			_entities = null;
			_components = null;
			_entityName = null;
			_parent = null;
			
			_initCommand.clear();   
			_updateCommand.clear(); 
			_enableCommand.clear(); 
			_disableCommand.clear();
			_disposeCommand.clear();
			
			_initCommand    = null;
			_updateCommand  = null;
			_enableCommand  = null;
			_disableCommand = null;
			_disposeCommand = null;			
		}		
		
		public function init() : void 
		{
			var i : int = 0;
			
			for (i = 0; i < _links.length; ++i)
			{
				_links[i].resolve();
				_links[i].dispose();
				_links[i] = null;
			}
			
			_links.length = 0;
			_links = null;
			
			for (i = 0; i < _entities.length; ++i)
			{
				_entities[i].init();
			}
			
			_initCommand.execute();
		}
		
		public function lateInit() : void
		{
			for (var i : int = 0; i < _entities.length; ++i)
			{
				_entities[i].lateInit();
			}
			
			_lateInitCommand.execute();
			
			_raw.dispose();
			_raw = null;
		}
		
		private function rename() : void
		{
			entityName = _entityName;
			
			for (var i : int = 0; i < _entities.length; ++i)
			{
				_entities[i].rename();
			}
		}
		
		/**
		 * Get entity by specific name.
		 * @param	name 	child entity name
		 * 					"this" = current entity
		 * 					"parent" = parent entity
		 * 					"scene" = scene root entity
		 * @return 	entity by specific Name.
		 */
		public function getEntity(name :String) : Entity
		{
			if (name == Keywords.THIS)
			{
				return this;
			}
			
			if (name == Keywords.PARENT)
			{
				return _parent;
			}
			
			if (name == Keywords.SCENE)
			{
				return _scene;
			}
			
			for (var i : int = 0; i < _entities.length; ++i)
			{
				var entity : Entity = _entities[i];
				
				if (name == entity._entityName)
				{
					return entity;
				}
			}
			
			return null;
		}
		
		// PROPERTIES
		
		public function get initCommand():Command 
		{
			return _initCommand;
		}
		
		public function get updateCommand():Command 
		{
			return _updateCommand;
		}
		
		public function get enableCommand():Command 
		{
			return _enableCommand;
		}
		
		public function get disableCommand():Command 
		{
			return _disableCommand;
		}
		
		public function get disposeCommand():Command 
		{
			return _disposeCommand;
		}
		
		/**
		 * Entity name. Make this name unique to avoid searching problems
		 */
		public function get entityName():String 
		{
			return _entityName;
		}
		
		/**
		 * Entity name. Make this name unique to avoid searching problems
		 */
		public function set entityName(value:String):void 
		{
			_entityName = value;
			var path : String = _entityName;
			var entity : Entity = this;
			
			while (entity._parent)
			{
				entity = _parent;
				path = entity._entityName + "/" + path;
			}	
			
			name = path;
		}
		
		/**
		 * Parent entity
		 */
		public function get parent():Entity 
		{
			return _parent;
		}
		
		/**
		 * Parent entity
		 */
		public function set parent(value:Entity):void 
		{
			if (null != _parent)
			{
				_parent._entities.splice(_parent._entities.indexOf(this), 1);
			}
			
			_parent = value;
			_parent._entities.push(this);
			setScene(_parent._scene)
			rename();
		}
		
		/**
		 * Raw data for creating and initialization
		 */
		public function get raw():RawEntity 
		{
			return _raw;
		}
		
		/**
		 * child entitis
		 */
		public function get entities():Vector.<Entity> 
		{
			return _entities;
		}
		
		/**
		 * attached components
		 */
		public function get components():Vector.<Component> 
		{
			return _components;
		}
		
		/**
		 * Scene entity
		 */
		public function get scene():Entity 
		{
			return _scene;
		}
		
		private function setScene(value:Entity):void
		{
			_scene = value;
			
			for each (var e : Entity in _entities)
			{
				e.setScene(_scene);
			}
		}
	}

}