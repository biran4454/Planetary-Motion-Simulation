public class Particle{
  Particle(int x, int y, float vx, float vy){
    this.vx = vx;
    this.vy = vy;
    this.x = x;
    this.y = y;
    this.vz = 0;
    this.z = 0;
  }
  private int x, y, z;
  private float vx, vy, vz;
  public int ID;
  void drawParticle(){
    stroke(255);
    strokeWeight(10);
    point(x, y);
    x += int(vx);
    y += int(vy);
  }
  void setID(int id){
    ID = id;
  }
}
