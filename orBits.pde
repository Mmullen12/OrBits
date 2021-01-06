final int HEIGHT = 600;
final int WIDTH = 400;
final int GRAVRADIUS = 50;
final int SATRADIUS = 10;

final int GRAVMASS = 100;
final int SATMASS = 1;


import java.util.*;



void settings(){
size(WIDTH,HEIGHT);
}

int score;
ArrayList<Satellite> orBits = new ArrayList<Satellite>();
ArrayList<GravPoint> celestials = new ArrayList<GravPoint>();

boolean gameOn = true;
long lastClick;
Button button;
void setup(){
  lastClick = System.currentTimeMillis();
  orBits.clear();
  celestials.clear();
  score = 1;
    for(int i = 0;i<6;i++){
     orBits.add(new Satellite(WIDTH/2-25 + parseInt(random(1,30)),HEIGHT/2+60 + parseInt(random(1,30)) , SATRADIUS, SATMASS));  
  }
  celestials.add(new GravPoint(WIDTH/2-25,HEIGHT/2-25,GRAVRADIUS,GRAVMASS));
  button = new Button(WIDTH/2 - 50,HEIGHT/2 - 15,100,30,"reset");
  
}

void draw(){
  background(#555555);
  textSize(32);
  text(score,WIDTH/2 - 32,HEIGHT/10);
  
  for(GravPoint celestial:celestials){
    celestial.display();
  }
  
  for(Satellite orBit: orBits){
    orBit.update();
    orBit.display();
  }
  
  ArrayList<Satellite> toRemove = new ArrayList<Satellite>();
  for(GravPoint celestial:celestials){
    for(Satellite orBit: orBits){
      PVector force = celestial.attract(orBit);
      orBit.applyForce(force);
      if(orBit.edgeCollision() || celestial.hasCrashed(orBit)){
       toRemove.add(orBit);
      }
    }
  }
  
  if(toRemove.size() > 0){
    for(Satellite orBit: toRemove){
     removeOrBit(orBit);
    }
  }
  if(celestials.size() == 6){
   newLevel(); 
  }
  if(orBits.size() == 0){
   endScreen(); 
  }
}

void removeOrBit(Satellite orBit){
 Iterator itr = orBits.iterator();
 while(itr.hasNext()){
   Satellite item = (Satellite)itr.next();
   if(orBit == item){
     itr.remove();
   }
 }
}

void newLevel(){
  int celestialsCount = celestials.size();
  celestials.clear();
  celestials.add(new GravPoint(WIDTH/2-25,HEIGHT/2-25,GRAVRADIUS,GRAVMASS));
  int orBitCount = orBits.size();
  orBitCount += celestialsCount;
  orBits.clear();
  for(int i = 0;i<orBitCount;i++){
     orBits.add(new Satellite(WIDTH/2-25 + parseInt(random(1,30)),HEIGHT/2+60 + parseInt(random(1,30)) , SATRADIUS, SATMASS));  
  }
  return;
}

void endScreen(){
  background(#555555);
  gameOn = false;
  button.display();
  
}

//Long interval 
void mouseReleased(){
  if(gameOn && System.currentTimeMillis() - lastClick >= 500){
    lastClick = System.currentTimeMillis();
    boolean safe = true;
    for(GravPoint celestial:celestials){
     if(mouseX < celestial.location.x+50 && mouseX > celestial.location.x-50 && mouseY < celestial.location.y+50 && mouseY > celestial.location.y-50){
         safe = false;
     }
    }
    if(mouseX-50 < 0 || mouseX + 50 > WIDTH){
     safe = false; 
    }
    else if(mouseY-50 < 0 || mouseY + 50 > HEIGHT){
     safe = false; 
    }
   if(safe){
   celestials.add(new GravPoint(mouseX,mouseY,GRAVRADIUS,GRAVMASS)); 
   score++;
   }
  }
  else{
    if(mouseX > button.x && mouseX < button.x+button.thiccness && mouseY > button.y && mouseY < button.y+button.longness){
      gameOn = true;
      setup();
    }
  }
}
