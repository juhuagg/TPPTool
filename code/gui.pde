//gui include 5 groups of controlling units,which are (1)loading/saving maps
//(2)annotating POI (3)paving tiles in lines (4)paving tiles one by one
//(5)revising existing tiles
void gui() {
  cp5 = new ControlP5(this);
  
  // group number 1:load/save map
  Group g1 = cp5.addGroup("Load Map")
                .setBackgroundColor(color(0,64))
                .setBackgroundHeight(80)
                ;
  cp5.addButton("LoadMap")
     .setValue(0)
     .setPosition(10,10)
     .setSize(50,60)
     .moveTo(g1)
     .plugTo(this,"loadmap");
     ;
  cp5.addButton("CloseMap")
     .setValue(0)
     .setPosition(70,10)
     .setSize(50,60)
     .moveTo(g1)
     .plugTo(this,"closemap");
     ;
  cp5.addButton("SavePic")
     .setValue(100)
     .setPosition(130,10)
     .setSize(50,60)
     .moveTo(g1)
     .plugTo(this,"savepic");
     ;
     
  // group number 2, annotate environmental factors
  Group g2 = cp5.addGroup("Annotate environmental Factors")
                .setBackgroundColor(color(0, 64))
                .setBackgroundHeight(130)
                ;
  But_AnnotatePlace=cp5.addRadioButton("But_AnnotatePlace")
      .setPosition(10,10)
      .setSize(130,40)
      .setColorForeground(color(120))
      .setColorActive(color(255,200,255))
      .setColorLabel(color(120))
      .addItem("Annotation Mode",1)
      .moveTo(g2)
      ;
  But_Placetype=cp5.addRadioButton("But_placetype")
      .setPosition(10,60)
      .setSize(40,20)
      .setColorForeground(color(120))
      .setColorActive(color(255,200,255))
      .setColorLabel(color(120))
      .setItemsPerRow(2)
      .setSpacingColumn(50)
      .addItem("Wall",1)
      .addItem("Door",2)
      .addItem("POI",3)
      .addItem("Stair&Lift",4)
      .addItem("Furniture",5)
      .addItem("Non-walkable",6)
      .moveTo(g2)
      ;
  //group3:pave a line of tile
  Group g3 = cp5.addGroup("Pave tiles in lines")
                .setBackgroundColor(color(0, 64))
                .setBackgroundHeight(200)
                ;
  But_Paveline=cp5.addRadioButton("But_Paveline")
     .setPosition(10,10)
     .setSize(130,40)
     .setColorForeground(color(120))
     .setColorActive(color(255,200,255))
     .setColorLabel(color(120))
     .addItem("Pave in line",1)
     .moveTo(g3)
     ;
  But_Patlinetype=cp5.addRadioButton("But_linePattype")
      .setPosition(10,60)
      .setSize(40,20)
      .setColorForeground(color(120))
      .setColorActive(color(255,200,255))
      .setColorLabel(color(120))
      .setItemsPerRow(2)
      .setSpacingColumn(50)
      .addItem("PATTERN 1",1)
      .addItem("PATTERN 2",2)
      .addItem("PATTERN 3",3)
      .addItem("PATTERN 4",4)
      //.addItem("Pattern 5",5)
      .moveTo(g3)
      ;
  Pave_dens_slider=cp5.addSlider("density")
     .setPosition(10,110)
     .setSize(130,20)
     .setRange(0,100)
     .setValue(200)
     .setNumberOfTickMarks(6)
     .moveTo(g3)
     ;
  cp5.addButton("Save Pave Line")
     .setValue(100)
     .setPosition(10,140)
     .setSize(130,20)
     .moveTo(g3)
     .plugTo(this,"savepaveline");
     ;
  cp5.addButton("Cancel Pave Line")
     .setValue(100)
     .setPosition(10,170)
     .setSize(130,20)
     .moveTo(g3)
     .plugTo(this,"cancelpaveline");
     ;
  // group number 4, Pave single tile
  Group g4 = cp5.addGroup("Pave Tile one by one")
                .setBackgroundColor(color(0, 64))
                .setBackgroundHeight(120)
                ;
  But_Pave=cp5.addRadioButton("But_PaveTheRoad")
     .setPosition(10,10)
     .setSize(130,40)
     .setColorForeground(color(120))
     .setColorActive(color(255,200,255))
     .setColorLabel(color(120))
     .moveTo(g4)
     .addItem("Pave",1)
     ; 
  But_Pattype=cp5.addRadioButton("But_Pav_Pattype")
      .setPosition(10,60)
      .setSize(40,20)
      .setColorForeground(color(120))
      .setColorActive(color(255,200,255))
      .setColorLabel(color(120))
      .setItemsPerRow(2)
      .setSpacingColumn(50)
      .addItem("Pattern 1",1)
      .addItem("Pattern 2",2)
      .addItem("Pattern 3",3)
      .addItem("Pattern 4",4)
      //.addItem("Pattern 5",5)
      .moveTo(g4)
      ;
  //group5:revise patterns  
  Group g5 = cp5.addGroup("Revise existing tiles")
                .setBackgroundColor(color(0, 64))
                .setBackgroundHeight(150)
                ;
  But_Revise=cp5.addRadioButton("But_Revise")
     .setPosition(10,10)
     .setSize(130,40)
     .setColorForeground(color(120))
     .setColorActive(color(255,200,255))
     .setColorLabel(color(120))
     .addItem("Revise pattern",1)
     .moveTo(g5)
     ;
  cp5.addButton("Saverevise")
     .setValue(100)
     .setPosition(10,110)
     .setSize(130,20)
     .moveTo(g5)
     .plugTo(this,"saverevise");
     ; 
  Revise_Pattype=cp5.addRadioButton("But_revisePattype")
      .setPosition(10,60)
      .setSize(40,20)
      .setColorForeground(color(120))
      .setColorActive(color(255,200,255))
      .setColorLabel(color(120))
      .setItemsPerRow(2)
      .setSpacingColumn(50)
      .addItem("pattern 1",1)
      .addItem("pattern 2",2)
      .addItem("pattern 3",3)
      .addItem("pattern 4",4)
      //.addItem("Pattern 5",5)
      .moveTo(g5)
      ;
  
  // create a new accordion,add g1, g2,g3,g4 and g5 to the accordion.
  accordion = cp5.addAccordion("acc")
                 .setPosition(40,40)
                 .setWidth(210)
                 .addItem(g1)
                 .addItem(g2)
                 .addItem(g3)
                 .addItem(g4)
                 .addItem(g5)
                 ;
  //Keyboard control & Activate groups               
  cp5.mapKeyFor(new ControlKey() {public void keyEvent() {accordion.open(0,1,2,3,4);}}, 'o');
  cp5.mapKeyFor(new ControlKey() {public void keyEvent() {accordion.close(0,1,2,3,4);}}, 'c');
   accordion.open(0,1,2,3,4);
  //mode choose
  // use Accordion.MULTI to allow multiple group 
  // to be open at a time.
  accordion.setCollapseMode(Accordion.MULTI);
  
  //define rectMode: top-left and right-bottom point
  rectMode(CORNERS);
}
void loadmap(){
  openimg=1;//openimg0->1 loadmap
}
void closemap(){
  openimg=0;//openimg1->0 closemap
}
//save the annotated & paved map
void savepic(){
  PImage floormap=get(offsetx, offsety,roommap.width,roommap.height);
  floormap.save("floormap.jpg");
} 

//savepaveline: save the paveline & reset patline state to initial state
void savepaveline(){
  pat_line.patline_state+=1;
}
//cancelpaveline: cancel the paveline & cancel patline state to initial state
void cancelpaveline(){
  pat_line.patline_state=0;
}
//saverevise: save the revised tile and set selected_tile to NULL
void saverevise(){
  selected_tile=-1;
}

//But_ActivatePlace:mode1,But_Paveline:mode2,But_Pave:mode3,But_Revise:mode4
//At most one mode is activated at any time
//While activating one mode, deactivate all others
void mode_transfer(){
  if(MODE==1){
    But_Pave.deactivateAll();
    But_Pattype.deactivateAll();
    But_Paveline.deactivateAll();
    But_Patlinetype.deactivateAll();
    But_Revise.deactivateAll();
    Revise_Pattype.deactivateAll();
  }
  else if(MODE==2){
    But_AnnotatePlace.deactivateAll();
    But_Placetype.deactivateAll();
    But_Pave.deactivateAll();
    But_Pattype.deactivateAll();
    But_Revise.deactivateAll();
    Revise_Pattype.deactivateAll();
  }
  else if(MODE==3){
    But_AnnotatePlace.deactivateAll();
    But_Placetype.deactivateAll();
    But_Paveline.deactivateAll();
    But_Patlinetype.deactivateAll();
    But_Revise.deactivateAll();
    Revise_Pattype.deactivateAll();
  }
  else if(MODE==4){
    But_AnnotatePlace.deactivateAll();
    But_Placetype.deactivateAll();
    But_Pave.deactivateAll();
    But_Pattype.deactivateAll();
    But_Paveline.deactivateAll();
    But_Patlinetype.deactivateAll();
  }
  if((But_AnnotatePlace.getValue()==1)){MODE=1;}
  else if((But_Paveline.getValue()==1)){MODE=2;}
  else if((But_Pave.getValue()==1)){MODE=3;}
  else if((But_Revise.getValue()==1)){MODE=4;}
  else{MODE=0;}
}
