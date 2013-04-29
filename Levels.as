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
		private var m5:Array;
		private var m6:Array;
		private var m7:Array;
		private var m8:Array;
		private var m9:Array;
		private var m10:Array;
		
		private var h1:Array;
		private var h2:Array ;
		private var h3:Array;
		private var h4:Array;
		private var h5:Array;
		private var h6:Array ;
		private var h7:Array;
		private var h8:Array;
		
		private var i1:Array;
		private var i2:Array ;
		private var i3:Array;
		private var i4:Array;
		private var i5:Array;
		private var i6:Array ;
		private var i7:Array;
		private var i8:Array;
		
		private var s1:Array;
		private var s2:Array ;
		private var s3:Array;
		private var s4:Array;
		private var s5:Array;
		private var s6:Array ;
		private var s7:Array;
		private var s8:Array;
		
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
			mediumLevels.push(m5);
			mediumLevels.push(m6);
			mediumLevels.push(m7);
			mediumLevels.push(m8);
			mediumLevels.push(m9);
			mediumLevels.push(m10);
			
			hardLevels.push(h1);
			hardLevels.push(h2);
			hardLevels.push(h3);
			hardLevels.push(h4);
			hardLevels.push(h5);
			hardLevels.push(h6);
			hardLevels.push(h7);
			
			insaneLevels.push(i1);
			insaneLevels.push(i2);
			insaneLevels.push(i3);
			insaneLevels.push(i4);
			insaneLevels.push(i5);
			insaneLevels.push(i6);
			
			
			stupidLevels.push(h1);
			stupidLevels.push(h2);
			stupidLevels.push(h3);
			stupidLevels.push(h4);
			stupidLevels.push(h5);
			stupidLevels.push(h6);
			
			
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
					chunk = Math.floor(Math.random() * insaneLevels.length);
					sequence = insaneLevels;
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
			//w 87
			//a 65
			//s 83
			//d 68
			e0 = [87,65,83,67];
			e1 = [83,65];
			e2 = [65,67,87];
			e3 = [68];
			
			m1 = [81,87];
			m2 = [90,88,67];
			m3 = [83];
			m4 = [76];
			m5 = [89];
			m6 = [89,89];
			m7 = [70,71];
			m8 = [72];
			m9 = [67];
			m10 = [87];
			
			h1 = [81,65,90];
			h2 = [87,77,80];
			h3 = [69,67,82,66];
			h4 = [84,78,80,67];
			h5 = [90,84,65,89];
			h6 = [84,78,80,67];
			h7 = [85,72,73,76,79,80,87,65,83];
			
			
			
			i1 = [69,67,82,66,66,84];
			i2 = [80,77,89,86,81,65];
			i3 = [69,82,70,68,87,71];
			i4 = [74,75,76,72,76,75,76,75,74,72];
			i5 = [71,72,81,80,67,84,77,89];
			i6 = [90,74,78,72,89,66,71,84,84,70,66,72];
		
		}
	}
}
	