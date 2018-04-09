QuadTree qtree; 

PImage img; 

static boolean drawBorder = true; 
static boolean drawFill = true; 
static float maxDispersion; 

void setup() { 
  background(0); 
  size(600, 600); 
  frameRate(30); 

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
  qtree = new QuadTree(0, 0, img.width, img.height, img); 

  // Draw QuadTree recursively 
  qtree.show();
} 
