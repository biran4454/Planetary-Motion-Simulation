// VERSION COMPLETED - DO NOT EDIT //<>//
import peasy.*;
/*
  Changed in this version:
    . added changelogs
    . made G and mass 10^9 times larger/smaller
    . any number of particles
    . removed debug info
    . removed unnecessary commented out code
    . added more particles
    . all info stored in ArrayLists
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
  particles.add(new Particle( 50, -50, 0, 0, 5.98e+3, 5));  // Try swapping the order of these for cool different effects,
  particles.add(new Particle( -50, -50, 0, 0, 5.98e+3, 5)); // although that's not what's meant to happen because the
  particles.add(new Particle( 50, 50, 0, 0, 5.98e+3, 5));   // location is updated before all physics calculations
  particles.add(new Particle( -50, 50, 0, 0, 5.98e+3, 5));  // have completed.
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
    println("---");
    /*if(tick % 20 == 0){ // Uncomment to generate a particle each second. Notice that the effect differs depending on the initial vx and vy, making Newton very angry.
      particles.add(new Particle( 50, 50, 1, 0, 5.98e+3, 5));
    }*/
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
    println(xPos);
    println(yPos);
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
