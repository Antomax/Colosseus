package ColosseusGame
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Pit extends Sprite
	{
		[Embed(source="../images/PitClosed.png")]
		private var PitClsd:Class;
		[Embed(source="../images/PitOpened.png")]
		private var PitOpnd:Class;
		
		private var _pitClosed:DisplayObject = new PitClsd();
		private var _pitOpened:DisplayObject = new PitOpnd();
		
		public function Pit()
		{
			_pitClosed.x-=_pitClosed.width/2;
			_pitClosed.y-=_pitClosed.height/2;
			_pitOpened.x-=_pitOpened.width/2;
			_pitOpened.y-=_pitOpened.height/2;
			this.addChild(_pitClosed);
			this.addChild(_pitOpened);
			
			_pitOpened.visible=false;
		}
		
		public function openPit():void
		{
			_pitClosed.visible=false;
			_pitOpened.visible=true;
		}
	}
}