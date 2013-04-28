package {
import flash.display.MovieClip;
	public class Levels extends MovieClip {
		private var e0:Array;
		private var e1:Array;
		private var e2:Array;
		private var e3:Array;
		private var e4:Array;
		private var e5:Array;
		private var e6:Array;
		private var e7:Array;
		private var e8:Array;
		private var e9:Array;
		private var e10:Array;
		
		private var m1:Array;
		private var m2:Array;
		private var m3:Array;
		private var m4:Array;
		/*private var m5:Array  = new Array();
		private var m6:Array  = new Array();
		private var m7:Array  = new Array();
		private var m8:Array  = new Array();
		private var m9:Array  = new Array();
		private var m10:Array  = new Array();*/
		
		private var h1:Array;
		private var h2:Array ;
		private var h3:Array;
		private var h4:Array;
	/*	private var h5:Array  = new Array();
		private var h6:Array  = new Array();
		private var h7:Array  = new Array();
		private var h8:Array  = new Array();
		private var h8:Array  = new Array();
		private var h9:Array  = new Array();
		private var h10:Array  = new Array();*/
		
		private var difficulty:int = 0;
		private var easyLevels:Array = new Array();
		private var mediumLevels:Array = new Array();
		private var hardLevels:Array = new Array();
		private var insaneLevels:Array = new Array();
		private var stupidLevels:Array = new Array();
		public function Levels (){
			
			theWorstFunction();
			//easyLevels.push(e1, e2, e3, e4, e5, e6, e7, e8, e9, e10);
			easyLevels.push(e0);
			easyLevels.push(e1);
			easyLevels.push(e2);
			easyLevels.push(e3);
			/*easyLevels.push(e4);
			easyLevels.push(e5);
			easyLevels.push(e6);
			easyLevels.push(e7);
			easyLevels.push(e8);
			easyLevels.push(e9);
			easyLevels.push(e10);*/
			
			mediumLevels.push(m1);
			mediumLevels.push(m2);
			mediumLevels.push(m3);
			mediumLevels.push(m4);
			
			hardLevels.push(h1);
			hardLevels.push(h2);
			hardLevels.push(h3);
			hardLevels.push(h4);
			
			
			
			//mediumLevels.push(m1, m2, m3, m4);
			//hardLevels.push(h1,h2,h3,h4);
			//trace("easyLevels",easyLevels);
		}
		
		public function getDelay():Array{
			var keyDelay:int=0;
			var groupDelay:int=0;
			var delays:Array = new Array();
			switch(difficulty) {
				case 0://60 to 90
					keyDelay = 60+ Math.floor(Math.random() * 30);
					groupDelay = keyDelay*2;
					break;
				case 1://50 to 80
					keyDelay = 50+ Math.floor(Math.random() * 30);
					groupDelay = keyDelay*2;
					break;
				case 2://40 to 75
					keyDelay = 40+ Math.floor(Math.random() * 25);
					groupDelay = keyDelay*2;
					break;
				case 3://30 to 50
					keyDelay = 30+ Math.floor(Math.random() * 20);
					groupDelay = keyDelay*2;
					break;
				case 4://15 to 30
					keyDelay = 15+ Math.floor(Math.random() * 15);
					groupDelay = keyDelay*2;
					break;
			}
			delays=[keyDelay,groupDelay]
			return delays;
		}
		
		public function getLevelSequence():Array {
			var sequence:Array = new Array();
			var chunk:int = 0;
			switch(difficulty) {
				case 0:
					chunk = Math.floor(Math.random() * easyLevels.length);
					sequence = easyLevels;
					break;
				case 1:
					chunk = Math.floor(Math.random() * mediumLevels.length);
					sequence = mediumLevels;
					break;
				case 2:
					chunk = Math.floor(Math.random() * hardLevels.length);
					sequence = hardLevels;
					break;
				case 3:
					chunk = Math.floor(Math.random() * insaneLevels.length);
					sequence = insaneLevels;
					break;
				case 4:
					chunk = Math.floor(Math.random() * stupidLevels.length);
					sequence = stupidLevels;
					break;
			}
			//trace("chunk",chunk);
			//trace("sequence",sequence);
			//trace("sequence[chunk]",sequence[chunk]);
			return sequence[chunk];
			
		}
		
		public function setDifficulty(diff:int):void{
			difficulty = diff;
		}
		
		public function getDifficulty():int{
			return difficulty;
		}
		
		private function theWorstFunction():void{
			e0 = [80];
			e1 = [81,87];
			e2 = [90,88,67];
			e3 = [83];
			e4 = [76];
			e5 = [89];
			e6 = [89,89];
			e7 = [70,71];
			e8 = [72];
			e9 = [67];
			e10 = [87];
			
			m1 = [81,65,90];
			m2 = [87,77,80];
			m3 = [69,67,82,66];
			m4 = [84,78,80,67];
			/*m5 = [];
			m6 = [];
			m7 = [];
			m8 = [];
			m9 = [];
			m10 = [];*/
			
			h1 = [69,67,82,66,66,84];
			h2 = [80,77,89,86,81,65];
			h3 = [69,82,70,68,87,71];
			h4 = [74,75,76,72,76,75,76,75,74,72];
		/*	h5 = [];
			h6 = [];
			h7 = [];
			h8 = [];
			h8 = [];
			h9 = [];
			h10 = [];*/
		}
	}
}
	