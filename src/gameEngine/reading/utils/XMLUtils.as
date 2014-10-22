package gameEngine.reading.utils 
{
	import flash.utils.getDefinitionByName;
	import gameEngine.reading.ITypeReader;
	/**
	 * ...
	 * @author _monolith
	 */
	public class XMLUtils 
	{
		private static var _suffixes : Object;
		private static var _prefixes : Object;
		private static var _readers : Object;
		
		/**
		 * Reading game xml config
		 * @param	xml game config
		 */
		public static function read(xml : XML) : void
		{
			var node : XML;
			for each (node in xml.PrefixAlias.Alias)
			{
				addPrefix(node.@key, node.@value);
			}
			
			for each (node in xml.SuffixAlias.Alias)
			{
				addSuffix(node.@key, node.@value);
			}
			
			for each (node in xml.Readers.Reader)
			{
				addReader(node.@name, node.@type);
			}
		}		
		
		/**
		 * Replacing prefix in source string
		 * @param	source	
		 * @return 	source with replased prefix
		 */
		public static function applyPrefix(source : String) : String
		{
			for (var key : String in _prefixes)
			{
				if (0 == source.indexOf(key))
				{
					return source.replace(key, _prefixes[key]);
				}
			}
			
			return source;
		}
		
		/**
		 * Replacing suffix in source string [NOT IMPLEMENTED]
		 * @param	source
		 * @return 	source with replased suffix
		 */
		public static function applySuffix(source : String) : String
		{
			return source;
		}
		
		/**
		 * Get registered type reader by name
		 * @param	key	keyname of type reader
		 * @return	requested type reader
		 */
		public static function getReader(key : String) : ITypeReader
		{
			if (!_readers.hasOwnProperty(key))
			{
				return null;
			}
			
			return _readers[key];
		}
		
		private static function addSuffix(key : String, value : String) : void
		{
			if (null == _suffixes)
			{
				_suffixes = { };
			}
			
			_suffixes[key] = value;
		}
		
		private static function addPrefix(key : String, value : String) : void
		{
			if (null == _prefixes)
			{
				_prefixes = { };
			}
			
			_prefixes[key] = value;
		}
		
		private static function addReader(key : String, value : String) : void
		{
			if (null == _readers)
			{
				_readers = { };
			}
			
			_readers[key] = new (getDefinitionByName(value) as Class)();
			
			if (!(_readers[key] is ITypeReader))
			{
				throw new ArgumentError(value + " not implements gameEngine.reading::ITypeReader");
			}
		}
		
		public static function dispose() : void
		{
			_suffixes = null;
			_prefixes = null;
			_readers = null;
		}
	}

}