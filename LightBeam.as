﻿package {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.events.*;
	public class LightBeam extends MovieClip {
		private var lifeTime:int = 0;
		private var beam:BigSquare = new BigSquare();
		private var targetPoint:Point = new Point();
		private var target:MovieClip = new MovieClip();
		private var fallProgress:int=1;
		private var isActive:Boolean = false;
		private var collideTimeRange:int = 90;
		private var main;
		public var waitingInQueue:String="true";
		public function LightBeam(document) {
			main = document;
			//drawBeam();
			beam.x = 0;
			beam.y = 0;
			this.addChild(beam);
		}
		
		public function updateLoop():void{
			fallProgress++;
			beam.gotoAndPlay(fallProgress);
			beam.square.left.gotoAndPlay(fallProgress);
			beam.square.right.gotoAndPlay(fallProgress);
			beam.square.top.gotoAndPlay(fallProgress);
			beam.square.bottom.gotoAndPlay(fallProgress);
			if(this.x < target.x + 30){
				this.x += 10;
			}
			if(this.x > target.x + 30){
				this.x -= 10;
			}
			if(this.y < target.y + 30){
				this.y += 10;
			}
			if(this.y > target.y +30){
				this.y -= 10;
			}
			if(fallProgress > collideTimeRange){
				isActive = true;
				target.setActiveState(true);
				
			}
			if(fallProgress >= 100){
				target.setActiveState(false);
				this.removeEventListener(Event.ENTER_FRAME,updateLoop);
				main.deleteBeam(this);
			}
		}
		
		
		public function setTarget(newTarget:MovieClip):void{
			target = newTarget;
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