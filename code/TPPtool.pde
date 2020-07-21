//A tile arranging,fabricating tool using processing3
//last time editted 2020.7.21

import controlP5.*;

//define classes in controlP5
ControlP5 cp5,pat_property;
Accordion accordion;
RadioButton But_Placetype,But_AnnotatePlace,But_Pattype,But_Pave,But_Paveline,But_Patlinetype,But_Revise,Revise_Pattype;
Slider Pave_dens_slider;
//self-defined classes
EnvFac roomenv;
TactilePattern []tile_group;
Patline pat_line;
//image of the room/space
PImage roommap;
//Width & Length of widnow
int windowwidth=1600;
int windowheight=900;
//position of the map in the interface
int offsetx=500;
int offsety=40;
//judging whether to load/conceal the room pic in the UI
int openimg=-1;
//Size of a minimum pattern unit, needs to be calculated
int tile_size=20;
//max allowed number of tiles
int max_tile_num=400;
//number of existing tiles (deleted tiles are also included)
int tile_num=0;
//the tile selected by mouseclick in revise mode
int selected_tile=-1;
//But_ActivatePlace:mode1,Pave:mode2,Pave_line:mode3,Revise:mode4
//At most one mode is activated at one time 
int MODE=0;
//occupied:prevent a place from being annotated/paved twice:CRRUENTLY NOT USED!!!
//boolean [][]occupied=new boolean[windowheight][windowwidth];

void setup() {
  size(1600, 900);
  noStroke();
  smooth();
  //allocage storage space to classes
  roomenv=new EnvFac();
  tile_group=new TactilePattern[max_tile_num];
  for (int i=0;i<max_tile_num;i++){
    tile_group[i]=new TactilePattern();
  }
  pat_line=new Patline();
  //read map.jpg
  roommap = loadImage("floorplan2.jpg");
  imageMode(CORNERS);
  //usr control module
  gui();
}

void draw() {
  background(220);
  //While activating one mode, deactivate all others
  mode_transfer();
  //load map image
  if(openimg==1){image(roommap, 500, 40);filter(GRAY);}
  ///////////////MODE=1:annotate envrionmental factors///////////////////
  if((But_Placetype.getValue()>0)&&(But_AnnotatePlace.getValue()>0)){
    roomenv.annotate_env();
  }
  roomenv.draw_env();
  //////////////MODE=2:arrange a single tile/////////////////////////////
  if((MODE==3)&&(But_Pattype.getValue()>0)){
    tile_group[tile_num].select_type(int(But_Pattype.getValue()));
    tile_group[tile_num].preview();//preview when paving
    if(tile_group[tile_num].ispaving()){
      tile_num+=1;
    }
  }
  //////////////MODE=3:arrange a line of tiles///////////////////////////
  if(MODE==2){
    pat_line.paving_line();
  }else{
    pat_line=new Patline();
  }
  ////////////MODE=4:select a tile and revise the selected tile//////////
  if(MODE==4){
    if((selected_tile==-1)){
      for(int i=0;i<tile_num;i++){
        if((tile_group[i].mouse_on_tile(mouseX,mouseY))&&(mousePressed)){
          selected_tile=i;
        }   
      }
    }else{
      tile_group[selected_tile].revise_pat();
    }
  }
  //Zoom view:a zoom view of the selected tile in revise MODE
  if(selected_tile!=-1){
    tile_group[selected_tile].zoom_view();
  }
  else{
    selected_tile=-1;
  }
  //draw all paved tiles
  for(int i=0;i<=tile_num;i++){
    tile_group[i].draw_pat();
  }
}
