package ColosseusGame
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width="800", height="600", frameRate="60")]
	
	public class Colosseus extends Sprite
	{
		
		
		private var _mainMenu:MainMenu;
		private var _level:Level;
		
		public function Colosseus()
		{
			_mainMenu = new MainMenu(stage);
			stage.addChild(_mainMenu);	
			
			stage.addEventListener("startGame", startGameHandler);
			stage.addEventListener("gameOver", gameOverHandler);
		}
		
		private function startGameHandler(event:Event):void
		{
			stage.removeChild(_mainMenu);
			_mainMenu=null;
			_level = new Level(stage);
			stage.addChild(_level);
		}
		private function gameOverHandler(event:Event):void
		{
			_mainMenu=new MainMenu(stage);
			_level = null;
			stage.addChild(_mainMenu);
		}
	}
}