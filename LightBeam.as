package {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	public class LightBeam extends MovieClip {
		private var lifeTime:int = 0;
		private var beam:BigSquare = new BigSquare();
		private var target:Point = new Point();
		public function LightBeam() {
			//drawBeam();
			beam.x = 400;
			beam.y = 400;
			this.addChild(beam);
			playBeam();
		}
		
		private function playBeam():void{
			beam.gotoAndPlay(1);
			beam.square.left.gotoAndPlay(1);
			beam.square.right.gotoAndPlay(1);
			beam.square.top.gotoAndPlay(1);
			beam.square.bottom.gotoAndPlay(1);
		}
		
		public function drawBeam():void{
			var rect:Sprite = new Sprite;
			//rect.graphics.lineStyle(0,0x000000);
			rect.graphics.beginFill(0xFFFFFF);
			rect.graphics.drawRect(0,0,300,100);
			rect.graphics.endFill();
			this.addChild(rect);
		}
	}
}