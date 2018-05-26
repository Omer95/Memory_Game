PImage homePage, level; //loads the main screen and the levels page
boolean showing= false; //boolean for matching of the pictures is initially kapt at false

int score=0; //initialize a value of 0 for score;
int xMatch1, xMatch2, yMatch1, yMatch2; // coordiantes to determine whether the images match or not
public int rows=8;
public int cols=8;

Tile [][] at= new Tile [rows][cols]; //array which contains different images 

//-------------MUSIC OBJECT---------------------------
import ddf.minim.*;
Minim minim;
AudioPlayer theme, open, right, wrong;
//----------------------------------------------------

//------------GAME SETUP------------------------------
void setup() {
   //loads the music files
   minim= new Minim(this);
   theme= minim.loadFile("theme.mp3");
   theme.play(); //plays the first sound
   
   size(800,800);//size of the game
   
   homePage= loadImage("memoryGame.jpg"); // loads the home page image
   level= loadImage("memoryGameLevel.jpg"); // loads the levels page
   
   image(homePage, 0,0,800,800); //displays the homepage image 
}
//--------------------------------------------------

void draw() {
}

void keyPressed(){ 
   if (key=='a') {
      open=minim.loadFile("open.mp3");
      open.play();
      image(level,0,0,800,800);
   } 
   
   // Deciding which level to play**************************
   
   if (key=='1') { //if 1 is pressed level 1 is played
       open=minim.loadFile("open.mp3");
       open.play();
       firstLevel(); //redirects to the first level method; opens level 1
   }
   if (key=='2') { //if 2 is pressed level 2 is played
       open=minim.loadFile("open.mp3");
       open.play();
       secondLevel(); //redirects to the second level method; opens level 2
   }
   if (key=='3') { //if 3 is pressed level 3 is played
       open=minim.loadFile("open.mp3");
       open.play();
       thirdLevel(); //redirects to the third level method; opens level 3
   }
   
}

//------------------------Generating rows and cols for each level****************
void firstLevel() {
    rows=4;
    cols=4;
    startGame(); //starts the game for this level
}
void secondLevel() {
    rows=6;
    cols=6;
    startGame(); //starts the game for this level
}
void thirdLevel() {
    rows=8;
    cols=8;
    startGame(); //starts the game for this level
}

//-----------------------method to begin the game**************************
void startGame() {
   String [] img= loadStrings("apps.txt"); //loads the name of the png images from this file
   String [] imgs= new String [img.length*2]; // creates a new array with twice the img length
   int n= imgs.length;
   imgs= resize(img, rows*cols); //duplicates the list of image names in imgs
   n=imgs.length;
   
   int x=0, y=0;
   int dX= width/cols; //generates the length of the image
   int dY=height/rows; //generates the height of the image
   
   //CREATING AN ARRAY WITH IMAGES WITHIN IT
   for (int k=0; k<n; k++) {
      int r=(int)random(0, rows); //random for rows
      int c=(int)random(0, cols); //random for cols
      while(at[r][c]!=null) {
         r=(int)random(0, rows); //random for rows
         c=(int)random(0, cols); //random for cols 
      }
      
      //calculate the x and y coordinates
      x=c*dX;
      y=r*dY;
      
      //create a Tile for the randomly generated row and col
      at[r][c]= new Tile (x,y,dX,dY,imgs[k]);
      noFill();
      stroke(0,0,255);
      rect(x,y,dX,dY);
   }
  
  for(int i=0; i<rows; i++) {
     for (int k=0; k<cols; k++) {
      at[i][k].hide(); 
     }
  } 
}

//--------------------------code to shuffle images*******************
String[] resize(String[] inames, int num) {
    
    int k= num/2;  //half of total cells= (rowsxcols)/2
    int n= inames.length; //length of original array
    int j;
    String [] temp= new String[num]; //new String nums
    //shuffles an image
    for (int i=0; i<k; i++) {
       j=(int)random(0,n); //randomly generates an index for selecting from available images
       temp[i]= temp[num-1-i]= inames[j]; //assign the random image to both ends of the array 
    }
    return temp;
}

//-------------------------code for clicking image-------------------------------
void mouseClicked() {
   for (int i=0; i<rows; i++) {
      for (int j=0; j<cols; j++) {
          if (mouseX > at[i][j].x && mouseX < (at[i][j].x + at[i][j].w)) { 
             if (mouseY > at[i][j].y && mouseY < (at[i][j].y + at[i][j].h)) { 
                if(showing== false) {
                   if (at[i][j].clicked== false) {
                      open=minim.loadFile("open.mp3");
                      open.play();
                      at[i][j].show();
                      showing=true;
                      xMatch1= i;
                      yMatch1= j;
                      at[i][j].clicked= true;
                   }
                  else {
                  } 
                }
                else {
                   if (at[i][j].clicked== false) {
                      at[i][j].show();
                      showing=false;
                      xMatch2= i;
                      yMatch2= j;
                      at[i][j].clicked=true;
                      Matching();
                   }
                  else {
                  } 
                }
             } 
          }
      }
   } 
}

//-----------------------------code for the matching method--------------------------
void Matching() {
   
   if (at[xMatch1][yMatch1].iname.equals(at[xMatch2][yMatch2].iname)) {
      right=minim.loadFile("right.mp3"); //plays the right answer sound
      right.play();
      at[xMatch1][yMatch1].highlight();
      at[xMatch2][yMatch2].highlight();
      score+=4;
      println("Your score: "+score);
      
   } 
   else {
      wrong= minim.loadFile("wrong.mp3");
      wrong.play(); //plays the wrong answer sound
      at[xMatch1][yMatch1].hide(); //hides first image
      at[xMatch2][yMatch2].show(); //first shows and then hides second image
      at[xMatch2][yMatch2].hide();
      at[xMatch1][yMatch1].clicked= false; //both boolean values return to their initial value
      at[xMatch2][yMatch2].clicked= false;  
      score--;
      println("Your score: "+score);
   }
}

//END OF GAME
