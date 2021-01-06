class Satellite extends GameObject{
  PVector velocity = new PVector(3,0);
  PVector acceleration = new PVector(0,0);
  
  public Satellite(int xPos,int yPos,int r, int m){
    this.location = new PVector(xPos,yPos);
    this.radius = r;
    this.mass = m;
  }
  
  public void applyForce(PVector f){
    acceleration.add(PVector.div(f,mass));
  }
  
  public boolean edgeCollision(){
   if(location.x > WIDTH-SATRADIUS || location.x < SATRADIUS){
     return true;
   }
   else if(location.y > HEIGHT-SATRADIUS || location.y < SATRADIUS){
     return true;
   }
   return false;
  }
  
  
  void update(){
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }
}
