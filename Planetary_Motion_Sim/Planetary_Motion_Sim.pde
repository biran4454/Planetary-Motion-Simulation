ArrayList<Particle> particles = new ArrayList<Particle>();
float globDistance, xDistance, yDistance;
float xPosA, xPosB, yPosA, yPosB, massA, massB, radiusA, radiusB;
void setup(){
  size(1000, 800);
  background(30);
  particles.add(new Particle( 50, 0, 0, 0, 5.98e+12, 5));
  particles.add(new Particle( 0, 50, 0, 0, 5.98e+12, 5));
  for(int i = 0; i < particles.size(); i++){
    particles.get(i).setID(i);
  }
  //frameRate(1);
}

void draw(){
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
}
