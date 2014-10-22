package sceneDeclaration 
{
	import net.flashpunk.FP;
	/**
	 * Include scenes XML declarations here
	 * Example:
	 *			[Embed(source = "Level1/Scene1.xml", mimeType = "application/octet-stream")] public static var level1_scene1xml : Class;
	 * 			remove "." from path and replace "/" to "_"
	 * @author _monolith
	 */
	public class SceneDeclaration 
	{
		[Embed(source = "Level1/Scene1.xml", mimeType = "application/octet-stream")] public static var level1_scene1xml : Class;		
		public static function getDeclaration(path : String) : XML
		{
			return FP.getXML(EntityDeclaration[path.toLowerCase().replace("/", "_").replace(".", "")]);
		}
	}

}