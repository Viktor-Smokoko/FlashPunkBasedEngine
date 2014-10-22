package gameEngine.utils 
{
	/**
	 * ...
	 * @author _monolith
	 */
	public class Command 
	{
		private var _callbacks : Vector.<Function>;
		
		public function Command() 
		{
			_callbacks = new Vector.<Function>();
		}
		
		public function add(action : Function) : void
		{
			_callbacks.push(action);
		}
		
		public function remove(action : Function) : void
		{
			var index : int = _callbacks.indexOf(action);
			if ( -1 == index)
			{
				return;
			}
			
			_callbacks.splice(index, 1);
		}
		
		public function clear() : void
		{
			_callbacks.length = 0;
		}
		
		public function execute(...args) : void
		{
			for (var i : int = 0; i < _callbacks.length; ++i)
			{
				_callbacks[i](args);
			}
		}
		
	}

}