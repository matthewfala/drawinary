
import java.util.Random;
import java.util.Arrays;

// Ok to store all the photos and the names of photos, we will construct an array
// Built with differnt photo objects with values such as names, to do so we will need to 
// make about 20 photo objects and put them inan array



//titlescreen
float upDownDir = 0;
float upDown    = 0;
float titleScreenOpacity = 0;
//titleScreen image
PImage titleImageStill;

//GameLayer Variables

  //Clock
  int secondsTime = 30;
  
  //imageOpacity
  int gameImageOpacity = 0;

  //Graphics Values (change the setup also)
  int graphicsWidth = 1200;
  int graphicsHeight = 700;
  // numb
  int numbOfImages = 17;
  int imageHeight  = graphicsHeight * 3/4;
  int imageWidth   = graphicsWidth;
  //phase for gamelayer
  int gamePhase = 0;



//VoteLayer
int VoteCount1=0;
int VoteCount2=0;
int waitMouseUp = 0;
int totalStuds = 12;
int totalVotes = totalStuds - 6;
// Complete game variables
int team1Score = 0;
int team2Score = 0;

PImage backg;
PFont GoodFont;


//point to the TitleScreen layer
String gameRenderLayer = "TitleScreen";


void setup(){
  fill(10,80,100);
  stroke(255);
  size(1200,700);
  textSize(30);
  textAlign(CENTER, CENTER);
  
  //font
  GoodFont = createFont("AGaramondPro-Bold", 48);
  textFont(GoodFont);
  
  
  
  //titleScreen image
  titleImageStill = loadImage("DrawinaryTitleScreen.png"); 
  titleImageStill.resize(graphicsWidth, graphicsHeight);
  backg = loadImage("backg.png");
  backg.resize(graphicsWidth, graphicsHeight);
  
  //Load In all photos and names into object array (gamePhotoObjectArray)
  photoAddToArray("Bird", "bird.jpg");
  photoAddToArray("Boat", "boat.jpg");
  photoAddToArray("Cake", "cake.jpg");
  photoAddToArray("Car", "car.jpg");
  photoAddToArray("Cat", "cat.jpg");
  photoAddToArray("Christmas Tree", "christmasTree.jpg");
  photoAddToArray("Computer", "computer.png");
  photoAddToArray("Crane", "CRANE.gif");
  photoAddToArray("Flower", "flower.jpg");
  photoAddToArray("House", "house.png");
  photoAddToArray("Dog", "dog.jpeg");
  photoAddToArray("Mountain", "mountain.jpg");
  photoAddToArray("Rabbit", "rabbit.jpg");
  photoAddToArray("Rock", "rock.png");
  photoAddToArray("Tree", "tree.png");
  photoAddToArray("Umbrella", "umbrella.jpg");
  photoAddToArray("Worm", "worm.jpg");
  //shuffle array for randomness
  //gamePhotoObjectArray.shuffle();
  ShufflePhotos(); //(gamePhotoObjectArray);
 
}



void draw(){
  stroke(0,0,0);
  //draw each screen
    ManageWins();
    gameScreen();
    ResultsScreen();
    votelayer();
    ScoreLayer();
    titleScreen();
    aboutScreen();
}


//aboutScreen Vars
float aboutScreenOpacity = 0;
int aboutScreenPhase = 0;
int clock;

//the ABOUT SCREEN
void aboutScreen() {
if (gameRenderLayer == "AboutScreen") {
  
  if (aboutScreenPhase == 0) {//fade in phase
    if (aboutScreenOpacity< 255) {
      text( "P   R   E   S   S     A      F   O   R      H   O   W      T   O      P   L   A   Y",  graphicsWidth/2, graphicsHeight/80);
      tint(255, aboutScreenOpacity);
      image(backg, 0,0);
      aboutScreenOpacity+= 5;
    } else { //done fading
      aboutScreenPhase = 1;
      aboutScreenOpacity = 0;
      clock = millis()/1000; // start clock
    }
    
  } else if (aboutScreenPhase == 1) { // show About screen
    if (millis()/1000-clock < 30) {
      background(backg);
      
       // if key pressed go to phase 2
      if (keyPressed) {
         aboutScreenPhase = 4;
      }
      
    } else {
      aboutScreenPhase = 4;

    }
  } else if (aboutScreenPhase == 4) { //fade in title
    if (aboutScreenOpacity< 255) {
      background(backg);
      tint(255, aboutScreenOpacity);
      image(titleImageStill,0,0);
      text( "P   R   E   S   S     A      F   O   R      H   O   W      T   O      P   L   A   Y",  graphicsWidth/2, graphicsHeight/80);
      aboutScreenOpacity += 5;
    } else { 
      aboutScreenPhase = 5; 
      clock = millis()/1000; //start clock again
    
    }
  }
   
  if (aboutScreenPhase == 5) { //exit to titlescreen
    gameRenderLayer = "TitleScreen";
    aboutScreenPhase = 0;
    aboutScreenOpacity = 0;
  }
 
 
}
}


// the TitleScreen
void titleScreen() {
  if (gameRenderLayer == "TitleScreen") {
    //fadein
    if (titleScreenOpacity<255){
      titleScreenOpacity += .5;
      tint(255,titleScreenOpacity);
      image(titleImageStill,0,0);
      tint(255,255);
      //sprintln("brightened");
    } else{
      background(titleImageStill);
    }
    
    //space hit go to game if in title screen
    if (keyPressed) {
        if (key == ' ' || key == ' ') {
          gameRenderLayer = "GameScreen";
         // gameStartQue = 1;
          //println("game start");
        }
    }
     
     
    //tell about about screen
    fill(255,255,255);
    textSize(10);
    text( "P   R   E   S   S     A      F   O   R      H   O   W      T   O      P   L   A   Y",  graphicsWidth/2, graphicsHeight/80);
    //a hit go to game if in about screen
    if (keyPressed) {
        if (key == 'a' || key == 'A') {
           gameRenderLayer = "AboutScreen";
        }
    }
  }
}


//GAME SCREEN
photoObject chosenPhotoObj;
void gameScreen() {
  if (gameRenderLayer == "GameScreen") {
    
    //setup and pick image for main game.
    if (gamePhase== 0) {
             println(gamePhotoObjectArray.size());
       int randomPhoto = int(random(gamePhotoObjectArray.size()));
       chosenPhotoObj = gamePhotoObjectArray.get(randomPhoto);
       gamePhotoObjectArray.remove(randomPhoto);
       
       
       println(gamePhotoObjectArray.size());
       //setBackground
       background(titleImageStill);
       //set fill and stroke
       fill(0,0,0,150);
       stroke(0);
       gamePhase = 1;
    }
   
   fill(0,0,0,150);
   stroke(0);
   //fade image in
   if (gamePhase== 1) { 
     gameImageOpacity += 3;
     background(titleImageStill);
     //let opaque rectangle fall
      rect(0, -graphicsHeight + gameImageOpacity* graphicsHeight/255 , graphicsWidth, graphicsHeight);
      tint(255, gameImageOpacity);
      //image(chosenPhotoObj.gamePhoto, graphicsWidth/2 - chosenPhotoObj.gamePhoto.width/2 , ( graphicsHeight - imageHeight));
      image(chosenPhotoObj.gamePhoto, graphicsWidth/2 - chosenPhotoObj.gamePhoto.width/2 , -chosenPhotoObj.gamePhoto.height + gameImageOpacity* graphicsHeight/255);
      //exit fade in if full
      if (gameImageOpacity > 255) gamePhase = 15;
    }
   
    //draw the Game Wait Instructions
    if (gamePhase== 15) {
      gameImageOpacity = 0;
      background(titleImageStill);
      rect(0,0, graphicsWidth, graphicsHeight);
      image(chosenPhotoObj.gamePhoto, graphicsWidth/2 - chosenPhotoObj.gamePhoto.width/2 , ( graphicsHeight - imageHeight));
      textAlign(CENTER, CENTER);
      textSize(30);
      fill(255);
      text("Draw This " + chosenPhotoObj.imageAnswer + " On The Whiteboard. Grab a Pen and Hit Space " , graphicsWidth/2, 100 );
      text("When You're Ready. You Have " + secondsTime + " Seconds!" , graphicsWidth/2, 150); 
       
      //text("Draw This image On The White board", graphicsWidth/2, 50 );
      fill(0,0,0,200);
      if (keyPressed) {
        if (key == ' ' || key == ' ') {
         // gameRenderLayer = "GameScreen";
            gamePhase = 2;
         }
      }
     
    }
   
    //draw the main game
    if (gamePhase== 2) {
      gameImageOpacity = 0;
      background(titleImageStill);
      rect(0,0, graphicsWidth, graphicsHeight);
      image(chosenPhotoObj.gamePhoto, graphicsWidth/2 - chosenPhotoObj.gamePhoto.width/2 , ( graphicsHeight - imageHeight));
      textAlign(CENTER, CENTER);
      textSize(30);
      fill(255);
      text("Draw This " + chosenPhotoObj.imageAnswer + " On The Whiteboard. YOU HAVE " + secondsTime + " SECONDS!" , graphicsWidth/2, 100 );
      //text("Draw This image On The White board", graphicsWidth/2, 50 );
      fill(0,0,0,200);
      
      //CLOCK LAYER CHANGES PHASE TO 3
      ClockLayer();
     
    }
    
    //reset everything + move on
    if(gamePhase == 3) {
      gameRenderLayer = "VoteLayer";
      gamePhase = 0;
    }
    
     
  }
}




//SCORE LAYER
void ScoreLayer() {
  if (gameRenderLayer != "TitleScreen" && gameRenderLayer != "AboutScreen" ){
    stroke(0);
    textSize(45);
  
    //Rectangle score bar
    fill(0,0,0,200);  
    rect(0, graphicsHeight- 125, graphicsWidth, 250);
    
    //write the scores: 
    fill(100, 50, 200);
    text("Team 1 Score : " + team1Score , graphicsWidth/5, graphicsHeight/15 * 14);
    fill(200, 50, 100);
    text("Team 2 Score : " + team2Score , graphicsWidth/5 * 4, graphicsHeight/15 * 14);
    
    
    //clock
    if (gameRenderLayer == "GameScreen" && gamePhase == 2) {
      ClockLayer();
    }
    if (gameRenderLayer == "GameScreen" && gamePhase == 15) {
      fill(100,54, 18);
      ellipse(graphicsWidth/2, graphicsHeight - 70, 100, 100);
    }
  }
}






// CLOCK LAYER
int clockPhase     = 0;
int clockTimeStart = 0;
int timeElapsed    = 0;
void ClockLayer() {
  
  //document time
  if (clockPhase == 0) {
    clockTimeStart = millis(); 
    clockPhase = 1;
  }
  
  if(clockPhase == 1){
   
    //get Time
    timeElapsed = millis() - clockTimeStart;
    //Draw Clocks Back
    println(timeElapsed);
    if(timeElapsed < 3000){
      fill(140,207,25);
      stroke(140,207,25);
    }else if(timeElapsed < 25000){
      stroke(212,128, 38);
      fill(212,128, 38);
    } else {
      stroke(207, 25, 34);
      fill(207, 25, 34);
    }
    // draw Clocks back
    ellipse(graphicsWidth/2, graphicsHeight - 70, 100, 100);
    
    //Draw Clocks Front
    stroke(100,54, 18);
    fill(100,54, 18);
    arc(graphicsWidth/2, graphicsHeight -70, 100, 100, 0, (2*PI) * timeElapsed/(secondsTime*1000), PIE); //full amount devided by ratio of passed time

     if(timeElapsed > secondsTime*1000){
       gameRenderLayer = "VoteLayer";
       clockPhase     = 0;
       clockTimeStart = 0;
       timeElapsed    = 0;
       gamePhase      = 3;
     }
   }
}





//VoteLayer
int votePhase = 0;
void votelayer() {
  stroke(255);
  if (gameRenderLayer == "VoteLayer") {
    if (votePhase == 0) {
      background(255* VoteCount2/ totalVotes,10,255 *VoteCount1 / totalVotes);
      fill(255);
      rect(0, 200, 600, 700);
      fill(255);
      rect(600, 200, 600, 700);
  
      if (mouseX < 600 && mouseY > 200) {
        fill(153, 204, 255);
        rect(0, 200, 600, 700);
      } else if (mouseX > 600 && mouseY>200) {
        fill (255, 204, 133);
        rect(600, 200, 600, 700);
      }
  
      //clear mouse
      if (waitMouseUp == 1) {
        fill(255, 51, 51);
        if (mousePressed != true) waitMouseUp = 0;
      }
      if (mousePressed == true && mouseX < 600) {
        if (waitMouseUp == 0) {
          fill(0, 128, 255);
          rect(0, 200, 600, 700);
          VoteCount1 = VoteCount1 + 1;
          println("VOTECOUNT 1= " + VoteCount1);
          waitMouseUp = 1;
        }
      } else if (mousePressed == true && mouseX > 600) {
        if (waitMouseUp == 0) {
          fill(255, 128, 0);
          rect(600, 200, 600, 700);
          VoteCount2 = VoteCount2 + 1;
          println("VOTECOUNT 2 =" + VoteCount2);
          waitMouseUp = 1;
        }
      }
  
      // vote counts left circular holder 
      fill(0);
      ellipse(600, 450, 150, 150);
  
      // prints # of votes left 
      textSize(90);
      fill(204, 255, 153);
  
      if (totalVotes - (VoteCount1 + VoteCount2) < 10) {
        text(totalVotes - (VoteCount1 + VoteCount2), graphicsWidth/2, graphicsHeight/2 + 90);
      } else {
        text(totalVotes - (VoteCount1 + VoteCount2), graphicsWidth/2, graphicsHeight/2 + 90);
      }
  
      // Instructions for voting
      textSize(40);
      fill(255);
      text("Vote which drawing you think is better!", graphicsWidth/2, 100);   
  
      // Team 1 name on left box    
      textSize(50);    
      fill(0, 0, 204);
      text("TEAM 1", graphicsWidth/4, graphicsHeight/2+70);
  
      // Team 2 name on right box    
      textSize(50);    
      fill(255, 128, 0);
      text ("TEAM 2", graphicsWidth/4 * 3, graphicsHeight/2+70);
      if (totalVotes - (VoteCount1 + VoteCount2) == 0) {
        votePhase = 1;
      }
      
  } else if (votePhase == 1) {
      background(0);
      background(255* VoteCount2/ totalVotes,10,255 *VoteCount1 / totalVotes);
      text("Counting all votes...", graphicsWidth/2, graphicsHeight/2);
      delay(20);
      delay(5000);
      gameRenderLayer = "ResultsScreen";
      votePhase = 0;
      
  }
}
}

//resultScreen
int resultPhase = 0;
void ResultsScreen() {
  if (gameRenderLayer == "ResultsScreen") {
    if (resultPhase == 0) { 
            if (VoteCount1 > VoteCount2) {
              team1Score += 100;
            } else if (VoteCount1 < VoteCount2) {
              team2Score += 100;
            } else if (VoteCount1==VoteCount2){
              team1Score += 100;
              team2Score += 100;
            }
              resultPhase = 1;
     }
     
     if (resultPhase == 1) {
          
          background(255);
          if (VoteCount1 == VoteCount2) {
            textSize(50);
            fill(0);
            text("IT'S A TIE!!!", graphicsWidth/2, graphicsHeight/2);
          } else if (VoteCount1 > VoteCount2) {
            textSize(50);
            fill(50, 10, 200);
            text("The winner of this round is Team 1!", graphicsWidth/2, graphicsHeight/2);
          } else {
            textSize(50);
            fill(200, 10, 50);
            text("The winner of this round is Team 2!", graphicsWidth/2, graphicsHeight/2);
          }
          resultPhase = 2;
     } else if (resultPhase == 2) {
         
        delay(5000);
        VoteCount1 = 0;
        VoteCount2 = 0;
        resultPhase = 0;
        gameRenderLayer = "GameScreen";
     }
  }
  
}



//Win Screen
int winPhase = 0;
int winClock = 0;
void WinScreen(){
  if (gameRenderLayer == "WinScreen"){
    
    if (winPhase == 0) {
      winClock = millis(); 
      winPhase = 1;
    }
    
    if (winPhase == 1) {
      background(0,204,204);
      if (team1Score > team2Score) {
          textSize(80);
          fill(0);
          text("Team 1 won this game!", graphicsWidth/2, graphicsHeight/2);
        } else if (team1Score < team2Score){
          textSize(80);
          fill(0);
          text("Team 2 won this game!", graphicsWidth/2, graphicsHeight/2);
        }
        if (millis() - winClock > 3000) {
          winPhase = 2;
        }
        
    }
    
    if (winPhase == 2) {
       winPhase = 0;
       team1Score = 0;
       team2Score = 0;
       gameRenderLayer = "TitleScreen"; 
       
    }
       
  }
}



void ManageWins() {
  if (team1Score == 400 || team2Score == 400) {
      gameRenderLayer = "WinScreen";    
    
  }
    
}







//ArrayList = gamePhotoObjectArray
// Ok to store all the photos and the names of photos, we will construct an array
// Built with differnt photo objects with values such as names, to do so we will need to 
// make about 20 photo objects and put them inan array.

// function which turns a name and an image name into a photoObject in gamePhotoObjectArray
void photoAddToArray(String name, String gamePhoto) {
  gamePhotoObjectArray.add(new photoObject(name, gamePhoto));
}


//create Array
ArrayList<photoObject> gamePhotoObjectArray = new ArrayList<photoObject>();

// photo Object which contains name and photo
class photoObject {
  //fields
  String imageAnswer; 
  PImage gamePhoto;
  
  //constructor That returns objects
  photoObject(String tempName, String tempGamePhotoString) {
    imageAnswer = tempName;
    gamePhoto   = loadImage(tempGamePhotoString);
    
    //rezize based on x if X is larger
    if( gamePhoto.width/graphicsWidth > gamePhoto.height/graphicsHeight){
      gamePhoto.resize(imageWidth, 0);
    } else { //Or RESIZE for y if Y is larger
      gamePhoto.resize(0, imageHeight);
    }
  
  } 
  
}
////////////////////////////////////////////////////////////////////////////////////////

//shuffle all photos
photoObject Object1; 
photoObject Object2;

void ShufflePhotos() {
  
  for (int i = 0 ; i < gamePhotoObjectArray.size(); i++) { 
    print("Space i" + i + " to from : " + gamePhotoObjectArray.get(i).imageAnswer);
    swap(gamePhotoObjectArray, i, int(random(gamePhotoObjectArray.size())));
    println( "  to  :  " + gamePhotoObjectArray.get(i).imageAnswer);
  }
  
}


void swap(ArrayList<photoObject> list, int i, int j){

photoObject tempi = list.get(i);
photoObject tempj = list.get(j); 

gamePhotoObjectArray.set(i, tempj);
gamePhotoObjectArray.set(j, tempi);
//print("Swapped:  ");


}
  
  
  