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
  private double gAccX, gAccY;
  
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
    float distance, otherMass, otherRadius;
    float otherX, otherY, xDist, yDist;
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
    double gAcc = ((6.6726e-11 * mass * otherMass) / (distance * distance)) / mass; // Get force between them
    float setX, setY;
    setX = acc.x;
    setY = acc.y;
    /*if(abs(xDist) > radius + otherRadius){ // Avoid / by 0
      gAccX = gAcc * xDirection;
      gAccX = gAccX * cos(atan(yDist / xDist));
      setX = (float)gAccX;
      
      //acc.set(gAccX, acc.y); // Update accelleration
    }
    if(abs(yDist) > radius + otherRadius){
      gAccY = gAcc * yDirection;
      gAccY = gAccY * sin(atan(yDist / xDist));
      setY = (float)gAccY;
      //acc.set(acc.x, gAccY); // Update accelleration
    }*/
    if(abs(distance) > radius + otherRadius){
      if(xDist != 0){
        gAccX = gAcc * xDirection;
        gAccX = gAccX * cos(atan(yDist / xDist));
        setX = (float)gAccX;

        gAccY = gAcc * yDirection;
        gAccY = gAccY * sin(atan(yDist / xDist));
        setY = (float)gAccY;
      }
    }
    acc.set(0, 0);
    acc.set(setX, setY);
    //acc.(setY / setX);
    if(abs(distance) > radius + otherRadius){
      v.add(acc.div(60));
    }
    p.add(v); // TODO: x time              // ALL OF THIS PRODUCES GOOD RESULTS WHEN X1 = X2 OR Y1 = Y2 OR X1 = Y2 ETC., BUT NOT WHEN THEY'RE DIFFERENT. WHY? 
    //if(ID == 0){
      strokeWeight(4);
      stroke(255);
      line(stpX(p.x), stpY(p.y), stpX(p.x + acc.x * 1500), stpY(p.y + acc.y * 1500));
      stroke(255, 255, 0);
      line(stpX(p.x), stpY(p.y), stpX(p.x + v.x * 100), stpY(p.y + v.y * 100));
      //println(acc.x, acc.y);
    //}  //<>//
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
