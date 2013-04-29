package {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer;
	import flash.events.Event;
	import flash.net.URLRequest; 
	
	public class SoundObject{
		public var name:String;
		private var soundManager;
		public var soundFile:Sound = new Sound();
		public var channel:SoundChannel = new SoundChannel();
		private var musicSound:Sound 
		public function SoundObject(manager,sound):void {
			soundManager = manager;
			soundFile = sound;
			//requestSounds();
			playSound(1,.15);
		}
		
		public function playSound(number_of_times_to_play:int,newVolume:Number):void{
			var soundVolume:Number = newVolume;
			var volume_sound_transform:SoundTransform = new SoundTransform(soundVolume,0);
            channel.soundTransform = volume_sound_transform;
			channel = soundFile.play(0, number_of_times_to_play);
		}
		
		public function playSoundonLoop(number_of_times_to_play:int,newVolume:Number):void{
			var soundVolume:Number = newVolume;
			var volume_sound_transform:SoundTransform = new SoundTransform(soundVolume,0);
            channel.soundTransform = volume_sound_transform;
			channel = soundFile.play(0, 999);
		}

		public function stopSound():void {
			trace("soundobject: stopSound");
			channel.stop();
			channel.removeEventListener(Event.SOUND_COMPLETE, sound_completed);
		}
		
		public function check_for_sound_complete():void {
			channel.addEventListener(Event.SOUND_COMPLETE, sound_completed);
		}
		
		private function sound_completed($evt:Event):void{
			trace("sound completed");
			channel.stop();
			//do some logic here
			channel.removeEventListener(Event.SOUND_COMPLETE, sound_completed);
			//remove soundObject
			soundManager.removeChild(this);
		}
	}
}