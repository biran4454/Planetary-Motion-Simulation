public class Particle{ //<>//
  Particle(int x, int y, float vx, float vy, float mass, float radius){
    p = new PVector(x, y);
    pubP = p;
    v = new PVector(vx, vy);
    pubV = v;
    acc = new PVector(0, 0);
    pubAcc = acc;
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
    mass = 100;
    radius = 10;
    gAcc = ((6.6726e-11) * mass) / (radius * radius);
  }*/
  public int ID;
  private PVector p, v, acc;
  public float mass, radius;
  private float gAcc;
  
  public PVector pubP, pubV, pubAcc;
  void drawParticle(){
    if(ID == 0){
      stroke(255, 0, 0);
      strokeWeight(10);
    } else {
      stroke(0, 255, 0);
      strokeWeight(13);
    }
    //strokeWeight(radius * 2);
    point(stp(p.x), p.y); // IMPORTANT: x values are with centre 0. stp() converts back to Processing format (left side of screen 0)
    
    float distance, otherMass, otherX;
    int direction; // If positive, pulls to the right, if negative, pulls to the left
    
    if(ID == 0){
      otherMass = particles.get(1).mass;
      otherX = particles.get(1).pubP.x;
      distance = abs(p.x - otherX);
      if(p.x > otherX){
        direction = -1;
      } else if(p.x < otherX){
        direction = 1;
      } else {
        direction = 0;
      }
      
    } else {
      otherMass = particles.get(0).mass;
      otherX = particles.get(0).pubP.x;
      distance = abs(p.x - otherX);
      if(p.x > otherX){
        direction = -1;
      } else if(p.x < otherX){
        direction = 1;
      } else {
        direction = 0;
      }
      
    }
    
    gAcc = (6.6726e-11 * mass * otherMass) / (distance * distance);
    if(direction != 0){
      acc.set((gAcc / mass) * direction, 0);
      v.add(acc.div(60)); 
    }
    p.add(v);    
  }
  void publishVariables(){
    pubP = p;
    pubV = v;
    pubAcc = acc;
  }
  void setID(int id){
    ID = id;
  }
  float stp(float x){
    return(x + width / 2);
  }
}
