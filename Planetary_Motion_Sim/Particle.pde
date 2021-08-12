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
  }
  public int ID;
  private PVector p, v, acc;
  public float mass, radius;
  
  public PVector pubP, pubV, pubAcc;
  void drawParticle(){
    ////////  DRAWING  \\\\\\\\
    stroke(min(ID * 50, 255), min(255 - ID * 50, 255), 0); 
    //strokeWeight(radius * 2);
    /*translate(stpX(p.x), stpY(p.y)); // IMPORTANT: x values are with centre 0. stp() converts back to Processing format (left side of screen 0)
    sphere(radius * 2);
    translate(0 - stpX(p.x), 0 - stpY(p.y));*/
    
    // Just testing this. Uncomment lines 21, 22, 23 for normal function.
    translate(stpX(0), stpY(0));  // Why doesn't this appear at the centre
    sphere(radius * 2);
    translate(0 - stpX(0), 0 - stpY(0));
    translate(stpX(10), stpY(10));
    sphere(radius * 2);
    translate(0 - stpX(10), 0 - stpY(10));
    translate(stpX(-10), stpY(10));
    sphere(radius * 2);
    translate(0 - stpX(-10), 0 - stpY(10));
    translate(stpX(10), stpY(-10));
    sphere(radius * 2);
    translate(0 - stpX(10), 0 - stpY(-10));
    translate(stpX(-10), stpY(-10));
    sphere(radius * 2);
    translate(0 - stpX(-10), 0 - stpY(-10));
    
    

    //ArrayList<Float> myDistances = globDistances.get(ID);
    ArrayList<Float> myXDistances = xDistances.get(ID);
    ArrayList<Float> myYDistances = yDistances.get(ID);
    ArrayList<Integer> myXDirections = new ArrayList<Integer>(); // can we use PVector here?
    ArrayList<Integer> myYDirections = new ArrayList<Integer>();
    ArrayList<Float> gAccX = new ArrayList<Float>();
    ArrayList<Float> gAccY = new ArrayList<Float>();
    ArrayList<PVector> allForces = new ArrayList<PVector>();
    
    ///  Get direction (-1 = L, 1 = R) to other particle  ///
    for(int i = 0; i < xPos.size(); i++){ // Do physics relative to each other particle
      if(i == ID){
        continue; // no use doing physics for myself!
      }
      float otherX = xPos.get(i);
      float otherY = yPos.get(i);
      if(p.x > otherX){             // Problem could be in these sections
        myXDirections.add(-1);
      } else if(p.x < otherX){
        myXDirections.add(1);
      } else {
        myXDirections.add(0); // Change this for huuuuugly different results
      }
      if(p.y > otherY){
        myYDirections.add(-1);
      } else if(p.y < otherY){
        myYDirections.add(1);
      } else {
        myYDirections.add(0);
      }
      float gAcc = ((6.6726e-1 * mass * allMass.get(i)) / ((float)globDistances.get(ID).get(i) * (float)globDistances.get(ID).get(i))) / mass; // NOTE: G is e-11 not e-1, but it's toooooo slooooooow
      
      if(abs((float)globDistances.get(ID).get(i)) > radius + allRadius.get(i)){
        /*if((float)myXDistances.get(i) != 0){ // Is this bad? Maybe we should just assume y/x = 0 or y
          gAccX.add(gAcc * myXDirections.get(0));
          gAccX.set(gAccX.size() - 1, gAccX.get(gAccX.size() - 1) * cos(atan(myYDistances.get(i) / myXDistances.get(i)))); // is maths correct here?
  
          gAccY.add(gAcc * myYDirections.get(0));
          gAccY.set(gAccX.size() - 1, gAccY.get(gAccX.size() - 1) * sin(atan(myYDistances.get(i) / myXDistances.get(i))));
        }*/
        gAccX.add(gAcc * myXDirections.get(myXDirections.size() - 1));
        gAccY.add(gAcc * myYDirections.get(myYDirections.size() - 1));
        if((float)myXDistances.get(i) != 0){ // Is this bad? Maybe we should just assume y/x = 0 or y
          gAccX.set(gAccX.size() - 1, gAccX.get(gAccX.size() - 1) * cos(0));
        } else {
          gAccX.set(gAccX.size() - 1, gAccX.get(gAccX.size() - 1) * cos(atan(myYDistances.get(i) / myXDistances.get(i))));
        }
        if((float)myXDistances.get(i) != 0){
          gAccY.set(gAccX.size() - 1, gAccY.get(gAccX.size() - 1) * sin(0));
        } else {
          gAccY.set(gAccX.size() - 1, gAccY.get(gAccX.size() - 1) * sin(atan(myYDistances.get(i) / myXDistances.get(i))));
        }
      }
    }
    for(int i = 0; i < gAccX.size(); i++){
      allForces.add(new PVector(gAccX.get(i), gAccY.get(i)));
    }
    for(int i = 0; i < allForces.size(); i++){
      acc.add(allForces.get(i));
    }
    v.add(acc.div(60));
    p.add(v);
/*
    float setX, setY;
    setX = acc.x;
    setY = acc.y;
    if(abs(distance) > radius + otherRadius){ // All this needs to go in the bracket above at some point (I hope)
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
    //} */ //<>//
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
