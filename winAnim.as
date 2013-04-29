package{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import AngleStuff;
	public class winAnim extends MovieClip{
		private var speed: int = 15;
		private var deltas:Point = new Point(0,0);
		private var decay:int=20;
		private var maxLife:int=20;
		private var streak:int=0;
		private var main;
		private var rotationalVelocity:Number=0;
		private var rank:String="";
		public function winAnim(){
			//this.shape.gotoAndStop(1);
			//this.rotation = Math.floor(Math.random()*360)-180;
			
		}
		
		public function setNewPropoerties(document,rot:Number,newStreak:int,newRank,extraVelocityX:Number,extraVelocityY:Number):void{
			rank = newRank;
			main = document;
			streak = newStreak;
			propertiesLogic();
			this.rotation = rot;
			deltas = AngleStuff.degreesToSlope(this.rotation);
			deltas.x += extraVelocityX;
			deltas.y += extraVelocityY;
			
		}
		
		private function propertiesLogic():void{
			var colorNum:int=99;
			var shapeNum:int=99;
			//trace(rank);
			if(rank == "primary"){
				if(streak < 3){
					rotationalVelocity = (Math.random()*4)-2;
					colorNum = 99;
					shapeNum = 99;
				}else if(streak >= 5 && streak <10){
					rotationalVelocity = (Math.random()*6)-3;
					colorNum = Math.floor(Math.random()*2);
					shapeNum = 99;
					
				}else if(streak >= 10 && streak <20){
					rotationalVelocity = (Math.random()*10)-5;
					colorNum = Math.floor(Math.random()*3);
					shapeNum = Math.floor(Math.random()*2);
					
				}
				else if(streak >= 20 && streak <30){
					rotationalVelocity = (Math.random()*16)-7;
					colorNum = Math.floor(Math.random()*3)+1;
					shapeNum = Math.floor(Math.random()*3);
				}
				else if(streak >= 30){
					rotationalVelocity = (Math.random()*20)-10;
					colorNum = Math.floor(Math.random()*3)+1;
					shapeNum = Math.floor(Math.random()*4);
				}
				decay = 15;
			}
			else if(rank == "secondary"){
				rotationalVelocity = (Math.random()*20)-10;
				colorNum = Math.floor(Math.random()*6)+2;
				shapeNum = Math.floor(Math.random()*3)+5;
				decay = 9;
			}
			else if(rank == "tertiary"){
				rotationalVelocity = (Math.random()*20)-10;
				colorNum = Math.floor(Math.random()*8)+1;
				shapeNum = Math.floor(Math.random()*8)+3;
				decay = 5;
			}
			decay = maxLife;
			selectColor(colorNum);
			selectShape(shapeNum);
		}
		
		private function selectColor(colorNumber:int):void{
			switch(colorNumber){
				case 0:
					this.body.shape.gotoAndStop("square");
					break;
				case 1:
					this.body.shape.gotoAndStop("rectangle");
					break;
				case 2:
					this.body.shape.gotoAndStop("trapezoid");
					break;
				case 3:
					this.body.shape.gotoAndStop("triangle");
					break;
				case 4:
					this.body.shape.gotoAndStop("circle");
					break;
				case 5:
					this.body.shape.gotoAndStop("orientalBulb");
					break;
				case 6:
					this.body.shape.gotoAndStop("bulb");
					break;
				case 7:
					this.body.shape.gotoAndStop("head");
					break;
				case 8:
					this.body.shape.gotoAndStop("hexagon");
					break;
				case 9:
					this.body.shape.gotoAndStop("star");
					break;
				case 10:
					this.body.shape.gotoAndStop("oval");
					break;
				case 99:
					this.body.shape.gotoAndStop("square");
					break;
			}
		}
		
		private function selectShape(colorNumber:int):void{
			switch(colorNumber){
				case 0:
					this.body.gotoAndStop("whiteToBlue");
					break;
				case 1:
					this.body.gotoAndPlay("whiteToBlue");
					break;
				case 2:
					this.body.gotoAndPlay("whiteToYellow");
					break;
				case 3:
					this.body.gotoAndPlay("whiteToGreen");
					break;
				case 4:
					this.body.gotoAndPlay("whiteToRed");
					break;
				case 5:
					this.body.gotoAndPlay("whiteToPurple");
					break;
				case 6:
					this.body.gotoAndPlay("whiteToCyan");
					break;
				case 7:
					this.body.gotoAndPlay("whiteToOrange");
					break;
				case 8:
					this.body.gotoAndPlay("whiteToPink");
					break;
				case 99:
					this.body.gotoAndStop("whiteToBlue");
					break;
			}
		}
		
		public function updateLoop():void{
			this.rotation += rotationalVelocity;
			if(rank == "primary"){
				this.x += (deltas.x * speed *(decay/maxLife));
				this.y += (deltas.y * speed *(decay/maxLife));
				this.scaleX = ((maxLife-decay) *(decay/maxLife))/3;
				this.scaleY = ((maxLife-decay) *(decay/maxLife))/3;
				
			}else if(rank == "secondary"){
				this.x += (deltas.x * speed *(decay/maxLife))/3;
				this.y += (deltas.y * speed *(decay/maxLife))/3;
				this.scaleX = ((maxLife-decay) *(decay/maxLife))/2;
				this.scaleY = ((maxLife-decay) *(decay/maxLife))/2;
				
			}else if(rank == "tertiary"){
				this.x += (deltas.x * speed *(decay/maxLife))/1.5;
				this.y += (deltas.y * speed *(decay/maxLife))/1.5;
				this.scaleX = ((maxLife-decay) *(decay/maxLife));
				this.scaleY = ((maxLife-decay) *(decay/maxLife));
				
			}
			
			
			
			decay--;
			
			if(decay<=0){
				spawnMoreAnims();
				main.deleteWinAnim(this);
			}
		}
		
		private function spawnMoreAnims():void{
			if(streak < 10){
				
			}
			if(streak >= 20){
				if(rank == "primary"){
					main.createWinAnim(this.x,this.y,"secondary",deltas.x,deltas.y);
					//trace("new secondary");
				}
			}
			if(streak >= 30){
				//trace("works");
				if(rank == "secondary"){
					main.createWinAnim(this.x,this.y,"tertiary",deltas.x,deltas.y);
					
				}
			}
		}
	}
}