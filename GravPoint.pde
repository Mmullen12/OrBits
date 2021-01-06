class GravPoint extends GameObject{
  final private int gConst = 1;
  

  public GravPoint(int xPos,int yPos,int r, int m ){
    this.location = new PVector(xPos,yPos);
    this.radius = r;
    this.mass = m;
  }

  public int getG(){
    return gConst;
  }
  
  public PVector attract(Satellite mover){
    // direction
    PVector force = PVector.sub(location,mover.location);
    float d= force.mag();
    d = d/3;
    //d = constrain(d,5,25);
    force.normalize();
    
    //magnitude
    float strength = (this.getG() * mass * mover.mass) / (d*d);
    force.mult(strength);
    return force;
  }
  
  public boolean hasCrashed(Satellite mover){
    int radiiSum = GRAVRADIUS/2;
    float d = dist(location.x,location.y,mover.location.x,mover.location.y);
    if(d < radiiSum){
     return true; 
    }
    return false;
  }
  
}
