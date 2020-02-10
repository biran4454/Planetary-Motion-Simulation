public class Particle{ //<>//
  Particle(int x, int y, float vx, float vy, float mass, float radius){
    p = new PVector(x, y);
    pubP = p;
    v = new PVector(vx, vy);
    pubV = v;
    acc = new PVector(0, 0);
    pubAcc = acc;
    this.mass = mass;
    this.radius = radius;
  }/*
  Particle(int x, int y, float mass, float radius){
    p = new PVector(x, y);
    v = new PVector(0, 0);
    a = new PVector(0, 0);
    this.mass = mass;
    this.radius = radius;
    gAcc = ((6.6726e-11) * mass) / (radius * radius);
  }
  Particle(int x, int y){
    p = new PVector(x, y);
    v = new PVector(0, 0);
    a = new PVector(0, 0);
    mass = 100;
    radius = 10;
    gAcc = ((6.6726e-11) * mass) / (radius * radius);
  }*/
  public int ID;
  private PVector p, v, acc;
  public float mass, radius;
  private float gAcc;
  
  public PVector pubP, pubV, pubAcc;
  void drawParticle(){
    ////////  DRAWING  \\\\\\\\
    if(ID == 0){ // Gives them different colours
      stroke(255, 0, 0);
    } else {
      stroke(0, 255, 0);
    }
    strokeWeight(radius * 2);
    point(stp(p.x), p.y); // IMPORTANT: x values are with centre 0. stp() converts back to Processing format (left side of screen 0)
    
    ////////  CALCULATIONS  \\\\\\\\
    
    float distance, otherMass, otherX, otherRadius;
    int direction; // If positive, pulls to the right, if negative, pulls to the left
    
    ///  Get other particles properties  ///
    if(ID == 0){
      otherMass = massB;
      otherX = xPosB;
      otherRadius = radiusB;
      distance = globDistance;
    } else {
      otherMass = massA;
      otherX = xPosA;
      otherRadius = radiusA;
      distance = globDistance;
    }
    ///  Get direction (-1 = L, 1 = R) to other particle  ///
    if(p.x > otherX){
      direction = -1;
    } else if(p.x < otherX){
      direction = 1;
    } else {
      direction = 0;
    }
    ///  Do physics!  ///
    if(globDistance > radius + otherRadius){ // If they aren't touching
      gAcc = (6.6726e-11 * mass * otherMass) / (distance * distance); // Get force between them
      gAcc = (gAcc / mass) * direction;
      
      acc.set(gAcc, 0); // Update accelleration
      v.add(acc.div(60)); // Update velocity
    }
    p.add(v);    
  }
  void publishVariables(){
    pubP = p;
    pubV = v;
    pubAcc = acc;
  }
  void setID(int id){
    ID = id;
  }
  float stp(float x){
    return(x + width / 2);
  }
}
