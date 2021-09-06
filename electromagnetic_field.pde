/**
use your mouse to move around a positive unit charge use (t) to toggle the unite charge to 1 -1 0
presse p at any point to add a unit positive charge
press n at nay point to add a unit negative charge

press the s to add a non static charge which can move (unit positive)
press the S to add a non static charge which can move (unit negative)

press c to clear the screen

the color for any given point represents the magnitude of the vector which is scaled logarithmaticly as scaling the vecotr propostional to feild 
looks really bad so the color represents the magnitude which is logarigthmically goes from 0 - 255 i.e from blue to red



created by manthan m patil (3/7/2021) 
this code is under open source (MIT licsence) writen in processing 4 (beta)
*/



float scale = 20;
float e = 8.854e-12;
int a = 1;
int max_charges = 100;
int mouseCharge = 1;

particle[] p = new particle[1];

charge c = new charge(300, 300, -1);
charge [] charges =new charge[max_charges];

void setup() {
  size(600, 600);
  for(int i=0; i< max_charges; i++) {
    charges[i] = new charge(10000, 10000, 0);
  }
  for(int i= 0; i< 1; i++) {
    p[i] = new particle(0,0);
    p[i].chargee = 0;
  }
  colorMode(HSB, 400);
}

void draw() {
  background(130);
  for(int x=0; x<width;x+= scale) {
    for(int y=0; y< height; y+= scale) {
      strokeWeight(1);
      
      PVector electric_field = new PVector(0 ,0);
      charges[0].x = mouseX;
      charges[0].y = mouseY;
      charges[0].charge = mouseCharge;
      for(charge c :charges) {
         float rt = dist(x, y, c.x, c.y);
         PVector r_vc = new PVector(x-c.x, y-c.y);
         r_vc = r_vc.normalize();
         //electric_field.div(100000);
         electric_field.add((r_vc.copy().mult((1/(4*PI*e*rt*rt) * c.charge)/(80000* pow(20/scale, 1/2)))));
      }
      //int p = (int)map(electric_field.mag(), 0., 10., 0., 750.);
      //if(p < 255) {
      //  color(p, 0, 0)
      //}
      stroke(log10(electric_field.mag())*100, 250, 400);
      electric_field.limit(10 * pow(scale/20, 1));
      strokeWeight(electric_field.mag()/5);
      arrow(x, y, x+electric_field.x, y+electric_field.y);
      
    }
  }
  
  for(particle ps: p) {
    
    ps.update(charges);
    ps.show();
  }
}

void keyPressed() {
  if(key == 'n') {
   charges[a+1] =  new charge(mouseX, mouseY, -1);
   a+= 1;
  }
  if(key == 'p') {
   charges[a+1] =  new charge(mouseX, mouseY, 1);
   a+= 1;
  }
  if(key == 't') {
   if(mouseCharge == 1) {
    mouseCharge = 0; 
   } else if(mouseCharge == 0) {
    mouseCharge = -1 ;
   } else if(mouseCharge == -1) {
    mouseCharge = 1; 
   }
  }
  if(key == 'c') {
   a = 1;
   for(charge c: charges) {
    c.charge = 0; 
   }
  }
  if(key == 's' ) {
     p[0].x = mouseX;
     p[0].y = mouseY;
     p[0].chargee = 1;
  }
}

void arrow(float x1, float y1, float x2, float y2) {
  line(x1, y1, x2, y2);
  push();
  translate(x2, y2);
  rotate(radians(30));
  line(0,0,x1 * 0.2 -  x2 * 0.2 ,  y1 * 0.2 -  y2 * 0.2);
  pop();
  push();
  translate(x2, y2);
  rotate(radians(-30));
  line(0,0,x1 * 0.2 -  x2 * 0.2 ,  y1 * 0.2 -  y2 * 0.2);
  pop();
}
// Calculates the base-10 logarithm of a number
float log10 (float x) {
  return (log(x) / log(10));
}
