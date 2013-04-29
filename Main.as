package {
import flash.display.MovieClip;
import flash.events.*;
import flash.geom.Point;
import flash.utils.getTimer;
import Clock;
	public class Main extends MovieClip {
		private var initialKeyLetters:Array = new Array();
		private var initialKeyCodes:Array = new Array();
		private var keyboardKeys:Array = new Array();
		private var isKeysEnabled:Boolean=true;
		private var currentlyPressedKeys:Array = new Array();
		private var keyInputManager:KeyInputManager;
		private var successStreak:int = 0;
		private var failStreak:int = 0;
		private var maxFailStreak:int = 5;
		private var totalDrops:int=0;
		private var textPrintout:TextPrintout = new TextPrintout();
		private var fails:TextPrintout = new TextPrintout();
		private var wins:TextPrintout = new TextPrintout();
		//private var difficulty:int=1;
		private var levels:Levels = new Levels();
		private var beamQueue:int=0
		private var fallingBeams:Array = new Array();
		private var waitingBeams:Array = new Array();
		private var beamTimer:int=0;
		private var beamDelay:int=120;
		private var delays:Array = new Array();
		private var startScreen:Screen_Start = new Screen_Start();
		private var endScreen:Screen_End = new Screen_End();
		private var startTimer:int=0;
		private var isGameOver:Boolean=false;
		private var isGameStarted:Boolean=false;
		public var soundManager:SoundManager = new SoundManager();
		private var gameBackground:Background = new Background();
		private var winAnims:Array = new Array();
		private var timeField:tField = new tField();
		public var clock:Clock;
		public function Main() {
			stage.addChild(gameBackground);
			launchGame();
		}
		
		public function createWinAnim(spawnX:Number,spawnY:Number,rank:String,extraVelocityX:Number,extraVelocityY:Number):void{
			var amount:int = 0;
			if(totalDrops < 3){
				amount = 3 + Math.floor(Math.random()*3);
			}else if(totalDrops >= 3 && totalDrops < 6){
				amount = 4 + Math.floor(Math.random()*4);
			}
			else if(totalDrops >= 6 && totalDrops < 9){
				amount = 5 + Math.floor(Math.random()*5);
			}
			else if(totalDrops >= 9 && totalDrops < 12){
				amount = 6 + Math.floor(Math.random()*6);
			}
			else if(totalDrops >= 12 && totalDrops < 9000){
				amount = 10 + Math.floor(Math.random()*10);
			}
			if(rank == "secondary"){
				amount = 1 + Math.floor(Math.random()*2);
			}
			if(rank == "tertiary"){
				amount = 1 + Math.floor(Math.random()*3);
			}
			
			for(var i:int=0;i<amount;i++){
				var rot:int = (359/i) + Math.floor(1+(Math.random()*360));
				var anim:winAnim = new winAnim();
				anim.setNewPropoerties(this,rot,totalDrops,rank,extraVelocityX,extraVelocityY);
				anim.x = spawnX+30;
				anim.y = spawnY+30;
				winAnims.push(anim);
				stage.addChild(anim);
			}
			
		}
		
		private function launchGame():void{
			soundManager.playSound_gameMusic();
			gameBackground.overlay.gotoAndStop(1);
			createKeyInputManager();
			setInitialKeyLetters();
			textPrintout.visible=true;
			wins.visible=true;
			fails.visible=true;
			wins.y +=40;
			fails.y+=20;
			//fails.debugTrace("0000000000000000000000000");
			createStartScreen();
			this.addChild(textPrintout);
			this.addChild(fails);
			this.addChild(wins);
			stage.addChild(timeField);
			var time:uint = getTimer();
			trace("clock",clock);
			clock.testFunction();
			var timeSinceGameStart = clock.timeElapsedSinceGameStarted();
			timeField.txt_time.text = timeSinceGameStart;
			
		}
		
		private function updateTextField():void{
			var timeSinceGameStart = clock.timeElapsedSinceGameStarted()
			timeField.txt_time.text = timeSinceGameStart;
		}
		
		private function createStartScreen():void{
			stage.addChild(startScreen);
			checkForStart();
		}
		
		private function createEndScreen():void{
			keyInputManager.setFirstPress(false);
			stage.addChild(endScreen);
			checkForStart();
		}
		
		private function checkForStart():void{
			this.addEventListener(Event.ENTER_FRAME, pressTheAnyKey);
		}
		
		private function pressTheAnyKey(e:Event):void{
			if(isGameOver == false){
				if(keyInputManager.getFirstPress()==true){
					startTimer++;
					startScreen.alpha-=.03;
					if(startTimer > 56){
						keyInputManager.setFirstPress(false);
						stage.removeChild(startScreen);
						this.removeEventListener(Event.ENTER_FRAME, pressTheAnyKey);
						startGame();
					}
				}
			}else if(isGameOver == true){
				if(keyInputManager.getFirstPress()==true){
					startTimer++;
					endScreen.alpha-=.03;
					if(startTimer > 56){
						keyInputManager.setFirstPress(false);
						stage.removeChild(endScreen);
						endScreen.alpha = 1;
						this.removeEventListener(Event.ENTER_FRAME, pressTheAnyKey);
						startGame();
					}
				}
			}
			textPrintout.debugTrace("0000000000000000000000000000000000000");
		}
		
		private function startGame():void{
			isGameOver = false;
			//textPrintout.visible=true;
			
			createKeyboard();
			runGame();
			createBeams();
			isGameStarted=true;
		}
		
		public function deleteWinAnim(anim):void{
			var index:int = winAnims.indexOf(anim);
			winAnims.splice(index,1);
			stage.removeChild(anim);
		}
		
		public function deleteBeam(beamToDelete):void{
			var index:int = fallingBeams.indexOf(beamToDelete);
			fallingBeams.splice(index,1);
			stage.removeChild(beamToDelete);
		}
		
		private function createBeams():void{
			delays = levels.getDelay();
			var targets:Array = new Array();
			targets = levels.getLevelSequence();
			//for each target keycode generated for the level
			for(var i:int = 0;i < targets.length; i++){
				//find the key that matches it
				
				for(var j:int = 0;j<keyboardKeys.length;j++){
					if(keyboardKeys[j].getKeyCode() == targets[i]){
						//trace("MATCH!: keyboardKeys[j].getKeyCode() is :",keyboardKeys[j].getKeyCode());
						//trace("targets[i]",targets[i]);
						var beam:LightBeam = new LightBeam(this);
						beam.setTarget(keyboardKeys[j]);
						keyboardKeys[j].setBeam(beam);
						waitingBeams.push(beam);
						beam.visible=false;
						stage.addChild(beam);
						beamQueue++;
					}
				}
			}
		}
		
		private function updateLoop(e:Event):void{
			updateTextField();
			for each(var anim:winAnim in winAnims){
				anim.updateLoop();
			}
			
			for each(var beam:LightBeam in fallingBeams){
				
				if(beam.waitingInQueue == "true"){
					//don't do anything
				}
				if(beam.waitingInQueue == "false"){
					beam.updateLoop();
				}
				
			}
			beamTimer++;
			
			if(beamQueue > 0){
				if(beamTimer >= delays[0]){
					waitingBeams[0].getTarget().beginGlowAnimation();//the key targeted by the beam glows
					
					waitingBeams[0].waitingInQueue = "false"
					waitingBeams[0].visible=true;
					//shift it into a new array
					fallingBeams.push(waitingBeams.shift())
					
					beamQueue--;
					beamTimer=0;
					totalDrops++;
				}
				
			}else{
				
				if(beamTimer >= delays[1] && fallingBeams.length == 0){
					if(!isGameOver){
						createBeams();
						beamTimer=0;
					}
				}
			}
			
			streakLogic();
			if(failStreak > maxFailStreak){
				clearGame();
				soundManager.playSound_gameOver();
			}
		}
		
		/*
		*if keys are enabled
		*get the currently pressed keys
		*check all the keyboard button objects to see if their keyCode is the same as the one that was just pressed
		*if it was the same, then check to see if that key was active
		*
		*
		*
		*
		*/
		public function checkKeys():void{
			var failedKeyPress:Boolean = true;
			currentlyPressedKeys = keyInputManager.getKeysCurrentlyPressed();
			if(isKeysEnabled && currentlyPressedKeys.length > 0){
				
				for(var i:int=0; i< keyboardKeys.length; i++){
					for(var j:int=0; j < currentlyPressedKeys.length; j++){
						//if my key at [i] matches a keyCode
						if(keyboardKeys[i].getKeyCode() == currentlyPressedKeys[j]){
							//trace("its pressed");
							//if my key is active
							if(keyboardKeys[i].checkActive() == true){
								//trace("its active");
								keyboardKeys[i].setActiveState(false);
								keyboardKeys[i].activePressed();
								soundManager.playSound_hit();
								successStreak ++;
								failedKeyPress = false;
								keyboardKeys[i].setCheckKeyState("true");
								createWinAnim(keyboardKeys[i].x,keyboardKeys[i].y,"primary",0,0);
							}
							//if the key i pressed was not active
							if(keyboardKeys[i].checkActive() == false){
								if(keyboardKeys[i].getCheckKeyState() != "true"){
									keyboardKeys[i].setCheckKeyState("false");
									keyboardKeys[i].inactivePressed();
									
								}
							}
						}
					}
				}
				//if you pressed a wrong key
				if(failedKeyPress && isGameStarted){
					//trace("failed keypress");
					soundManager.playSound_hitWrong();
					incrementFailCount();
					streakBrokenLogic();
				}
			}
		}
		
		private function streakLogic():void{
			//fails.debugTrace("fails"+String(failStreak));
			//wins.debugTrace("wins"+String(successStreak));
			if(totalDrops < 6){
				levels.setDifficulty(0)
			}else if(totalDrops >= 6 && totalDrops <= 12){
				levels.setDifficulty(1)
			}else if(totalDrops >= 6 && totalDrops <= 20){
				levels.setDifficulty(2)
			}else if(totalDrops >= 6 && totalDrops <= 35){
				levels.setDifficulty(3)
			}else if(totalDrops >= 6 && totalDrops <= 60){
				levels.setDifficulty(4)
			}else if(totalDrops >= 6 && totalDrops <= 100){
				
			}
		}
		
		private function runGame():void{
			
			this.addEventListener(Event.ENTER_FRAME, updateLoop);
			
		}
		
		public function incrementFailCount():void{
			//trace("failStreak:",failStreak);
			failStreak++;
			gameBackground.overlay.gotoAndStop(failStreak+1);
		}
		
		private function clearGame():void{
			gameBackground.overlay.gotoAndStop(1);
			//initialKeyLetters
			//initialKeyCodes
			//keyboardKeys
			for(var i:int=0;i < keyboardKeys.length; i++){
				stage.removeChild(keyboardKeys[i]);
				keyboardKeys.splice(i,1);
				i--;
			}
			isKeysEnabled = true;
			currentlyPressedKeys = [];
			successStreak = 0;
			failStreak = 0;
			//maxFailStreak
			totalDrops = 0;
			//textPrintout
			//fails
			//wins
			//levels
			beamQueue = 0;
			//fallingBeams
			//trace("fallingBeams being deleted",fallingBeams);
			for(var j:int=0;j < fallingBeams.length; j++){
				//trace(fallingBeams[j].parent);
				stage.removeChild(fallingBeams[j]);
				fallingBeams.splice(j,1);
				j--;
			}
			//waitingBeams
			for(var k:int=0;k < waitingBeams.length; k++){
				//trace(waitingBeams[k].parent);
				stage.removeChild(waitingBeams[k]);
				waitingBeams.splice(k,1);
				k--;
			}
			beamTimer = 0;
			beamDelay = 120;
			delays = [];
			//startScreen
			startTimer = 0;
			isGameOver = true;
			
			isGameStarted=false;
			
			//winAnims
			for(var l:int=0;l < winAnims.length; l++){
				//trace(winAnims[l].parent);
				stage.removeChild(winAnims[l]);
				winAnims.splice(l,1);
				l--;
			}
			createEndScreen();
		}
		
		private function streakBrokenLogic():void{
			successStreak = 0;
		}
		
		private function createKeyInputManager():void{
			keyInputManager = new KeyInputManager(this,stage);
			clock = new Clock();
		}
		
		//p is really 80
		//set p to 219, left bracked for testing
		private function setInitialKeyLetters():void{
			initialKeyLetters = ["Q","W","E","R","T","Y","U","I","O","P","A","S","D","F","G","H","J","K","L","Z","X","C","V","B","N","M"];
			initialKeyCodes =   [81 ,87, 69, 82, 84, 89, 85, 73, 79, 80, 65, 83, 68, 70, 71, 72, 74, 75, 76, 90, 88, 67, 86, 66, 78, 77];
			//textPrintout.debugTrace("Main: setInitialKeys: initialKeys:" + String(initialKeyLetters));
		}
		
		private function createKeyboard():void {
			//textPrintout.debugTrace("Main: createKeyboard");
			var firstKeyX:int=100;
			var firstKeyY:int=300;
			
			var offsetX:int = 70;
			var offsetY:int = 70;
			
			var lineOffset:int = 15;
			
			for (var i:int = 0; i < 26; i++) {
				var kbb:KeyboardButton = new KeyboardButton(textPrintout);
				kbb.setLetter(initialKeyLetters[i]);
				kbb.setKeyCode(initialKeyCodes[i]);
				if(i <= 9){
					kbb.x = firstKeyX + offsetX*i;
					kbb.y = firstKeyY;
				}
				if(i > 9 && i <= 18){
					kbb.x = firstKeyX + lineOffset + offsetX*(i-10);
					kbb.y = firstKeyY + offsetY;
				}
				if(i > 18){
					kbb.x = firstKeyX + lineOffset*3 + offsetX*(i-19);
					kbb.y = firstKeyY + offsetY*2;
				}
				keyboardKeys.push(kbb);
				stage.addChild(kbb);
			}
		}
		
		private function addKeyHandler():void{
			isKeysEnabled = true;
		}
		
		public function removeKeyHandler():void{
			isKeysEnabled = false;
		}
	}
}