public class Particle{
  Particle(int x, int y, float vx, float vy){
    this.vx = vx;
    this.vy = vy;
    
    this.x = x;
    this.y = y;
    
    this.fx = 0;
    this.fy = 0;
    
    this.vz = 0;
    this.z = 0;
    this.fz = 0;
  }
  private int x, y, z;
  private float vx, vy, vz;
  private float fx, fy, fz;
  public int ID;
  void drawParticle(){
    stroke(255);
    strokeWeight(10);
    point(x, y);
    //x += int(vx);
    //y += int(vy);
    Particle particle;
    if(ID == 0){ // fix this for more than 1 particle
      particle = particles.get(1);
    } else { // fix this for more than 1 particle
      particle = particles.get(0);
    }
    int xDiff = x - particle.x; //READ THROUGH ALL OF THIS AND CHECK!!
    if(xDiff != 0){
      int fx = width / xDiff;
      x += fx;
    }
    else {
      
    }
    
  }
  void setID(int id){
    ID = id;
  }
  void changeVelocity(float xDiff){
    vx += xDiff;
  }
  void changeVelocity(float xDiff, float yDiff){
    vx += xDiff;
    vy += yDiff;
  }
  void changeVelocity(float xDiff, float yDiff, float zDiff){
    vx += xDiff;
    vy += yDiff;
    vz += zDiff;
  }
  void changeX(int change){
    x += change; 
  }
}
