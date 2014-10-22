package entityDeclaration 
{
	import net.flashpunk.FP;
	/**
	 * Include entity XML declarations here
	 * Example:
	 *			[Embed(source = "dynamicObjects/Player.xml", mimeType = "application/octet-stream")] private static var dynamicobjects_playerxml : Class;
	 * 			remove "." from path and replace "/" to "_"
	 * @author _monolith
	 */
	public class EntityDeclaration 
	{
		[Embed(source = "dynamicObjects/PlayerCar.xml", mimeType = "application/octet-stream")] private static var dynamicobjects_playercarxml : Class;		
		
		public static function getDeclaration(path : String) : XML
		{
			return FP.getXML(EntityDeclaration[path.toLowerCase().replace("/", "_").replace(".", "")]);
		}
	}

}