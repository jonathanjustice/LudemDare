package{
	import flash.display.Sprite;
	import flash.utils.getTimer;
	public class Clock {
		public function Clock() {
			
		}
		
		public function timeElapsedSinceGameStarted():String {
			var milliseconds:uint = getTimer()/1000;
			var hrs:String = (milliseconds > 3600 ? Math.floor(milliseconds / 3600) + ':' : '');
			var mins:String = (hrs && milliseconds % 3600 < 600 ? '0' : '') + Math.floor(milliseconds % 3600 / 60) + ':';
			var secs:String = (milliseconds % 60 < 10 ? '0' : '') + milliseconds % 60;
			var remainingMilliseconds:String = ""+(Number(milliseconds/10) - (Number(secs)*100));
			return hrs + mins + secs + remainingMilliseconds;
		}

		//pass in milliseconds, get time in a format that normal humans (and possibly chimps) can comprehend
		public  function millisecondsToTime(milliseconds:Number):String{
			var hrs:String = (milliseconds > 3600 ? Math.floor(milliseconds / 3600) + ':' : '');
			var mins:String = (hrs && milliseconds % 3600 < 600 ? '0' : '') + Math.floor(milliseconds % 3600 / 60) + ':';
			var secs:String = (milliseconds % 60 < 10 ? '0' : '') + milliseconds % 60;
			var remainingMilliseconds:String = ""+(Number(milliseconds/10) - (Number(secs)*100));
			return hrs + mins + secs + remainingMilliseconds;
		}
		
		public function testFunction():void{
			trace("test");
		}
	}
}
