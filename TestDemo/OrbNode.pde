class OrbNode extends Orb {
  //attributes aka instance variables
  OrbNode next;
  OrbNode previous;
  
  void display(int springLength) {
    if(next != null) {
      if (springLength < dist(center.x, center.y, next.center.x, next.center.y)){
        stroke(255,0,0);
      } else {
        stroke(0,255,0);
    }
      line(center.x, center.y, next.center.x, next.center.y);
    }
    if(previous != null) {
      if (springLength < dist(center.x, center.y, previous.center.x, previous.center.y)){
        stroke(255,0,0);
      } else {
        stroke(0,255,0);
      }
      line(center.x + 2, center.y + 2, previous.center.x + 2, previous.center.y + 2);
    }
  }
  
}//OrbNode
