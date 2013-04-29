package {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer;
	import flash.events.Event;
	import flash.net.URLRequest; 
	
	public class SoundManager{
		//public var name:String;
		public var channel:SoundChannel = new SoundChannel();
		public var s_hit:sound_hit = new sound_hit();
		public var s_fail:sound_fail = new sound_fail();
		public var s_gameOver:sound_gameOver = new sound_gameOver();
		public var s_hitWrong:sound_wrongPress = new sound_wrongPress();
		public var s_hitMissed:sound_missedPress = new sound_missedPress();
		public var s_music:sound_music = new sound_music();
		
		
		public function SoundManager():void {
			//createSound(soundFileLocation);
			//requestSounds();
		}
		
		public function playSound_hit():void{
			var soundObject:SoundObject = new SoundObject(this,s_hit);
		}
		
		public function playSound_hitWrong():void{
			var soundObject:SoundObject = new SoundObject(this,s_hitWrong);
		}
		
		public function playSound_missedPress():void{
			var soundObject:SoundObject = new SoundObject(this,s_hitMissed);
		}
		
		public function playSound_fail():void{
			var soundObject:SoundObject = new SoundObject(this,s_fail);
		}
		
		public function playSound_gameOver():void{
			var soundObject:SoundObject = new SoundObject(this,s_gameOver);
		}
		
		public function playSound_gameMusic():void{
			var soundObject:SoundObject = new SoundObject(this,s_music);
			soundObject.stopSound();
			soundObject.playSoundonLoop(999,.15);
		}
	}
}