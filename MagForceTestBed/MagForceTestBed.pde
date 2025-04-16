//Magnetic force test bed

/* ===================================
 Keyboard commands:
 =: add a new node to the front of the list
 -: remove the node at the front
 SPACE: Toggle moving on/off
 g: Toggle earth gravity on/off
 
 Mouse Commands:
 =================================== */

int NUM_ORBS = 2;
int MIN_SIZE = 10;
int MAX_SIZE = 60;
float MIN_MASS = 10;
float MAX_MASS = 100;
float G_CONSTANT = 0.1;
float K_CONSTANT = 1;
float D_COEF = 0.1;
float P_CONSTANT = 10;
//float B_FIELD = 5;

int MOVING = 0;
int BOUNCE = 1;
int GRAVITY = 2;
int DRAGF = 3;
int ELECTRO = 4;
int MAGNET = 5;
int LORENTZ = 6;
int DEMO = 7;
boolean[] toggles = new boolean[8];
String[] modes = {"Moving", "Bounce", "Gravity", "Drag", "Electric", "Magnetic", "Lorentz", "Demo"};
Orb[] Orbs = new Orb[NUM_ORBS];

FixedOrb earth;

void setup() {
  size(600, 600);

  earth = new FixedOrb(width/2, height * 200, 1, 20000);
  for (int i = 0; i < Orbs.length; i++) {
    int random = int(random(5, 30));
    Orbs[i] = new Orb(random(width), random(height), random, random);
    //Orbs[i].velocity = new PVector(random(2),random(2));
  }
}//setup

void draw() {
  background(255);
  displayMode();

  if (Orbs != null) {
    for (int i = 0; i < Orbs.length; i++) {
      if (Orbs[i] != null) {
        Orbs[i].display();
      }
    }
  }

  if (toggles[MOVING]) {
    if (Orbs != null) {
      for (int i = 0; i < Orbs.length; i++) {
        if (toggles[GRAVITY]) {
          PVector sumGravForce = new PVector();
          for (int j = 0; j < Orbs.length; j++) {
            if (i != j) {
              sumGravForce.add(Orbs[i].getGravity(Orbs[j], G_CONSTANT));
            }
          }
          Orbs[i].applyForce(sumGravForce);
        }
        //if (toggles[ELECTRO]){
        //  PVector sumEleForce = new PVector();
        //  for (int j = 0; j < Orbs.length; j++) {
        //    if (i != j) {
        //      sumEleForce.add(Orbs[i].getElectric(Orbs[j], K_CONSTANT));
        //    }
        //    Orbs[i].applyForce(sumEleForce);
        //    stroke(#000000);
        //    text(Orbs[i].charge,Orbs[i].center.x,Orbs[i].center.y);
        //  }
        //}//electrostatic force
        //if (toggles[MAGNET]) {
        //  if (Orbs[i].isField(Orbs[i].velocity)) {
        //    Orbs[i].applyForce(Orbs[i].getMagnetic(B_FIELD));
        //  }
        //}//magnetic force
        if (toggles[LORENTZ]) {
          PVector sumLoreForce = new PVector();
          for (int j = 0; j < Orbs.length; j++) {
            if (i != j) {
              sumLoreForce.add(Orbs[i].getElectric(Orbs[j], K_CONSTANT));
              if (Orbs[i].isField(Orbs[j].velocity)) {
                sumLoreForce.add(Orbs[i].getMagnetic(Orbs[i].getField(Orbs[j], P_CONSTANT)));
              }
            }
            Orbs[i].applyForce(sumLoreForce);
            stroke(#000000);
            text(Orbs[i].charge, Orbs[i].center.x, Orbs[i].center.y);
          }
        }//Lorentz force
        Orbs[i].move(toggles[BOUNCE]);
      }
    }
  }//moving
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
  if (key == 'e') {
    toggles[ELECTRO] = !toggles[ELECTRO];
  }
  if (key == 'l') {
    toggles[LORENTZ] = !toggles[LORENTZ];
  }
  if (key == '1') {
    toggles[DEMO] = !toggles[DEMO];
  }
  //if (key == '=' || key =='+') {
  //}
  //if (key == '-') {
  //}
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
    } 
    else {
      fill(255, 0, 0);
    }

    float w = textWidth(modes[m]);
    rect(x, 0, w+5, 20);
    fill(0);
    text(modes[m], x+2, 2);
    x+= w+5;
  }
}//display
