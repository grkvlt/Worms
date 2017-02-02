int DENSITY = 2;
int n = (int) Math.pow(DENSITY, 0.33);
int m = n;
int i = 0;
int s = 300 / (DENSITY * DENSITY);
int w = 600;
float r, g, b;

void setup() {
  fullScreen();
  //size(1600, 1000);
  //smooth();
  //pixelDensity(displayDensity());
  noCursor();
  // s *= (1.25 - random(.5));
  background(255-random(32), 255-random(32), 255-random(32));
  frameRate(24);
  r = random(1);
  g = random(1);
  b = random(1);
  curveTightness(random(10) - 5);
}

void draw() {
  //filter(BLUR, 1);
  if (n > 0) {
    stroke(r * random(255), g * random(255), b * random(255), 32+random(32));
  strokeWeight(random(s));
     fill(255, 0);
     curve(
         i, 0,
         i + (random(0, width) - (width / 2)), random(0, height),
         i + (random(0, width) - (width / 2)), random(0, height),
         i, height);
     if (i < width) {
       i += s/3; 
     } else {
       i = 0;
       n--;
     }
  } else {
    n = m;
    setup();
  }
}