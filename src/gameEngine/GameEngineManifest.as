package gameEngine 
{
	import designManifest.DesignManifest;
	import gameEngine.abstract.Component;
	import gameEngine.components.RigidBody;
	import gameEngine.components.Renderer;
	import gameEngine.components.Sprite;
	import gameEngine.Entity;
	import gameEngine.reading.ComponentReaderAttribute;
	import gameEngine.reading.ComponentReaderTag;
	import gameEngine.reading.RawEntity;
	import gameEngine.reading.readers.BodyTypeTypeReader;
	import gameEngine.reading.readers.CollsionTypeTypeReader;
	import gameEngine.reading.readers.ComponentTypeReader;
	import gameEngine.reading.readers.KeyTypeReader;
	import gameEngine.reading.readers.ShapeTypeTypeReader;
	
	/**
	 * Entity including
	 */
	Entity;
	
	/**
	 * Components including
	 */
	Renderer;
	Component;
	RigidBody;
	Sprite;
	
	/**
	 * Type readers including
	 */
	ComponentTypeReader;
	BodyTypeTypeReader;
	CollsionTypeTypeReader;
	KeyTypeReader;
	ShapeTypeTypeReader;
	
	/**
	 * Component readers including
	 */
	ComponentReaderAttribute;
	ComponentReaderTag;
	
	/**
	 * Raw entity data including
	 */
	RawEntity;
	
	/**
	 * Design manifest  including
	 */
	DesignManifest;
	
	/**
	 * ...
	 * @author _monolith
	 */
	public class GameEngineManifest 
	{
		
		public function GameEngineManifest() 
		{
			
		}
		
	}

}