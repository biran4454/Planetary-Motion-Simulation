import peasy.*; //<>//
/*
  Changed in this version:
    . added changelogs
    . made G and mass 10^9 times larger/smaller
    . any number of particles
  Finished: true
  Working: true
*/
ArrayList<Particle> particles = new ArrayList<Particle>();
ArrayList<Float> xPos = new ArrayList<Float>();
ArrayList<Float> yPos = new ArrayList<Float>();
ArrayList<Float> allMass = new ArrayList<Float>();
ArrayList<Float> allRadius = new ArrayList<Float>();
ArrayList<ArrayList> globDistances = new ArrayList<ArrayList>();
ArrayList<ArrayList> xDistances = new ArrayList<ArrayList>();
ArrayList<ArrayList> yDistances = new ArrayList<ArrayList>();
ArrayList[] variables = {xPos, yPos, allMass, allRadius, globDistances, xDistances, yDistances};

//float globDistance, xDistance, yDistance;
//float xPosA, xPosB, yPosA, yPosB;
//float massA, massB, radiusA, radiusB;
boolean isPaused;
int tick, debugCount;

PeasyCam cam;

void clearVariables(){
  xPos.clear();
  yPos.clear();
  allMass.clear();
  allRadius.clear();
  globDistances.clear();
  xDistances.clear();
  yDistances.clear();
}

void setup(){
  size(1000, 800, P3D);
  PeasyCam cam = new PeasyCam(this, 6000);
  cam.setMaximumDistance(7000);
  cam.setMinimumDistance(100);
  background(30);
  particles.add(new Particle( 50, 50, 0, 0, 5.98e+3, 5));
  particles.add(new Particle( -50, -50, 0, 0, 5.98e+3, 5));
  particles.add(new Particle( 50, -50, 0, 0, 5.98e+3, 5));
  particles.add(new Particle( -50, 50, 0, 0, 5.98e+3, 5));
  for(int i = 0; i < particles.size(); i++){
    particles.get(i).setID(i);
  }
  isPaused = false;
  tick = 0;
  debugCount = 0;
  //frameRate(30);
}

void draw(){
  pointLight(255, 255, 255, 0, 0, 0);
  ambientLight(200, 200, 200);
  if((! isPaused) || (debugCount > 1)){
    background(30); //<>//
    clearVariables();
    for(int i = 0; i < particles.size(); i++){ //<>//
      xPos.add(particles.get(i).pubP.x);
      yPos.add(particles.get(i).pubP.y);
      allMass.add(particles.get(i).mass);
      allRadius.add(particles.get(i).radius);
    }
    for(int i = 0; i < xPos.size(); i++){
      ArrayList<Float> distances = new ArrayList<Float>();
      ArrayList<Float> x = new ArrayList<Float>();
      ArrayList<Float> y = new ArrayList<Float>();
      for(int j = 0; j < xPos.size(); j++){
        if(i == j){
          distances.add(0.0);
          x.add(0.0);
          y.add(0.0);
          continue;
        }
        distances.add( sqrt(pow(abs(xPos.get(i) - xPos.get(j)), 2) + pow(abs(yPos.get(i) - yPos.get(j)), 2)) ); // pythag
        
        x.add(abs(xPos.get(i) - xPos.get(j)));
        y.add(abs(yPos.get(i) - yPos.get(j)));
      }
      globDistances.add(distances);
      xDistances.add(x);
      yDistances.add(y);
    }
    
    for(Particle particle : particles){
      particle.drawParticle();
    }
    for(Particle particle : particles){
      particle.publishVariables();
    }
    if(debugCount > 0){
      debugCount--;
    }
    tick++;
  }
  if((keyPressed && key == ' ' && !isPaused) || (debugCount == 1 && isPaused)){
    if(debugCount == 1){
      debugCount = 0;
      delay(100);
    }
    String[] debugData = debug();
    for(int i = 0; i < debugData.length - 1; i++){
      println(debugData[i]);
    }
    println("******** END OF DEBUG INFO ********");
    println("");
    println("Press 'a' to continue once");
    println("Press 's' to continue five frames");
    println("Press 'w' to continue 20 frames");
    println("Press 'd' to enter Processing debug mode (if enabled)");
    println("Press 'f' to set framerate to 20 fps");
    println("Press 'v' to set framerate to 1 fps");
    println("Press 'r' to set framerate to 60 fps");
    println("Press any other key to unpause");
    isPaused = true;
  }
  if(isPaused && keyPressed && debugCount == 0){
    if(key != ' ' && key != 'a' && key != 's' && key != 'd' && key != 'w'  && key != '%' && key != 'f' && key != 'v' && key != 'r'){
      isPaused = false;
    }
    if(key == 'a'){
      debugCount = 2;
    }
    if(key == 's'){
      debugCount = 6;
    }
    if(key == 'w'){
      debugCount = 21;
    }
    if(key == 'f'){
      frameRate(20);
    }
    if(key == 'v'){
      frameRate(1);
    }
    if(key == 'r'){
      frameRate(60);
    }
    if(key == 'd'){
      println("Debug");
    }
    key = '%'; // Random charector to prevent wrong key detection
  }
}
String[] debug(){
  String[] result = new String[21];
  result[0] = "********* DEBUG INFO ***********";
  result[1] = "   ** GLOBAL   **";
  result[2] = "ITERATION";
  result[3] = str(tick);
  result[4] = "";//"DISTANCE";
  result[5] = "";//str(globDistance);
  result[6] = "";//str(xDistance) + ", " + str(yDistance);
  
  result[7] = "   ** OBJECT 1 **";
  result[8] = "POSITION";
  result[9] = str(particles.get(0).pubP.x) + ", " + str(particles.get(0).pubP.y);
  result[10] = "VELOCITY";
  result[11] = str(particles.get(0).pubV.x) + ", " + str(particles.get(0).pubV.y);
  result[12] = "GRAVITY";
  result[13] = str(particles.get(0).pubAcc.x) + ", " + str(particles.get(0).pubAcc.y);
  
  result[14] = "   ** OBJECT 2 **";
  result[15] = "POSITION";
  result[16] = str(particles.get(1).pubP.x) + ", " + str(particles.get(1).pubP.y);
  result[17] = "VELOCITY";
  result[18] = str(particles.get(1).pubV.x) + ", " + str(particles.get(1).pubV.y);
  result[19] = "GRAVITY";
  result[20] = str(particles.get(1).pubAcc.x) + ", " + str(particles.get(1).pubAcc.y);
  return(result);
}
