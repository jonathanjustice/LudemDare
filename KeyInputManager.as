package{
	import flash.display.MovieClip;
	import flash.events.*;
	public class KeyInputManager extends MovieClip{
		private var keysCurrentlyPressed:Array = new Array();
		private var theStage;
		private var main;
		private var firstPress:Boolean=false;
		public function KeyInputManager(document,stageRef){
			main = document;
			theStage = stageRef;
			setUp();
		}
		
		public function getFirstPress():Boolean{
			return firstPress;
		}
		
		public function setFirstPress(newState:Boolean):void{
			firstPress = newState;
		}
		
		private function setUp():void{
			
			theStage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			theStage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			
		}
		
		private function removeKeyListeners():void{
			theStage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			theStage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}
		
		private function keyDownHandler(e:KeyboardEvent):void{
			//if a key is pressed, if it was not already pressed, then add it to the array of currently pressed keys
			//trace(e.keyCode);
			var tempKeyCode:int = new int;
			tempKeyCode = e.keyCode;
			var alreadyExists:Boolean = false;
			
			for(var i:int=0; i < keysCurrentlyPressed.length; i++){
				if(keysCurrentlyPressed[i] == e.keyCode){
					alreadyExists = true;
				}
			}
			if(alreadyExists == false){
				keysCurrentlyPressed.push(tempKeyCode);
				//trace("DOWN:",keysCurrentlyPressed);
			}
			main.checkKeys();
			setFirstPress(true);
		}
		
		private function keyUpHandler(e:KeyboardEvent):void{
			//trace("UP Before:",keysCurrentlyPressed);
			//if a key is released, remove it from the array of currently pressed keys
			for(var i:int=0; i < keysCurrentlyPressed.length; i++){
				if(keysCurrentlyPressed[i] == e.keyCode){
					keysCurrentlyPressed.splice(i,1);
					i--;
				}
			}
			//trace("UP After:",keysCurrentlyPressed);
		}
		
		public function getKeysCurrentlyPressed():Array{
			return keysCurrentlyPressed;
		}
	}
}