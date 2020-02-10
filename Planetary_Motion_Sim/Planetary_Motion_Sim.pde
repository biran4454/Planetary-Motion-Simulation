ArrayList<Particle> particles = new ArrayList<Particle>();
float globDistance;
float xPosA, xPosB, massA, massB, radiusA, radiusB;
void setup(){
  size(1000, 800, P3D);
  background(30);
  particles.add(new Particle(-200, height / 2, 0, 0, 5.98e+13, 50));
  particles.add(new Particle( 200, height / 2, 0, 0, 5.98e+12, 5));
  for(int i = 0; i < particles.size(); i++){
    particles.get(i).setID(i);
  }
  //frameRate(1);
}

void draw(){
  background(30);
  globDistance = abs(particles.get(0).pubP.x - particles.get(1).pubP.x);
  xPosA = particles.get(0).pubP.x;
  xPosB = particles.get(1).pubP.x;
  massA = particles.get(0).mass;
  massB = particles.get(1).mass;
  radiusA = particles.get(0).radius;
  radiusB = particles.get(1).radius;
  
  for(Particle particle : particles){
    particle.drawParticle();
  }
  for(Particle particle : particles){
    particle.publishVariables();
  }
}
