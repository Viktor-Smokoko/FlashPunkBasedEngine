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
	public class ComponentReaderAttribute 
	{
		private static var _currentEntity : Entity
		private static var _currentComponent : Component;
		private static var _currentProperty : XML;
		
		private var _xml : XML;
		
		public function ComponentReaderAttribute(xml : XML = null) 
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
			
			// get attribues as xmllist
			var nodes : XMLList = _xml.@ * ;
			var typeName : String = _xml.@type;
			
			// preffix and suffix proceiisng
			typeName = XMLUtils.applyPrefix(typeName);
			typeName = XMLUtils.applySuffix(typeName);
			
			var component : Component = entity.addComponent((getDefinitionByName(typeName) as Class));
			_currentComponent = component;
	
			//get type data (REflection)
			var described : XML = describeType(component);
			
			for each (var att : XML in nodes)
			{
				var propertyName : String = att.name();
				
				//crutch. I know 
				if ("type" == propertyName)
				{
					continue;
				}
				
				// get value for parce
				var value : String = att.valueOf();
				
				// get propertyInfo
				var accessor : XMLList = described.accessor.(@name == propertyName);
				_currentProperty = accessor[0];
				//property type name
				var type : String = String(accessor.@type);
				var access : String = String(accessor.@access);
				var array : Array;
				var reader : ITypeReader;	// custom explisit value casting
				
				if ( -1 == access.indexOf("write"))
				{
					continue;
				}
				
				// is property type is Array
				if (-1 != type.indexOf("Array"))
				{
					// get raw array from value
					array = value.split(Separators.ENUMERATION);
					
					for (var i : int = 0; i < array.length; ++i)
					{
						// explicit casting. Id not string value
						if ( -1 != (array[i] as String).indexOf(Separators.READER))
						{
							reader = XMLUtils.getReader((array[i] as String).substr((array[i] as String).indexOf(Separators.READER) + 1));
							array[i] = reader.read(array[i]);
						}
					}
					
					// ignore not exsits property
					if (component.hasOwnProperty(propertyName))
					{
						component[propertyName] = array;
					}
					
					//paranoic memory releasing
					array = null;
				}	
				// is property type is Vector
				else if ( -1 != type.indexOf("vec::Vector"))
				{
					// get raw array from value
					array = value.split(Separators.ENUMERATION);
					
					//get generic type of Vector
					var cast : String = type.substr(type.indexOf("<") + 1);
						cast = cast.substr(0, cast.indexOf(">"));
					var castType : Class = getDefinitionByName(cast) as Class;
					
					var vec : Vector.<Object> = new Vector.<Object>();
					
					for (i = 0; i < array.length; ++i)
					{
						if (array[i].indexOf(Separators.READER))
						{
							reader = XMLUtils.getReader((array[i] as String).substr((array[i] as String).indexOf(Separators.READER) + 1));
							vec.push(reader.read(array[i]));
						}
						else
						{
							reader = XMLUtils.getReader(cast);
							
							// explicit type cast reader got by its type
							if (null != reader)
							{
								vec.push(reader.read(array[i]));
							}
							else
							{
								vec.push(castType(array[i]));
							}
						}
					}
					
					// ignore not exsits property
					if (component.hasOwnProperty(propertyName))
					{
						// creating new generic vector
						component[propertyName] = new (getDefinitionByName(type) as Class)();
						
						// corying values
						for (i = 0; i < array.length; ++i)
						{
							component[propertyName].push(vec[i]);
						}
					}
					
					//paranoic memory releasing
					vec.length - 0;
					vec = null;
				}
				// non enumeration property type
				// ignore not exsits property
				else if (component.hasOwnProperty(propertyName))
				{
					// explicit type cast
					if ( -1 != value.indexOf(Separators.READER))
					{
						component[propertyName] = XMLUtils.getReader(value.split(Separators.READER)[1]).read(value);
					}
					else
					{
						reader = XMLUtils.getReader(type);
						
						// explicit type cast reader got by its type
						if (null != reader)
						{
							component[propertyName] = reader.read(value);
						}
						else
						{
							component[propertyName] = (getDefinitionByName(type) as Class)(value);
						}
					}
				}
			}
			
			_currentEntity = null;
			_currentComponent = null;
			
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
		
		static public function get currentComponent():Component 
		{
			return _currentComponent;
		}
		
		static public function get currentProperty():XML 
		{
			return _currentProperty;
		}
	}

}