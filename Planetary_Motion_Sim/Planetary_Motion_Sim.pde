ArrayList<Particle> particles = new ArrayList<Particle>();
float globDistance, xDistance, yDistance;
float xPosA, xPosB, yPosA, yPosB;
float massA, massB, radiusA, radiusB;
boolean isPaused;
int tick, debugCount;
void setup(){
  size(1000, 800);
  background(30);
  particles.add(new Particle( 100, 0, 0, 0, 5.98e+12, 5));
  particles.add(new Particle( 0, 170, 0, 0, 5.98e+12, 5));
  for(int i = 0; i < particles.size(); i++){
    particles.get(i).setID(i);
  }
  isPaused = false;
  tick = 0;
  debugCount = 0;
  //frameRate(30);
}

void draw(){
  if((! isPaused) || (debugCount > 1)){
    background(30);
    xPosA = particles.get(0).pubP.x;
    xPosB = particles.get(1).pubP.x;
    yPosA = particles.get(0).pubP.y;
    yPosB = particles.get(1).pubP.y;
    massA = particles.get(0).mass;
    massB = particles.get(1).mass;
    radiusA = particles.get(0).radius;
    radiusB = particles.get(1).radius;
    
    globDistance = sqrt(pow(abs(xPosA - xPosB), 2) + pow(abs(yPosA - yPosB), 2));
    xDistance = abs(xPosA - xPosB);
    yDistance = abs(yPosA - yPosB);
    
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
      println("Debug"); //<>//
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
  result[4] = "DISTANCE";
  result[5] = str(globDistance);
  result[6] = str(xDistance) + ", " + str(yDistance);
  
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
