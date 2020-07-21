//Each Patline storages density, pattern type, start point and end point of a line
//of tiles.After a patline is well-defined, all the tiles in the patline will be
//stored in a more basic data-structure: a pattern(tactilepattern is a self-defined 
//class) array
class Patline{
  float density=100;//density of tile
  int startX=offsetx,startY=offsety,endX=offsetx,endY=offsety;//start/end point of line
  int patline_state=0;//a variable to record the current state of paving
  int tile_size=20;//size of tile
  int patline_type=1;//pattern type of the line
  //declaraction
  Patline(){
    ;
  }
  //patline_state:
  //0:inactivated 1:paving Point1 2:paving Point2 3:finished paving, adjusting parameters
  //4:saving the row/column 5:unqualified line input, back to inactivated mode
  void paving_line(){
    if((patline_state==0)&&(mousePressed)&&(mouse_on_map(mouseX,mouseY))){
      startX=mouseX;
      startY=mouseY;
      patline_state=1;
    }
    else if(((patline_state==1)||(patline_state==2))&&(!mousePressed)){
      endX=mouseX;
      endY=mouseY;
      preview();
      strokeWeight(4); 
      stroke(255,0,0);
      if(line_scope()<3){
        line(startX,startY,endX,endY);
      }
      patline_state=2;
    }
    else if((patline_state==2)&&(mousePressed)&&(mouse_on_map(mouseX,mouseY))){
      line(startX,startY,endX,endY);
      patline_state=3;
    }
    else if((patline_state==3)){
      strokeWeight(4); 
      stroke(255,0,0);
      switchxy(startX,startY,endX,endY);
      adjust_line();
      if(line_scope()!=3){//we only allow input of horizontal/vertical lines
        if(line_scope()==1){line(startX,startY,endX,startY);}
        else if(line_scope()==2){line(startX,startY,startX,endY);}
        realtime_pave_tile();
      }else{
        patline_state=5;
      }
    }
    else if(patline_state==4){
      pave_tile();
      patline_state=0;
    }
    else if((patline_state==5)&&(!mousePressed)){
      patline_state=0;
    }
    noStroke();
  }
  //real-time pave(patline_state=3),users can adjust parameters,position of lines at this step
  void realtime_pave_tile(){
    density=Pave_dens_slider.getValue();
    if(But_Patlinetype.getValue()>0){patline_type=int(But_Patlinetype.getValue());}
    TactilePattern temp_tile=new TactilePattern();
    if(line_scope()==1){
      for(int i=int(startX);i<=(endX);i+=tile_size*(6-0.05*density)){
        temp_tile.pat_activated=1;
        temp_tile.positionX=i-(i-offsetx)%tile_size;
        temp_tile.positionY=startY-(startY-offsety)%tile_size;
        temp_tile.select_type(patline_type);
        temp_tile.draw_pat();
      }
    }
    if(line_scope()==2){
      for(int i=int(startY);i<=(endY);i+=tile_size*(6-0.05*density)){
        temp_tile.pat_activated=1;
        temp_tile.positionY=i-(i-offsety)%tile_size;
        temp_tile.positionX=startX-(startX-offsetx)%tile_size;
        temp_tile.select_type(patline_type);
        temp_tile.draw_pat();
      }
    }
  }
  //(patline_state=4)draw the confirmed paving line with density, save it into tile_group
  void pave_tile(){
    density=Pave_dens_slider.getValue();
    if(line_scope()==1){
      for(int i=int(startX);i<=(endX);i+=tile_size*(6-0.05*density)){
        tile_group[tile_num].pat_activated=1;
        tile_group[tile_num].positionX=i-(i-offsetx)%tile_size;
        tile_group[tile_num].positionY=startY-(startY-offsety)%tile_size;
        tile_group[tile_num].select_type(patline_type);
        tile_num+=1;
      }
    }
    if(line_scope()==2){
      for(int i=int(startY);i<=(endY);i+=tile_size*(6-0.05*density)){
        tile_group[tile_num].pat_activated=1;
        tile_group[tile_num].positionY=i-(i-offsety)%tile_size;
        tile_group[tile_num].positionX=startX-(startX-offsetx)%tile_size;
        tile_group[tile_num].select_type(patline_type);
        tile_num+=1;
      }
    }
  }
  
  //judge whether the mouse is on the map
  boolean mouse_on_map(float x, float y){
    boolean mouse_on=false;
    if((x>offsetx)&&(y>offsety)){
      mouse_on=true;
    }
    return mouse_on;
  }
  
  //judge whether the drawn line is horizontal:1/vertical:2/others:3
  int line_scope(){
    float dy=endY-startY;
    float dx=endX-startX;
    if((dy==0)&&(dx!=0)){return 1;}
    if((dx==0)&&(dy!=0)){return 2;}
    float scope=dy/dx;
    if((scope<0.13)&&(scope>-0.13)){return 1;}
    if((scope>8)||((scope<-8))){return 2;}
    return 3;
  }
  //preview when paving
  void preview(){
    TactilePattern temp=new TactilePattern();
    if(But_Patlinetype.getValue()>0){temp.select_type(int(But_Patlinetype.getValue()));}
    else{temp.select_type(1);}
    int tempx=mouseX-(mouseX-offsetx)%tile_size;
    int tempy=mouseY-(mouseY-offsety)%tile_size;
    if((line_scope()<3)&&(mouse_on_map(mouseX,mouseY))){
      image(temp.pat_image,mouseX+10,mouseY-110,mouseX+110,mouseY-10);
      image(temp.pat_image,tempx,tempy,tempx+tile_size,tempy+tile_size);
    }else{
      stroke(255,0,0);
      line(tempx,tempy,tempx+tile_size,tempy+tile_size);
      line(tempx,tempy+tile_size,tempx+tile_size,tempy);
      noStroke();
    }
  }
  //switch x1 x2 if x1<x2 ; y same 
  void switchxy(int x1,int y1,int x2,int y2){
    if(x1>x2){int temp=startX;startX=endX;endX=temp;}
    if(y1>y2){int temp=startY;startY=endY;endY=temp;}
  }
  
  //(patline_state=3),adjust the postion of the line, using keyboard
  void adjust_line(){
    if((keyPressed)&&(keyCode==LEFT)&&(millis()%5==0)){startX=startX-tile_size;endX=endX-tile_size;}
    if((keyPressed)&&(keyCode==RIGHT)&&(millis()%5==0)){startX=startX+tile_size;endX=endX+tile_size;}
    if((keyPressed)&&(keyCode==UP)&&(millis()%5==0)){startY=startY-tile_size;endY=endY-tile_size;}
    if((keyPressed)&&(keyCode==DOWN)&&(millis()%5==0)){startY=startY+tile_size;endY=endY+tile_size;}
  }
}
