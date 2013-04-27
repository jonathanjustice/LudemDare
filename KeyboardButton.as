package{
	import flash.display.MovieClip;
	import flash.geom.Point;
	public class KeyboardButton extends MovieClip{
		private var isActive:Boolean = true;
		private var currentLetter:String ="";
		private var currentKeyCode:int =0;
		private var debugTool;
		private var checkState:String="notChecked";
		
		public function KeyboardButton(debug){
			//trace("keyboarBytton");
			debugTool = debug;
			//debugTool.debugTrace("keyboarButton");
			node_1.visible=false;
			node_2.visible=false;
			node_3.visible=false;
			node_4.visible=false;
		}
		
		public function getCheckKeyState():String{
			return checkState;
		}
		
		public function setCheckKeyState(newState:String):void{
			checkState = newState;
		}
		/*
		*if the button was pressed while active,
		*then you get a point 
		*and you get a cool animation
		*and animation should only play once
		*/
		public function checkActive():Boolean{
			//debugTool.debugTrace("currentLetter: " + String(currentLetter));
			
			return isActive;
		}
		
		public function activePressed():void{
			//if(isActive){
				this.gotoAndPlay("pressedActive");
				setActiveState(false);
			//}
		}
		
		public function inactivePressed():void{
			//if(isActive){
				this.gotoAndPlay("pressedInactive");
				setActiveState(false);
			//}
		}
		
		public function setActiveState(newState:Boolean):void{
			isActive = newState;
		}
		
		private function animationLogic():void{
			
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
		
		public function getCenter():Point{
			var centerPoint:Point = new Point();
			centerPoint.x = this.x +this.width/2;
			centerPoint.y = this.y +this.height/2;
			return centerPoint;
		}
		
		public function getCorners():Array{
			var corners:Array = new Array();
			var topLeft:Point = new Point();
			var topRight:Point = new Point();
			var bottomLeft:Point = new Point();
			var bottomRight:Point = new Point();
			topLeft.x = node_1.x + this.x;
			topLeft.y = node_1.y + this.y;
			
			topRight.x = node_2.x + this.x;
			topRight.y = node_2.y + this.y;
			
			bottomLeft.x = node_3.x + this.x;
			bottomLeft.y = node_3.y + this.y;
			
			bottomRight.x = node_4.x + this.x;
			bottomRight.y = node_4.y + this.y;
			
			
			
			corners.push(topLeft,topRight,bottomLeft,bottomRight);
			debugTool.debugTrace("corners: " + String(corners))
			trace(corners);
			return corners;
			
		}
	}
}