package ColosseusGame
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Background extends Sprite
	{
		[Embed(source='../images/Level.png')]
		private var BackImg:Class;
		
		private var _background:DisplayObject = new BackImg();
		
		public function Background()
		{
			this.addChild(_background);
		}
	}
}