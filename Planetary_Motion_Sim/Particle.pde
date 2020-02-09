public class Particle{
  Particle(int x, int y, float vx, float vy, float mass, float radius){
    p = new PVector(x, y);
    v = new PVector(vx, vy);
    acc = new PVector(0, 0);
    this.mass = mass;
    this.radius = radius;
  }/*
  Particle(int x, int y, float mass, float radius){
    p = new PVector(x, y);
    v = new PVector(0, 0);
    a = new PVector(0, 0);
    this.mass = mass;
    this.radius = radius;
    gAcc = ((6.6726e-11) * mass) / (radius * radius);
  }
  Particle(int x, int y){
    p = new PVector(x, y);
    v = new PVector(0, 0);
    a = new PVector(0, 0);
    mass = 100; //<>//
    radius = 10;
    gAcc = ((6.6726e-11) * mass) / (radius * radius);
  }*/
  public int ID;
  private PVector p, v, acc;
  public float mass, radius;
  public float gAcc;
  void drawParticle(){
    stroke(255);
    strokeWeight(radius * 2);
    point(stp(p.x), p.y); // IMPORTANT: x values are with centre 0. stp() converts back to Processing format (left side of screen 0)
    
    float distance, otherMass;
    
    if(ID == 0){
      otherMass = particles.get(1).mass;
      distance = p.x - particles.get(1).p.x;
    } else if(ID == 1){
      otherMass = particles.get(0).mass;
      distance = p.x - particles.get(0).p.x;
    } else {otherMass = 0; distance = 0;}
    
    gAcc = (6.6726e-11 * mass * otherMass) / (distance * distance);
    
    
    /*if(ID == 0){
      otherGAcc = particles.get(1).gAcc;
    } else if(ID == 1){
      otherGAcc = particles.get(0).gAcc;
    } else {otherGAcc = 0;}
    acc = otherGAcc + gAcc;*/
    
    acc.set(gAcc / mass, 0);
    
    /*
    if(ID == 0){
      otherX = particles.get(1).p.x; 
      force = 1 / (p.x - otherX);
    } else if(ID == 1){
      otherX = particles.get(0).p.x;
      force = 1 / (p.x - otherX);
    } else {force = 0;}
    */
    
    v.add(acc.div(60)); 
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
  float getGAcc(float dist){
    float otherMass;
    if(ID == 0){
      otherMass = particles.get(1).mass;
    } else if(ID == 1){
      otherMass = particles.get(0).mass;
    } else {otherMass = 0;}
    
    return((6.6726e-11 * mass* otherMass) / (dist * dist));
  }
}
