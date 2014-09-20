package ColosseusGame
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	public class Sounds
	{
		[Embed(source="../sound/CatDead.mp3")]
		private var CatDead:Class;
		[Embed(source="../sound/CharDead.mp3")]
		private var CharDead:Class;
		[Embed(source="../sound/Rohr.mp3")]
		private var Rohr:Class;
		[Embed(source="../sound/Rohr2.mp3")]
		private var Rohr2:Class;
		
		private var _catDead:Sound = new CatDead();
		private var _charDead:Sound = new CharDead();
		private var _rohr:Sound = new Rohr();
		private var _rohr2:Sound = new Rohr2();
		private var _channel:SoundChannel = new SoundChannel();
		private var _vol:SoundTransform = new SoundTransform(0.5,0);
		
		public function Sounds()
		{}
		public function playCatDead():void
		{
			_channel = _catDead.play(0,1,_vol);
		}
		public function playCharDead():void
		{
			_channel = _charDead.play(0,1,_vol);
		}
		public function playCatRohr():void
		{
			if(Math.round(Math.random())==0)
			_channel = _rohr.play(0,1,_vol);
			else  _channel = _rohr2.play(0,1,_vol);
		}
		public function stopSound():void
		{
			_channel.stop();
		}
			
	}
}