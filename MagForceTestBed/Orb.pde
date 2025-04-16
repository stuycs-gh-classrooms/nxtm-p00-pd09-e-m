class Orb {

  //instance variables
  PVector center;
  PVector velocity;
  PVector acceleration;
  float bsize;
  float mass;
  float charge;
  color c;


  Orb() {
    bsize = random(10, MAX_SIZE);
    float x = random(bsize/2, width-bsize/2);
    float y = random(bsize/2, height-bsize/2);
    center = new PVector(x, y);
    mass = random(10, 100);
    int q = int(random(2));
    if (q == 0) {
      charge = -0.1;
    } else {
      charge = 0.1;
    }
    velocity = new PVector();
    acceleration = new PVector();
    setColor();
  }

  Orb(float x, float y, float s, float m) {
    bsize = s;
    mass = m;
    //int q = int(random(2));
    //if (q == 0) {
      charge = -0.1;
    //} else {
    //  charge = 0.1;
    //}
    center = new PVector(x, y);
    velocity = new PVector();
    acceleration = new PVector();
    setColor();
  }

  //movement behavior
  void move(boolean bounce) {
    if (bounce) {
      xBounce();
      yBounce();
    }

    velocity.add(acceleration);
    center.add(velocity);
    acceleration.mult(0);
  }//move

  void applyForce(PVector force) {
    PVector scaleForce = force.copy();
    scaleForce.div(mass);
    acceleration.add(scaleForce);
  }

  PVector getDragForce(float cd) {
    float dragMag = velocity.mag();
    dragMag = -0.5 * dragMag * dragMag * cd;
    PVector dragForce = velocity.copy();
    dragForce.normalize();
    dragForce.mult(dragMag);
    return dragForce;
  }

  PVector getGravity(Orb other, float G) {
    float strength = G * mass*other.mass;
    //dont want to divide by 0!
    float r = max(center.dist(other.center), MIN_SIZE);
    strength = strength/ pow(r, 2);
    PVector force = other.center.copy();
    force.sub(center);
    force.mult(strength);
    return force;
  }

  //spring force between calling orb and other
  PVector getSpring(Orb other, int springLength, float springK) {
    PVector direction = PVector.sub(other.center, this.center);
    direction.normalize();

    float displacement = this.center.dist(other.center) - springLength;
    float mag = springK * displacement;
    direction.mult(mag);

    return direction;
  }//getSpring

  PVector getElectric(Orb other, float K) {
    float strength = K * charge*other.charge;
    //dont want to divide by 0!
    float r = max(center.dist(other.center), MIN_SIZE);
    strength = strength/ pow(r, 2);
    PVector force = center.copy().sub(other.center);
    force.mult(strength);
    return force;
  }

  PVector getMagnetic(float field) {
    PVector direction = new PVector();
    direction.x = -this.velocity.y;
    direction.y = this.velocity.x;
    direction = direction.normalize();
    //println(velocity.mag());
    float magnitude = charge*field*velocity.mag();
    //println(magnitude);
    direction.mult(magnitude);
    return direction;
  }//getMagnetic

  boolean isField(PVector otherv) {
    if (otherv.mag() > 0) {
      return true;
    }//if field exists
    else {
      return false;
    }//if no B field
  }//fieldType
  
  float getField(Orb other, float p){
    float slope = other.velocity.y/other.velocity.x;
    if (center.y == slope*(center.x-other.center.x)+other.center.y){
      return 0;
    }//if on same line
    float r = max(center.dist(other.center), MIN_SIZE);
    float mag = p*other.charge*other.velocity.mag()/pow(r,2);
    if (center.y < slope*(center.x-other.center.x)+other.center.y){
      return mag;
    }//if above line
    else {
      return -mag;
    }//if below line
  }//getField

  boolean yBounce() {
    if (center.y > height - bsize/2) {
      velocity.y *= -1;
      center.y = height - bsize/2;

      return true;
    }//bottom bounce
    else if (center.y < bsize/2) {
      velocity.y*= -1;
      center.y = bsize/2;
      return true;
    }
    return false;
  }//yBounce
  boolean xBounce() {
    if (center.x > width - bsize/2) {
      center.x = width - bsize/2;
      velocity.x *= -1;
      return true;
    } else if (center.x < bsize/2) {
      center.x = bsize/2;
      velocity.x *= -1;
      return true;
    }
    return false;
  }//xbounce

  boolean collisionCheck(Orb other) {
    return ( this.center.dist(other.center)
      <= (this.bsize/2 + other.bsize/2) );
  }//collisionCheck

  boolean isSelected(float x, float y) {
    float d = dist(x, y, center.x, center.y);
    return d < bsize/2;
  }//isSelected

  void setColor() {
    color c0 = color(0, 255, 255);
    color c1 = color(0);
    c = lerpColor(c0, c1, (mass-MIN_SIZE)/(MAX_MASS-MIN_SIZE));
  }//setColor

  //visual behavior
  void display() {
    noStroke();
    fill(c);
    circle(center.x, center.y, bsize);
    fill(0);
    //text(mass, center.x, center.y);
  }//display
}//Orb
