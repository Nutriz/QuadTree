class QuadTree { //<>//

  int x, y, w, h; 
  color col; 
  PImage img; 

  // Yeah, it's a bit overkill :D 
  // if you don't understand, check mustSubdivise() code 
  int minCol = Integer.MAX_VALUE;  
  int maxCol = Integer.MIN_VALUE;  

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

    if (mustSubdivise()) { 
      subdivise();
    }
  } 

  public boolean mustSubdivise() { 
    for (int j=y; j < (y+h); j++) { 
      for (int i=x; i < (x+w); i++) { 
        color pixelColor = img.get(i, j); 
        minCol = min(minCol, int(brightness(pixelColor))); 
        maxCol = max(maxCol, int(brightness(pixelColor)));
      }
    } 

    // If too much color dispersion, subdivise
    if ((maxCol-minCol) > sketch_QuadTree.maxDispersion) { 
      return true;
    } else { 
      col = minCol + (maxCol-minCol)/2; 
      return false;
    }
  } 

  // Subdivision in 4 sub-areas, it's where the recursive magic happen 
  void subdivise() { 
    topLeft = new QuadTree(x, y, w/2, h/2, img); 
    topRight = new QuadTree(x+w/2, y, w/2, h/2, img); 
    bottomRight = new QuadTree(x+w/2, y+h/2, w/2, h/2, img); 
    bottomLeft = new QuadTree(x, y+h/2, w/2, h/2, img);
  } 

  void show() { 
    // draw average color 
    if (sketch_QuadTree.drawFill) { 
      fillColor();
    } 

    if (hasChilds()) { 
      drawSubAreas();
    } 

    // draw borders 
    if (sketch_QuadTree.drawBorder) { 
      drawBorders();
    }
  } 

  void fillColor() { 
    fill(col); 
    noStroke(); 
    rect(x, y, w, h);
  } 

  void drawSubAreas() { 
    topLeft.show(); 
    topRight.show(); 
    bottomRight.show(); 
    bottomLeft.show();
  } 

  void drawBorders() { 
    noFill(); 
    stroke(0, 255, 0, 40); 
    rect(x, y, w, h);
  } 

  boolean hasChilds() { 
    return topLeft != null;
  }
} 
