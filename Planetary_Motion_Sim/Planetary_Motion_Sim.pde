ArrayList<Particle> particles = new ArrayList<Particle>();
void setup(){
  size(1000, 800, P3D);
  background(30);
  particles.add(new Particle(-10, height / 2, 0, 0, 5.98e+23, 10));
  particles.add(new Particle( 10, height / 2, 0, 0, 10, 10));
  for(int i = 0; i < particles.size(); i++){
    particles.get(i).setID(i);
  }
  frameRate(10);
}
void draw(){
  background(30);
  for(Particle particle : particles){
    particle.drawParticle();
  }
}
