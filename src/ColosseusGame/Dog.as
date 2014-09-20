package ColosseusGame
{
	import flash.display.DisplayObject;

	public class Dog extends MoveSprite
	{
		[Embed(source="../images/Dog.png")]
		private var DogImg:Class;
		[Embed(source="../images/Dog1.png")]
		private var DogImg1:Class;
		[Embed(source="../images/Dog2.png")]
		private var DogImg2:Class;
		[Embed(source="../images/DogDead.png")]
		private var DogDead:Class;
		
		private var _dog:DisplayObject = new DogImg();
		private var _dog1:DisplayObject = new DogImg1();
		private var _dog2:DisplayObject = new DogImg2();
		private var _dogDead:DisplayObject = new DogDead();
		
		private var i:int=0;
		
		public function Dog()
		{
			_dog.x-=_dog.width/2;
			_dog.y-=_dog.height/2;
			_dog1.x-=_dog1.width/2;
			_dog1.y-=_dog1.height/2;
			_dog2.x-=_dog2.width/2;
			_dog2.y-=_dog2.height/2;
			_dogDead.x-=_dogDead.width/2;
			_dogDead.y-=_dogDead.height/2;
			
			_dog.visible=false;
			_dog1.visible=false;
			_dog2.visible=false;
			_dogDead.visible=false;
			
			this.addChild(_dog);
			this.addChild(_dog1);
			this.addChild(_dog2);
			this.addChild(_dogDead);
			
			this.maxv=5;
		}
		
		public function animate():void
		{ 	if (i>0&&i<10)  {_dog.visible=true;
							_dog1.visible=false;
						    _dog2.visible=false;}
			if (i>10&&i<20)  {_dog.visible=false;
							 _dog1.visible=true;
							 _dog2.visible=false;}
			if (i>20&&i<30)  {_dog.visible=true;
							_dog1.visible=false;
							_dog2.visible=false;}
			if (i>30&&i<40)  {_dog.visible=false;
							_dog1.visible=false;
							_dog2.visible=true;}
			if (i>40)		 	 i=0;
			i++;
		}
		
		public function killed():void
		{
			_dog.visible=false;
			_dog1.visible=false;
			_dog2.visible=false;
			_dogDead.visible=true;
		}
	}
}