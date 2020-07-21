//Tactile Pattern is a class which describes all properties of a tile, which is 
//the smallest element of tactile paving. Parameters include position, size, type
//and whether it's selected by mouse.Patterns can only be selected under revison
//mode. 
//In the main function, all tiles are stored in an array called tile_group[]
//pat_activated determines whether a pattern is visible, for unactivated elements
//and deleted elements in tile_group[],pat_activated=-1, otherwise pat_activated=1
class TactilePattern{
  //Variable
  int tile_size=20;//This might be calculated once scale of the map is known.
  int positionX=offsetx;//position of pattern
  int positionY=offsety;
  int pat_type=1;//type of pattern
  PImage pat_image;//picture of pattern, corresponding to the number of type
  boolean mouse_selected=false;//whether the pattern is selected
  int pat_activated=-1;// -1:deleted/unactivated 0:ready 1:activated
  
  //Declaration
  TactilePattern(){
    ;
  }
  TactilePattern(float tempSize, int tempX, int tempY){
    tile_size=int(tempSize);
    positionX=tempX;
    positionY=tempY;
    pat_type=1;
  }
  
  TactilePattern(float tempSize, int tempX, int tempY, int tempType){
    tile_size=int(tempSize);
    positionX=tempX;
    positionY=tempY;
    pat_type=tempType;
  }
 
  //Select Pattern Type
  void select_type(int tempType){
    switch(tempType){
      case 1:
        pat_image=loadImage("pattern1.jpg");
        break;
      case 2:
        pat_image=loadImage("pattern2.jpg");
        break;
      case 3:
        pat_image=loadImage("pattern3.jpg");
        break;
      case 4:
        pat_image=loadImage("pattern4.jpg");
        break;
      default:
        print("No such Pattern!");
        break;
    }
  }
  //Detection & implementation of Paving a single pattern, return true when paving
  boolean ispaving(){
    if(!mousePressed){
     pat_activated=0;
    }
    else if((mousePressed)&&(mouse_on_map(mouseX,mouseY))){
      if(pat_activated==0){
        pat_activated=1;
        positionX=mouseX-(mouseX-offsetx)%tile_size;
        positionY=mouseY-(mouseY-offsety)%tile_size;
        return true;
      }  
    }
    return false;
  }
  //Preview when paving
  void preview(){
    if(mouse_on_map(mouseX,mouseY)){
      image(tile_group[tile_num].pat_image,mouseX+10,mouseY-110,mouseX+110,mouseY-10);
      int tempx=mouseX-(mouseX-offsetx)%tile_size;
      int tempy=mouseY-(mouseY-offsety)%tile_size;
      image(tile_group[tile_num].pat_image,tempx,tempy,tempx+tile_size,tempy+tile_size);
    }
  }
  //Draw all already-paved tiles
  void draw_pat(){
    if(pat_activated==1){
      image(pat_image,positionX,positionY,positionX+tile_size,positionY+tile_size);
      //pat_activated=1;
    }   
  }
  
  //Mouse Selection:USELESS!
  void mouse_select(){
    if((mousePressed)&&(pat_activated==1)){
      if(mouse_on_tile(mouseX,mouseY)){
        mouse_selected=true;
      }
    }
  }
  
  //judge whether the mouse is on the tile
  boolean mouse_on_tile(float x, float y){
    int xmin=positionX;
    int xmax=positionX+tile_size;
    int ymin=positionY;
    int ymax=positionY+tile_size;
    boolean mouse_on=false;
    if((x>xmin)&&(x<xmax)&&(y>ymin)&&(y<ymax)){
      mouse_on=true;
    }
    return mouse_on;
  }
  
  //judge whether the mouse is on the map
  boolean mouse_on_map(float x, float y){
    boolean mouse_on=false;
    if((y<=windowheight)&&(x<=windowwidth)&&(x>=offsetx)&&(y>=offsety)){
      mouse_on=true;
    }
    return mouse_on;
  }
  //rotate the pattern 90 degrees;Other transformations may also be required
  //rotate pattern(){
  //  
  //}
  //revise the pattern in revise MODE
  void revise_pat(){
    stroke(255,0,0);
    strokeWeight(4); 
    noFill();
    if(pat_activated>=0){
      rect(positionX,positionY,positionX+tile_size,positionY+tile_size);
    } 
    if(Revise_Pattype.getValue()>0){
      select_type(int(Revise_Pattype.getValue()));
    }
    if((keyPressed)&&(key==BACKSPACE)){
      print("delete this pattern!");
      delete_pat();
    }
    if((keyPressed)&&(keyCode==LEFT)&&(millis()%5==0)){positionX=positionX-tile_size;}
    if((keyPressed)&&(keyCode==RIGHT)&&(millis()%5==0)){positionX=positionX+tile_size;}
    if((keyPressed)&&(keyCode==UP)&&(millis()%5==0)){positionY=positionY-tile_size;}
    if((keyPressed)&&(keyCode==DOWN)&&(millis()%5==0)){positionY=positionY+tile_size;}
    //fill();
    noStroke();
  }
  
  //delete the pat from interface
  void delete_pat(){
     positionX=offsetx;
     positionY=offsety;
     pat_type=1;
     selected_tile=-1;
     pat_activated=-1;

  }
  
  //zoom in selected tile in revision MODE
  void zoom_view(){
    image( pat_image,positionX+10,positionY-110,positionX+110,positionY-10);
    noFill();
    stroke(255,0,0);
    rect(positionX+10,positionY-110,positionX+110,positionY-10);
    noStroke();
  } 
}
