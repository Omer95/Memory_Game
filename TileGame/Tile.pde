
/*
* This class called tile contains the details of one tile that is to be loaded including its width, height, position, when to show
* highlight and close the image. 
*/

class Tile {
  
  //VARIABLES
  public boolean clicked;
  public int x,y,w,h;
  public PImage img, question;
  public String iname;
  
  //CONSTRUCTOR
  public Tile (int x, int y, int w, int h, String iname) {
     this.x=x;
     this.y=y;
     this.w=w;
     this.h=h;
     this.iname=iname;
     this.img=loadImage(iname); 
     this.clicked=false;
     
  }
  
  //METHODS
  
  //this method shows the tile image
  public void show() {
     //tint(125,125,125);
     image(img, x, y, w, h); 
  }
  
  //this method hides the tile image
  public void hide() {
     //question=loadImage("question.png");
     fill(#B7681E);
     strokeWeight(5);
     stroke(#835203);
     rect(x,y,w,h);
      
  }
  
  //this method highlights the tile image 
  public void highlight() {
    //tint(5,240,250);
    image(img,x,y,w,h);
  }
}
  

