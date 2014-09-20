package ColosseusGame
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class Character extends MoveSprite
	{
		[Embed(source="../images/Character.png")]
		private var Char:Class;
		[Embed(source="../images/CharacterKilled.png")]
		private var CharKld:Class;
		
		
		private var _character:DisplayObject = new Char();
		private var _characterKilled:DisplayObject = new CharKld();
		
		public function Character()
		{
			_character.x -= _character.width/2;
			_character.y -= _character.height/2; 
			_characterKilled.x-=_characterKilled.width/2;
			_characterKilled.y-=_characterKilled.height/2;
			this.addChild(_character);
			this.addChild(_characterKilled);
			_characterKilled.visible=false;
			
			this.maxv=6;
		}
		
		public function killed():void
		{
			_character.visible=false;
			_characterKilled.visible=true;
		}
	}
}