class Button{
 int x;
 int y;
 int thiccness;
 int longness;
 String txt;
 
 
  Button(int x,int y, int w,int h, String text){
   this.x = x;
   this.y = y;
   this.thiccness = w;
   this.longness = h;
   this.txt = text;
 }
 
 void display(){
   fill(0);
   rect(x,y,thiccness,longness);
   fill(#FFFFFF);
   text(txt,x+10,y+25);
 }

}
