//class EnvFac includes infomation of all environmental factors and related
//functions:annotating and drawing
class EnvFac{
  //Variables
  int env_type;//0-wall-black 1-door-green 2-special place of interest-blue 3-stair and lift-red 4-pillar and furniture-purple 5-non-walkable places-grey
  int maxnum=100;//maxnum of env factors
  int envnum=0;//number of environmental factors
  int [][]env=new int[maxnum][5];//2-d array to restore env factors
  int env_state=0;//a variable to record the current state of annotating
  
  //Declaration
  EnvFac(){
    env_type=-1;
    for(int i=0;i<maxnum;i++){
      for(int j=0;j<5;j++){
        env[i][j]=-1;
      }
    }
  }
   
  //Annotate env_fac & Store Current env_fac
  //state=0 ready to annotate
  //state=1 first point confirmed
  //state=2 setting second point mouseLEFT:confirm mouseRIGHT:cancel
  //state=3 rectangle confirmed, state jump to 0
  void annotate_env(){
    if((env_state==0)&&(mousePressed)&&(mouseButton==LEFT)&&(Inmaprange(mouseX,mouseY))){
      env[envnum][0]=mouseX;
      env[envnum][1]=mouseY;
      env[envnum][2]=mouseX;
      env[envnum][3]=mouseY;
      env[envnum][4]=int(But_Placetype.getValue());
      env_state++;
    }
    else if((env_state==1)&&(!mousePressed)){
      env_state++;
    }
    else if((env_state==2)&&(mousePressed)&&(mouseButton==RIGHT)){
      env[envnum][3]=env[envnum][1];
      env[envnum][2]=env[envnum][0];
      env_state=0;
    }
    else if((env_state==2)&&(mousePressed)&&(mouseButton==LEFT)){
      env[envnum][2]=mouseX;
      env[envnum][3]=mouseY;
      env_state++;
      envnum++;
    }
    else if(env_state==2){
      env[envnum][2]=mouseX;
      env[envnum][3]=mouseY;
    }
    else if((env_state==3)&&(!mousePressed)){
      env_state=0;
    }
  }
  
  //Use Icon to annotate env_fac
  void icon_env(){
    print("Hello world!");
  }
  
  //Draw all annotated env_fac
  void draw_env(){
    for(int i=0;i<=envnum;i++){      
      if(env[i][4]==1){
        fill(color(0,0,0));//black,wall
        rect(env[i][0],env[i][1],env[i][2],env[i][3]);
      }else if(env[i][4]==2){
        fill(color(0,255,0));//green,door
        rect(env[i][0],env[i][1],env[i][2],env[i][3]);
      }else if(env[i][4]==3){
        fill(color(0,0,255));//blue,place of interest,can be replaced by icons
        rect(env[i][0],env[i][1],env[i][2],env[i][3]);
      }else if(env[i][4]==4){
        fill(color(255,0,0));//red, stairs
        rect(env[i][0],env[i][1],env[i][2],env[i][3]);
      }else if(env[i][4]==5){
        fill(color(255,0,255));//purple, furniture
        rect(env[i][0],env[i][1],env[i][2],env[i][3]);
      }else if(env[i][4]==6){
        fill(color(190,190,190));//grey, non-walkable places
        rect(env[i][0],env[i][1],env[i][2],env[i][3]);
      }else{
      //print("error happens when drawing!");
      }
    }
  }
  //Judge whether the mouse is in the canvas
  boolean Inmaprange(int x,int y){
    if((y<=windowheight)&&(x<=windowwidth)&&(x>=offsetx)&&(y>=offsety)){
      return true;
    }
    return false;
  }
}
