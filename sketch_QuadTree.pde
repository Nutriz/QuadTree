QuadTree qtree;

PImage img;

public static boolean drawBorder = false;
public static boolean drawFill = true;
public static float maxDispertion = 20;
public static int drawCount;


void setup() {
  background(0);
  size(600, 600);
  frameRate(5);

  // 1sub.png, 2sub.png rand_sub.png or nut.png
  img = loadImage("lena.png");
}

void draw() {
  
  maxDispertion = map(mouseX, 0.0f, float(width), 0.0f, 255.0f);
  println("max dispertion " + maxDispertion);
  qtree = new QuadTree(0, 0, img.width, img.height, img);
  
  image(img, 0, 0);
  drawCount = 0;
  qtree.show();
  println("Draw count: " + drawCount);
}
