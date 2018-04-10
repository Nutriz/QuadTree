QuadTree qtree; 

PImage img; 

static boolean drawBorder = true; 
static boolean drawFill = false; 
static float maxDispersion; 

void setup() { 
  background(0); 
  size(600, 600); 
  frameRate(20); 

  // 1sub.png, 2sub.png, rand_sub.png, nut.png or lena.png 
  img = loadImage("img/lena.png");
} 

void draw() { 

  // Clear screen 
  background(0); 

  // draw image source 
  image(img, 0, 0); 

  // Level of detail with  
  maxDispersion = map(mouseX, 0, float(width), 0, 255);
  boolean drawMode = map(mouseY, 0, float(height), 0, 1) > 0.5;
  drawBorder = drawMode; 
  drawFill = !drawMode; 

  qtree = new QuadTree(0, 0, img.width, img.height, img); 

  // Draw QuadTree recursively 
  qtree.show();
} 
