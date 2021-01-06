class GameObject{
  protected PVector location;
  protected int radius;
  protected int mass;
  
  void display(){
   ellipse(location.x,location.y,radius,radius); 
  }
}
