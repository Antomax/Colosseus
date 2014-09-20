package ColosseusGame
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.ui.Keyboard;
	
	public class Level extends Sprite
	{

		private var _stage:Object;
		private var _background:Background = new Background();
		private var _character:Character = new Character();
		private var _dog:Dog = new Dog();
		private var _pit:Pit = new Pit();
		private var _sounds:Sounds = new Sounds();
		
		private var killedDog:Boolean = false;
		private var killedChar:Boolean = false;
		
		private var _soundOn:Boolean = false;
		private var soundDog:Boolean=true;
		private var soundChar:Boolean=true;


		
		public function Level(stage:Object)
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
			this.addChild(_pit);
			this.addChild(_character);
			this.addChild(_dog);

			
			_character.x=300;
			_character.y=300;
			
			_dog.x=600;
			_dog.y=500;
			
			_pit.x=100;
			_pit.y=100;
			
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			_stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function keyDownHandler(event:KeyboardEvent):void
		{if(!killedChar){
			
			if (event.keyCode==Keyboard.UP||event.keyCode==87) {_character.vy=-_character.maxv;
																_character.rotation=0;}
			if (event.keyCode==Keyboard.DOWN||event.keyCode==83) {_character.vy=_character.maxv;
																  _character.rotation=180;}
			if (event.keyCode==Keyboard.LEFT||event.keyCode==65) {_character.vx=-_character.maxv;
																  _character.rotation=-90};
			if (event.keyCode==Keyboard.RIGHT||event.keyCode==68) {_character.vx=_character.maxv;
																	_character.rotation=90;}
						}
			if (event.keyCode==Keyboard.ESCAPE) stopGame();}
		
		private function keyUpHandler(event:KeyboardEvent):void
		{
		if (event.keyCode==Keyboard.UP||event.keyCode==87&&_character.vy<0)
										_character.vy=0;
										
		if (event.keyCode==Keyboard.DOWN||event.keyCode==83&&_character.vy>0)
											_character.vy=0;
										   
		if (event.keyCode==Keyboard.LEFT||event.keyCode==65&&_character.vx<0)
											_character.vx=0;
	
		if (event.keyCode==Keyboard.RIGHT||event.keyCode==68&&_character.vx>0)
											_character.vx=0;

		}
		
		private function enterFrameHandler(event:Event):void
		{	
			checkBound(_character);
			if(!killedDog){
				_dog.animate();
				if(_dog.hitTestPoint(_character.x,_character.y)) {  killedChar=true;
																	_character.killed();
																	}}
			
			
			if(!killedDog&&!killedChar) capture(_dog, _character);
			if(!killedDog&&killedChar) capture(_dog, _pit);
			
			
	
			
			if(!killedChar){
				move(_character);
				rotateSprite(_character);
				}

			
			
			if(_dog.hitTestPoint(_pit.x,_pit.y)) {
				killedDog=true;
				_pit.openPit();
				_dog.killed();
				_dog.x=_pit.x;
				_dog.y=_pit.y;
			}
			if(_character.hitTestPoint(_pit.x, _pit.y)){
				killedChar=true;
				_pit.openPit();
				_character.killed();
				_character.x=_pit.x;
				_character.y=_pit.y;
			}
			
			sounds();
			
		}

				
		private function move(a:MoveSprite):void
		{
			a.x+=a.vx;
			a.y+=a.vy;
		}
		
		private function checkBound(a:MoveSprite):void
		{
			if(a.x-a.width/2<0)a.x=a.width/2;
			if(a.x>_stage.stageWidth-a.width/2) a.x=_stage.stageWidth-a.width/2;
			if(a.y-a.height/2<0)a.y=a.height/2;
			if(a.y>_stage.stageHeight-a.height/2) a.y=_stage.stageHeight-a.height/2;
		}
		
		private function rotateSprite(a:MoveSprite):void
			{if (a.vx>0&&a.vy==0) {a.rotation=90;
								   a.vx=a.maxv;
								   a.vy=0;}
			 if (a.vx>0&&a.vy>0) {a.rotation=135;
			 					  a.vx=a.maxv/1.414;
			 					  a.vy=a.maxv/1.414;}
			 if (a.vx>0&&a.vy<0) {a.rotation=45;
				 				  a.vx=a.maxv/1.414;
								  a.vy=-a.maxv/1.414;}
			 if (a.vx<0&&a.vy==0) {a.rotation=-90;
			 					   a.vx=-a.maxv;
			 					   a.vy=0;}
			 if (a.vx<0&&a.vy>0) {a.rotation=-135;
			 					  a.vx=-a.maxv/1.414;
			 					  a.vy=a.maxv/1.414;}
			 if (a.vx<0&&a.vy<0) {a.rotation=-45;
			 					  a.vx=-a.maxv/1.414;
			 					  a.vy=-a.maxv/1.414;}
			 if (a.vx==0&&a.vy>0) {a.rotation=180;
			 					   a.vx=0;
			 					   a.vy=a.maxv;}
			 if (a.vx==0&&a.vy<0) {a.rotation=0;
			 					   a.vx=0;
			 					   a.vy=-a.maxv;}
			 
			 }
		
		
		private function capture(b:MoveSprite,aim:Sprite):void
		{
			var distX:int = aim.x - b.x;
			var distY:int = aim.y - b.y;
			
			if(Math.sqrt(distX*distX+distY*distY)<100) b.rotation=b.rotation;
			else{
			if (distX>0)
				b.rotation=(Math.atan(distY/distX)*180/Math.PI)+180;
			if (distX<0)
				b.rotation=(Math.atan(distY/distX)*180/Math.PI);}
			
			if (distX>0)
				b.svx=b.maxv*Math.cos(Math.atan(distY/distX));
			if (distX<0)
				b.svx=-b.maxv*Math.cos(Math.atan(distY/distX));
			
			if (distY>0)	
				b.svy=Math.abs(b.maxv*Math.sin(Math.atan(distY/distX)));
			if (distY<0)
				b.svy=-Math.abs(b.maxv*Math.sin(Math.atan(distY/distX)));
			

			if(Math.sqrt(distX*distX+distY*distY)<100) {b.vx=b.vx*1.1;
														b.vy=b.vy*1.1;
														if (!_soundOn){
														_sounds.playCatRohr();
														_soundOn=true;
														}}
			else{
			_soundOn=false;
			b.vx=b.svx;
			b.vy=b.svy;
			}
			
			b.x+=b.vx;
			b.y+=b.vy;
		}
		
		private function sounds():void
		{
			if(killedDog&&soundDog) {_sounds.playCatDead();
									 soundDog=false;}
			if(killedChar&&soundChar){_sounds.playCharDead();
									  soundChar=false;}
		}
		
			
		private function stopGame():void
		{
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			_stage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
			dispatchEvent(new Event('gameOver',true));
		}
			}
	
}