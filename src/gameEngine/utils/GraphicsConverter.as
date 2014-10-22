package gameEngine.utils 
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import nape.shape.Shape;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author _monolith
	 */
	public class GraphicsConverter 
	{
		public static function SpriteToImage(sprite : Sprite) : Image
		{
			var bounds : Rectangle = sprite.getBounds(sprite.parent);
			var bd : BitmapData = new BitmapData(bounds.width, bounds.height, true, 0);
			var matrix : Matrix = new Matrix();
			matrix.translate( -bounds.x, -bounds.y);
			bd.draw(sprite, matrix);
			
			var image : Image = new Image(bd);
			image.originX = -bounds.x;
			image.originY = -bounds.y;
			
			return image;
		}
		
		public static function SpriteToPolygon(sprite : Sprite) : Shape
		{
			return null;
		}
		
		public static function SpriteToBox(sprite : Sprite) : Shape
		{
			return null;
		}
		
		public static function SpriteToCircle(sprite : Sprite) : Shape
		{
			return null;
		}
	}

}