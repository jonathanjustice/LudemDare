package{
	import flash.display.MovieClip;
	public class KeyboardButton extends MovieClip{
		private var isActive:Boolean = true;
		private var currentLetter:String ="";
		private var currentKeyCode:int =0;
		private var debugTool;
		public function KeyboardButton(debug){
			//trace("keyboarBytton");
			debugTool = debug;
			debugTool.debugTrace("keyboarBytton");
		}
		/*
		*if the button was pressed while active,
		*then you get a point 
		*and you get a cool animation
		*and animation should only play once
		*/
		public function checkButton():Boolean{
			//debugTool.debugTrace("currentLetter: " + String(currentLetter))
			
			return isActive;
		}
		
		public function activePressed():void{
			if(isActive){
				animationLogic();
				setActiveState(false);
			}
		}
		
		public function setActiveState(newState:Boolean):void{
			isActive = newState;
		}
		
		private function animationLogic():void{
			this.gotoAndPlay("pressed");
		}
		
		public function setLetter(letter:String):void{
			currentLetter = letter;
			this.txt_letter.text = currentLetter;
		}
		
		public function getLetter():String{
			return currentLetter;
		}
		
		public function setKeyCode(code:int):void{
			currentKeyCode = code;
		}
		
		public function getKeyCode():int{
			return currentKeyCode;
		}
	}
}