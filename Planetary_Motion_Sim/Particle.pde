public class Particle{
  Particle(int x, int y, float vx, float vy){
    p = new PVector(x, y);
    v = new PVector(vx, vy);
    f = new PVector(0, 0);
  }
  public int ID;
  private float force;
  private PVector p, v, f;
  void drawParticle(){
    stroke(255);
    strokeWeight(10);
    point(stp(p.x), p.y);
    if(ID == 0){
      float otherX = particles.get(1).p.x; // IMPORTANT: x values are with centre 0. stp() converts back to Processing format (left side of screen 0)
      force = 1 / (p.x - otherX);
    } else if(ID == 1){
      float otherX = particles.get(0).p.x;
      force = 1 / (p.x - otherX);
    }
    f.set(force, 0);
    v.add(f); //<>//
    /*
    for(int i = 0; i < particles.size(); i++){
      if(i != ID){
        particle = particles.get(i);
        particle.
      }
    }
    */
    
    p.add(v);
  }
  void setID(int id){
    ID = id;
  }
  float stp(float x){
    return(x + width / 2);
  }
}
