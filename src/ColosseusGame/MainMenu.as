package ColosseusGame
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class MainMenu extends Sprite
	{
		[Embed(source="../images/Menu.png")]
		private var Background:Class;
		[Embed(source="../images/StartButtonOff.png")]
		private var StartOff:Class;
		[Embed(source="../images/StartButtonAt.png")]
		private var StartAt:Class;
		
		private var _startOff:DisplayObject = new StartOff();
		private var _startAt:DisplayObject = new StartAt();
		private var _background:DisplayObject = new Background();
		private var _stage:Object;
		private var _startButton:Sprite = new Sprite();
		
		public function MainMenu(stage:Object)
			{
				_stage=stage;
				this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			}
		
		private function addedToStageHandler(event:Event):void
			{
				startGame();
				this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			}
		
		private function startGame():void
			{
				this.addChild(_background);
				_startButton.addChild(_startOff);
				_startButton.addChild(_startAt);
				_startAt.visible=false;
				_startButton.x=300;
				_startButton.y=250;
				this.addChild(_startButton);
				
				_startButton.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
				_startButton.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
				_startButton.addEventListener(MouseEvent.CLICK, clickHandler);
			}
		
		private function rollOverHandler(event:Event):void
			{
				_startAt.visible=true;
				_startOff.visible=false;
			}
		
		private function rollOutHandler(event:Event):void
			{
				_startAt.visible=false;
				_startOff.visible=true;
			}
		
		private function clickHandler(event:Event):void
			{
				_startButton.removeEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
				_startButton.removeEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
				_startButton.removeEventListener(MouseEvent.CLICK, clickHandler);
				
				dispatchEvent(new Event("startGame", true));
			}
	}
}