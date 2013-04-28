package{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import AngleStuff;
	public class winAnim extends MovieClip{
		private var speed: int = 10;
		private var deltas:Point = new Point(0,0);
		private var decay:int=30;
		private var maxLife:int=30;
		private var streak:int=0;
		private var main;
		private var rotationalVelocity:Number=0;
		public function winAnim(){
			this.shape.gotoAndStop(1);
			//this.rotation = Math.floor(Math.random()*360)-180;
			
		}
		
		public function setNewPropoerties(document,rot:Number,newStreak:int):void{
			
			main = document;
			streak = newStreak;
			propertiesLogic();
			this.rotation = rot;
			deltas = AngleStuff.degreesToSlope(this.rotation);
			
		}
		
		public function propertiesLogic():void{
			if(streak < 3){
				rotationalVelocity = (Math.random()*4)-2;
			}else if(streak >= 3 && streak <6){
				rotationalVelocity = (Math.random()*6)-3;
				this.shape.gotoAndStop("hexagon");
			}else if(streak >= 6 && streak <9){
				rotationalVelocity = (Math.random()*10)-5;
				this.shape.gotoAndStop("circle");
			}
			else if(streak >= 9 && streak <12){
				rotationalVelocity = (Math.random()*16)-7;
			}
			else if(streak >= 13 && streak <15){
				rotationalVelocity = (Math.random()*20)-10;
			}
			
			decay = maxLife;
		}
		
		public function updateLoop():void{
			this.rotation += rotationalVelocity;
			this.x += (deltas.x * speed *(decay/maxLife));
			this.y += (deltas.y * speed *(decay/maxLife));
			this.scaleX = ((maxLife-decay)*(decay/maxLife))*.25;
			this.scaleY = ((maxLife-decay)*(decay/maxLife))*.25;
			
			decay--;
			
			if(decay<=0){
				main.deleteWinAnim(this);
			}
		}
	}
}