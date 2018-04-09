class QuadTree { //<>//

  int x;
  int y;
  int w;
  int h;
  color col;
  int minCol = 256;
  int maxCol = -1;
  PImage img;

  QuadTree topLeft;
  QuadTree topRight;
  QuadTree bottomRight;
  QuadTree bottomLeft;

  public QuadTree(int x, int y, int w, int h, PImage img) {
    // println(" # New quadtree: " + x + " " + y + " " + w + " " + h);
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.img = img;
    col = img.get(x, y);

    if (mustSubdivise()) {
      subdivise();
    }
  }

  public boolean mustSubdivise() {
    for (int i=y; i < (y+h); i++) {
      for (int j=x; j < (x+w); j++) {

        color currCol = img.get(j, i);
        minCol = min(minCol, int(brightness(currCol)));
        maxCol = max(maxCol, int(brightness(currCol)));

        //else {
        //  println("diff " + String.valueOf(maxCol-minCol));
        //}
      }
    }

    if ((maxCol-minCol) > sketch_QuadTree.maxDispertion) {
      col = minCol + (maxCol-minCol)/2;
      return true;
    }
    
    return false;
  }

  void subdivise() {
    topLeft = new QuadTree(x, y, w/2, h/2, img);
    topRight = new QuadTree(x+w/2, y, w/2, h/2, img);
    bottomRight = new QuadTree(x+w/2, y+h/2, w/2, h/2, img);
    bottomLeft = new QuadTree(x, y+h/2, w/2, h/2, img);
  }

  void show() {
    
    sketch_QuadTree.drawCount += 1;

    // draw average color
    if (sketch_QuadTree.drawFill) {
      fill(col);
      noStroke();
      rect(x, y, w, h);
    }


    if (topLeft != null) {
      topLeft.show();
      topRight.show();
      bottomRight.show();
      bottomLeft.show();
    }

    // draw borders
    if (sketch_QuadTree.drawBorder) {
      noFill();
      stroke(0, 255, 0, 40);
      rect(x, y, w, h);
    }
  }
}
