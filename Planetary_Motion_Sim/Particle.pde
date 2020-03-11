public class Particle{
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
  private float gAccX, gAccY;
  
  public PVector pubP, pubV, pubAcc;
  void drawParticle(){
    ////////  DRAWING  \\\\\\\\
    if(ID == 0){ // Gives them different colours
      stroke(255, 0, 0);
    } else {
      stroke(0, 255, 0);
    }
    strokeWeight(radius * 2);
    point(stpX(p.x), stpY(p.y)); // IMPORTANT: x values are with centre 0. stp() converts back to Processing format (left side of screen 0)
    
    ////////  CALCULATIONS  \\\\\\\\
    
    float distance, otherMass, otherX, otherY, otherRadius, xDist, yDist;
    int xDirection, yDirection; // If positive, pulls to the right, if negative, pulls to the left
    
    ///  Get other particles properties  ///
    if(ID == 0){
      otherMass = massB;
      otherX = xPosB;
      otherY = yPosB;
      otherRadius = radiusB;
      distance = globDistance;
      xDist = xDistance;
      yDist = yDistance;
    } else {
      otherMass = massA;
      otherX = xPosA;
      otherY = yPosA;
      otherRadius = radiusA;
      distance = globDistance;
      xDist = xDistance;
      yDist = yDistance;
    }
    ///  Get direction (-1 = L, 1 = R) to other particle  ///
    if(p.x > otherX){
      xDirection = -1;
    } else if(p.x < otherX){
      xDirection = 1;
    } else {
      xDirection = 0;
    }
    if(p.y > otherY){
      yDirection = -1;
    } else if(p.y < otherY){
      yDirection = 1;
    } else {
      yDirection = 0;
    }
    ///  Do physics!  ///
    if(xDist > radius + otherRadius){ // If they aren't touching
      gAccX = (6.6726e-11 * mass * otherMass) / (distance * distance); // Get force between them  // SHOULD THIS BE xDist * yDist OR distance * distance ?
      gAccX = (gAccX / mass) * xDirection;
      
      acc.set(gAccX, acc.y); // Update accelleration
      //v.add(acc.div(60)); // Update velocity
    }
    if(yDist > radius + otherRadius){
      gAccY = (6.6726e-11 * mass * otherMass) / (distance * distance); // Get force between them  // SHOULD THIS BE xDist * yDist OR distance * distance ?
      gAccY = (gAccY / mass) * yDirection;
      
      acc.set(acc.x, gAccY); // Update accelleration
      //v.add(acc.div(60)); // Update velocity  // SHOULD THERE BE TWO UPDATES OF VELOCITY IF ABOVE UPDATE RUN?
    }
    if(xDist > radius + otherRadius || yDist > radius + otherRadius){
      v.add(acc.div(60));
    }
    p.add(v); // TODO: x time              // ALL OF THIS PRODUCES GOOD RESULTS WHEN X1 = X2 OR Y1 = Y2 OR X1 = Y2 ETC., BUT NOT WHEN THEY'RE DIFFERENT. WHY?  //<>//
  }
  void publishVariables(){
    pubP = p;
    pubV = v;
    pubAcc = acc;
  }
  void setID(int id){
    ID = id;
  }
  float stpX(float x){
    return(x + width / 2);
  }
  float stpY(float y){
    return(height / 2 - y);
  }
}
