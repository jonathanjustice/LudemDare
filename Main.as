package {
import flash.display.MovieClip;
import flash.events.*;
import flash.geom.Point;
	public class Main extends MovieClip {
		private var initialKeyLetters:Array = new Array();
		private var initialKeyCodes:Array = new Array();
		private var keyboardKeys:Array = new Array();
		private var isKeysEnabled:Boolean=true;
		private var currentlyPressedKeys:Array = new Array();
		private var keyInputManager:KeyInputManager;
		private var successStreak:int = 0;
		private var failStreak:int = 0;
		private var totalDrops:int=0;
		private var textPrintout:TextPrintout = new TextPrintout();
		private var fails:TextPrintout = new TextPrintout();
		private var wins:TextPrintout = new TextPrintout();
		//private var difficulty:int=1;
		private var levels:Levels = new Levels();
		private var beamQueue:int=0
		private var fallingBeams:Array = new Array();
		private var beamTimer:int=0;
		private var beamDelay:int=120;
		private var delays:Array = new Array();
		private var startScreen:Screen_Start = new Screen_Start();
		private var startTimer:int=0;
		public function Main() {
			createKeyInputManager();
			textPrintout.visible=false;
			this.addChild(textPrintout);
			this.addChild(startScreen);
			checkForStart();
			
		}
		
		private function checkForStart():void{
			trace("check for start");
			this.addEventListener(Event.ENTER_FRAME, pressTheAnyKey);
			
		}
		
		private function pressTheAnyKey(e:Event):void{
			if(keyInputManager.getFirstPress()==true){
				startTimer++;
				startScreen.alpha-=.03
				if(startTimer > 56){
					keyInputManager.setFirstPress(false);
					this.removeChild(startScreen);
					this.removeEventListener(Event.ENTER_FRAME, pressTheAnyKey);
					startGame();
					trace("start");
				}
			}
		}
		
		private function startGame():void{
			this.addChild(fails);
			this.addChild(wins);
			wins.y +=40;
			fails.y+=20;
			textPrintout.visible=true;
			setInitialKeyLetters();
			createKeyboard();
			runGame();
			checkForStart();
			createBeams();
		}
		
		private function createBeams():void{
			delays = levels.getDelay();
			var targets:Array = new Array();
			targets = levels.getLevelSequence();
			trace("targets",targets);
			//for each target keycode generated for the level
			for(var i:int = 0;i < targets.length; i++){
				//find the key that matches it
				
				for(var j:int = 0;j<keyboardKeys.length;j++){
					if(keyboardKeys[j].getKeyCode() == targets[i]){
						//trace("keyboardKeys[j].getKeyCode()",keyboardKeys[j].getKeyCode());
						//trace("targets[i]",targets[i]);
						var beam:LightBeam = new LightBeam(this);
						beam.setTarget(keyboardKeys[j]);
						keyboardKeys[j].setBeam(beam);
						fallingBeams.unshift(beam);
						beamQueue++;
					}
				}
			}
		}
		
		private function runGame():void{
			
			this.addEventListener(Event.ENTER_FRAME, updateLoop);
			
		}
		
		public function incrementFailCount():void{
			failStreak++;
			
		}
		
		public function deleteBeam(beamToDelete):void{
			//trace("beamToDelete",beamToDelete);
			//trace("beamToDelete.parent",beamToDelete.parent);
			var index:int = fallingBeams.indexOf(beamToDelete);
			//trace("fallingBeams",fallingBeams,index);
			fallingBeams.splice(index,1);
			stage.removeChild(beamToDelete);
		}
		
		private function updateLoop(e:Event):void{
			
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
					fallingBeams[0].getTarget().beginGlowAnimation();
					stage.addChild(fallingBeams[0]);
					fallingBeams[0].waitingInQueue = "false"
					beamQueue--;
					beamTimer=0;
					totalDrops++;
				}
				
			}else{
				if(beamTimer >= delays[1]){
					createBeams();
					beamTimer=0;
				}
			}
			
			streakLogic();
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
					keyboardKeys[i].setCheckKeyState("notChecked");
					for(var j:int=0; j < currentlyPressedKeys.length; j++){
						//if my key at [i] matches a keyCode
						if(keyboardKeys[i].getKeyCode() == currentlyPressedKeys[j]){
							//trace("its pressed");
							//if my key is active
							if(keyboardKeys[i].checkActive() == true){
								//trace("its active");
								keyboardKeys[i].activePressed();
								successStreak ++;
								failedKeyPress = false;
								keyboardKeys[i].setCheckKeyState("true");
								
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
				if(failedKeyPress){
					incrementFailCount();
					streakBrokenLogic();
					/*for(var j:int=0; j < currentlyPressedKeys.length; j++){
						
					}*/
				}
				//trace("successStreak",successStreak);
				//trace("failStreak",failStreak);
				//textPrintout.debugTrace("successStreak" + String(successStreak));
				//textPrintout.debugTrace("failStreak" + String(failStreak));
			}
		}
		
		private function streakLogic():void{
			fails.debugTrace("fails"+String(failStreak));
			wins.debugTrace("wins"+String(successStreak));
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
		
		private function streakBrokenLogic():void{
			successStreak = 0;
		}
		
		private function createKeyInputManager():void{
			keyInputManager = new KeyInputManager(this,stage);
		}
		
		//p is really 80
		//set p to 219, left bracked for testing
		private function setInitialKeyLetters():void{
			initialKeyLetters = ["Q","W","E","R","T","Y","U","I","O","P","A","S","D","F","G","H","J","K","L","Z","X","C","V","B","N","M"];
			initialKeyCodes =   [81 ,87, 69, 82, 84, 89, 85, 73, 79, 80, 65, 83, 68, 70, 71, 72, 74, 75, 76, 90, 88, 67, 86, 66, 78, 77];
			textPrintout.debugTrace("Main: setInitialKeys: initialKeys:" + String(initialKeyLetters));
		}
		
		private function createKeyboard():void {
			textPrintout.debugTrace("Main: createKeyboard");
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