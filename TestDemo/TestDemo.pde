//TestDemo

/* ===================================
 Keyboard commands:
 SPACE: Toggle moving on/off
 1: Toggle Gravity demo
 2: Toggle Drag demo
 3: Toggle Mag demo
 
 Mouse Commands:
 =================================== */

int NUM_ORBS = 4;
int MIN_SIZE = 10;
int MAX_SIZE = 60;
float MIN_MASS = 10;
float MAX_MASS = 100;
float G_CONSTANT = 1;
float D_COEF = 0.1;
float B_FIELD = 1;
PVector UGRAVITY = new PVector(0, 0.5);
//double MU0 = 4*Math.PI*0.0000001;
float MU0_DIV_4PI = 0.01;

int SPRING_LENGTH = 50;
float SPRING_K = 0.005;

int MOVING = 0;
int BOUNCE = 1;
int GRAVITY = 2;
int DRAGF = 3;
int MAGNET = 4;
int UGRAV = 5;
int SPRING = 6;
int DRAGREG = 7;
int DEMO1 = 8;
int DEMO2 = 9;
int DEMO3 = 10;
boolean[] toggles = new boolean[11];
String[] modes = {"Moving", "Bounce", "Gravity", "Drag", "Magnetic", "Ugravity", "Spring"};
String[] demos = {"Gravity", "Drag", "Spring"};
Orb[] Orbs = new Orb[NUM_ORBS];
OrbNode[] OrbNodes = new OrbNode[NUM_ORBS];
Orb particle;

FixedOrb earth;

void setup() {
  size(600, 600);
  earth = new FixedOrb(width/2, height/2, 100, 100);
}//setup

void draw() {
  background(255);
  displayMode();
  if (toggles[DRAGREG]) {
    fill(200, 200, 255);
    rect(0, height/2, width, height/4);
  }
  if (toggles[MOVING]) {
    if (Orbs != null) {
      for (int i = 0; i < Orbs.length; i++) {
        if (toggles[UGRAV]) {
          Orbs[i].applyForce(UGRAVITY);
        }
        if (toggles[DRAGF]) {
          if (Orbs[i].center.y > height/2 && Orbs[i].center.y < height*3/4) {
            Orbs[i].applyForce(Orbs[i].getDragForce(D_COEF));
          }
        }
        if (toggles[GRAVITY]) {
          PVector sumGravForce = new PVector(0, 0);
          for (int j = 0; j < Orbs.length; j++) {
            if (i != j) {
              sumGravForce.x += Orbs[i].getGravity(Orbs[j], G_CONSTANT).x;
              sumGravForce.y += Orbs[i].getGravity(Orbs[j], G_CONSTANT).y;
            }
          }
          Orbs[i].applyForce(sumGravForce);
        }
        Orbs[i].move(toggles[BOUNCE]);
      }
    }
    if (OrbNodes != null) {
      for (int i = 0; i < OrbNodes.length; i++) {
        if (OrbNodes[i] != null) {
          if (toggles[UGRAV]) {
            OrbNodes[i].applyForce(UGRAVITY);
          }
          if (toggles[DRAGF]) {
            if (OrbNodes[i].center.y > height/2 && OrbNodes[i].center.y < height*3/4) {
              OrbNodes[i].applyForce(OrbNodes[i].getDragForce(D_COEF));
            }
          }
          if (toggles[GRAVITY]) {
            PVector sumGravForce = new PVector(0, 0);
            for (int j = 0; j < OrbNodes.length; j++) {
              if (i != j) {
                sumGravForce.x += OrbNodes[i].getGravity(OrbNodes[j], G_CONSTANT).x;
                sumGravForce.y += OrbNodes[i].getGravity(OrbNodes[j], G_CONSTANT).y;
              }
            }
            OrbNodes[i].applyForce(sumGravForce);
          }
          if (toggles[SPRING]) {
            PVector sf;
            sf = OrbNodes[i].getSpring(OrbNodes[i].next, SPRING_LENGTH, SPRING_K);
            OrbNodes[i].applyForce(sf);
            sf = OrbNodes[i].getSpring(OrbNodes[i].previous, SPRING_LENGTH, SPRING_K);
            OrbNodes[i].applyForce(sf);
          }
          OrbNodes[i].move(toggles[BOUNCE]);
        }
      }
    }
    //if (toggles[DEMO3] && particle != null){
    //  particle.display();
    //  particle.applyForce(getMagnetic(B_FIELD));
    //}//if magdemo
  }//moving
  if (Orbs != null) {
    for (int i = 0; i < Orbs.length; i++) {
      if (Orbs[i] != null) {
        Orbs[i].display();
      }
    }
  }
  if (OrbNodes != null) {
    for (int i = 0; i < OrbNodes.length; i++) {
      if (OrbNodes[i] != null) {
        OrbNodes[i].display();
        OrbNodes[i].display(SPRING_LENGTH);
      }
    }
  }
}//draw

void mousePressed() {
}//mousePressed

void keyPressed() {
  if (key == ' ') {
    toggles[MOVING] = !toggles[MOVING];
  }
  if (key == 'g') {
    toggles[GRAVITY] = !toggles[GRAVITY];
  }
  if (key == 'b') {
    toggles[BOUNCE] = !toggles[BOUNCE];
  }
  if (key == 'd') {
    toggles[DRAGF] = !toggles[DRAGF];
  }
  if (key == 'm') {
    toggles[MAGNET] = !toggles[MAGNET];
  }
  //if (key == '=' || key =='+') {

  //}
  //if (key == '-') {

  //}
  if (key == '1') {
    toggles[DEMO1] = true;
    toggles[DEMO2] = false;
    toggles[DEMO3] = false;
    Orbs = new Orb[NUM_ORBS+1];
    OrbNodes = null;
    for (int i = 0; i < Orbs.length - 1; i++) {
      int random = int(random(5, 30));
      Orbs[i+1] = new Orb(100+(width-200)*i/(NUM_ORBS), 50, random, random);
    }
    Orbs[0] = earth;
    toggles[MOVING] = false;
    toggles[GRAVITY] = true;
    toggles[DRAGF] = false;
    toggles[BOUNCE] = true;
    toggles[MAGNET] = false;
    toggles[UGRAV] = false;
    toggles[SPRING] = false;
    toggles[DRAGREG] = false;
  }
  if (key == '2') {
    toggles[DEMO2] = true;
    toggles[DEMO1] = false;
    toggles[DEMO3] = false;
    Orbs = new Orb[NUM_ORBS];
    OrbNodes = null;
    for (int i = 0; i < Orbs.length; i++) {
      int random = int(random(5, 30));
      Orbs[i] = new Orb(100+(width-200)*i/(NUM_ORBS), 50, random, random);
    }
    toggles[MOVING] = false;
    toggles[GRAVITY] = false;
    toggles[DRAGF] = true;
    toggles[BOUNCE] = true;
    toggles[MAGNET] = false;
    toggles[UGRAV] = true;
    toggles[SPRING] = true;
    toggles[DRAGREG] = true;
  }
  if (key == '3') {
    toggles[DEMO3] = true;
    toggles[DEMO1] = false;
    toggles[DEMO2] = false;
    //Orbs = null;
    //OrbNodes = null;
    
    //particle = new Orb();
    
     Orbs = null;
    OrbNodes = new OrbNode[NUM_ORBS+1];
    for (int i = 0; i < OrbNodes.length - 1; i++) {
      OrbNodes[i] = new OrbNode();
    }
    for (int i = 1; i < OrbNodes.length - 2; i++) {
      OrbNodes[i].next = OrbNodes[i+1];
      OrbNodes[i].previous = OrbNodes[i-1];
    }
    OrbNodes[0].next = OrbNodes[1];
    toggles[MOVING] = false;
    toggles[GRAVITY] = false;
    toggles[DRAGF] = true;
    toggles[BOUNCE] = true;
    toggles[MAGNET] = false;
    toggles[UGRAV] = false;
    toggles[SPRING] = true;
    toggles[DRAGREG] = false;
  }
}//keyPressed


void displayMode() {
  textAlign(LEFT, TOP);
  textSize(20);
  noStroke();
  int x = 0;

  for (int m=0; m<modes.length; m++) {
    //set box color
    if (toggles[m]) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }

    float w = textWidth(modes[m]);
    rect(x, 0, w+5, 20);
    fill(0);
    text(modes[m], x+2, 2);
    x += w+5;
  }
  
  int d = 0;
  for (int m=0; m<demos.length; m++) {
    //set box color
    if (toggles[m+8]) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }

    float w = textWidth(demos[m]);
    rect(d, 20, w+5, 40);
    fill(0);
    text(demos[m], d+2, 22);
    d += w+5;
  }
}//display
