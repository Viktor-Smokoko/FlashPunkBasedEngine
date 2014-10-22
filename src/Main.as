package 
{
	import designManifest.DesignManifest;
	import entityDeclaration.EntityDeclaration;
	import flash.display.Sprite;
	import flash.events.Event;
	import gameEngine.Entity;
	import gameEngine.entityManagement.EntityFactory;
	import gameEngine.reading.utils.XMLUtils;
	import net.flashpunk.FP;
	
	ApplicationManifest;
	EntityDeclaration;
	
	/**
	 * ...
	 * @author _monolith
	 */
	public class Main extends Sprite 
	{
		public function Main():void 
		{			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{	
			var design : XML = FP.getXML(DesignManifest.DesignManifestXml)
			XMLUtils.read(design);
			
			var entity : Entity = EntityFactory.createEntity(EntityDeclaration.getDeclaration("dynamicObjects/PlayerCar.xml"));
			entity.init();
		}
	}
	
}