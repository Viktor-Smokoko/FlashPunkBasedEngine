package gameEngine.reading 
{
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import gameEngine.abstract.Component;
	import gameEngine.Entity;
	import gameEngine.reading.utils.XMLUtils;
	import gameEngine.utils.Separators;
	/**
	 * ...
	 * @author _monolith
	 */
	public class ComponentReaderTag 
	{
		private static var _currentEntity : Entity
		
		private var _xml : XML;
		
		public function ComponentReaderTag(xml : XML) 
		{
			_xml = xml;
		}
		
		/**
		 * Creating component from xml tag
		 * XML Parsing
		 * Auto cast by acessor type or explicit cast by specified Reader
		 * @param	entity owner of created component
		 * @return 	created component
		 */
		public function addComponent(entity : Entity) : Component
		{
			_currentEntity = entity;
			
			var attributes : XMLList = _xml.*;
			var typeName : String = _xml.type;
			var component : Component = entity.addComponent((getDefinitionByName(typeName) as Class));
	
			var described : XML = describeType(component);
			
			for each (var att : XML in attributes)
			{
				var propertyName : String = att.name();
				
				if ("type" == propertyName)
				{
					continue;
				}
				
				var value : String = att.valueOf();
				var accessor : XMLList = described.accessor.(@name == propertyName);
				var type : String = String(accessor.@type);
				var access : String = String(accessor.@access);
				var array : Array;
				
				if ( -1 == access.indexOf("write"))
				{
					continue;
				}
				
				if (-1 != type.indexOf("Array"))
				{
					array = value.split(Separators.ENUMERATION);
					
					for (var i : int = 0; i < array.length; ++i)
					{
						if ( -1 != (array[i] as String).indexOf(Separators.READER))
						{
							array[i] = XMLUtils.getReader((array[i] as String).substr((array[i] as String).indexOf(Separators.READER) + 1)).read(array[i]);
						}
					}
					
					if (component.hasOwnProperty(propertyName))
					{
						component[propertyName] = array;
					}
					
					array = null;
				}				
				else if ( -1 != type.indexOf("vec::Vector"))
				{
					array = value.split(Separators.ENUMERATION);
					var cast : String = type.substr(type.indexOf("<") + 1);
						cast = cast.substr(0, cast.indexOf(">"));
					var castType : Class = getDefinitionByName(cast) as Class;
					
					var vec : Vector.<Object> = new Vector.<Object>();
					
					for (i = 0; i < array.length; ++i)
					{
						if (array[i].indexOf(Separators.READER))
						{
							vec.push( XMLUtils.getReader((array[i] as String).substr((array[i] as String).indexOf(Separators.READER) + 1)).read(array[i]));
						}
						else
						{
							vec.push(castType(array[i]));
						}
					}
					
					component[propertyName] = new (getDefinitionByName(type) as Class)();
					
					for (i = 0; i < array.length; ++i)
					{
						component[propertyName].push(vec[i]);
					}
					
					vec.length - 0;
					vec = null;
				}
				else if (component.hasOwnProperty(propertyName))
				{
					if ( -1 != value.indexOf(Separators.READER))
					{
						component[propertyName] =  XMLUtils.getReader(value.split(Separators.READER)[1]).read(value);
					}
					else
					{
						component[propertyName] = (getDefinitionByName(type) as Class)(value);
					}
				}
			}
			
			_currentEntity = null;
			
			return component;
		}
		
		/**
		 * XML source for creating component
		 */
		public function get xml():XML 
		{
			return _xml;
		}
		
		/**
		 * XML source for creating component
		 */
		public function set xml(value:XML):void 
		{
			_xml = value;
		}		
		
		static public function get currentEntity():Entity 
		{
			return _currentEntity;
		}
	}

}