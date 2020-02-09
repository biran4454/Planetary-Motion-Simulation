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
    point(p.x, p.y);
    if(ID == 0){
      float otherX = particles.get(1).p.x; // If p.x =  1 then f.x =  0.5 then v.x =  1.5 then p.x =  2.5
      force = 1 / (p.x - otherX); //     else If p.x = -1 then f.x = -0.5 then v.x = -1.5 then p.x = -1.5  Oh the wonders of fixed-width fonts!
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
}
