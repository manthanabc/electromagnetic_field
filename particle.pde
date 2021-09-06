class particle {  
  public float x =0;
  public float y =0;
  public float chargee = 0;
  public float time_scale = 0.5;
  public particle(float x, float y) {
    this.x = x;
    this.y = y;
  }

public void update(charge[] charges) {
  PVector field = new PVector(0 ,0, 0);
  //print(field);
  float e = 8.854e-12;
  for(charge c :charges) {
     float rt = dist(this.x, this.y, c.x, c.y);
     //print(rt);
     PVector r_vc = new PVector(this.x-c.x, this.y-c.y);
     r_vc = r_vc.normalize();
     //electric_field.div(100000);
     //print(field);
     field.add((r_vc.mult(((1/(4*PI*e*rt*rt + 0.00001)) * c.charge)/(8000))));
  }
   field.limit(4);
   //print(field);
   this.x += this.time_scale * field.x;
   this.y += this.time_scale * field.y;
}

public void show() {
    strokeWeight(5);
    stroke(0, 255, 0);
    point(this.x, this.y);
  }
}
