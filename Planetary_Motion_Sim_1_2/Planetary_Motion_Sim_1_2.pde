/*

TODO:
* Give each particle an indevidual force
* Do all calculations within each particle

IDEAS:
2D!
Mass!
UI and starting position

*/
ArrayList<Particle> particles = new ArrayList<Particle>();
void setup(){
  size(1000, 800, P3D);
  background(30);
  particles.add(new Particle(width / 2 + 100, height / 2, 10, 0));
  particles.add(new Particle(width / 2 - 100, height / 2, -10, 0));
  for(int i = 0; i < particles.size(); i++){
    particles.get(i).setID(i);
  }
}
void draw(){
  background(30);
  for(Particle particle : particles){
    particle.drawParticle();
  }
  int xa = particles.get(0).x;
  int xb = particles.get(1).x;
  int distance = xa - xb;
  println(distance);
  float force;
  if(distance != 0){
    force = width / distance;
    println(force);
    println();
    particles.get(0).changeX(int((0 - force) / 1));
    particles.get(1).changeX(int(force / 1));
  } else {
    force = 0;
    println(force);
    println();
  }
}
