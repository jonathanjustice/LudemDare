package{
	import flash.display.MovieClip;
	import flash.text.*;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.display.MovieClip;
	
	public class TextPrintout extends MovieClip{
		private var textField:TextField = new TextField();
		public function TextPrintout(){
			this.addChild(textField);
			textField.x = 25; 
			textField.y = 25; 
			textField.width=500;
			textField.text = "Butts Butts Butts Butts"; 
			
		}
		
		public function debugTrace(newText:String):void {
			textField.text = newText;
		}
	}
}