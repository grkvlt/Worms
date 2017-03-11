/**
 * Worms 0.2.1-SNAPSHOT
 *
 * Random object display, weighted by DENSITY variable.
 *
 * Runs in full-screen mode. Fill colours, transparency, stroke width and colour and object
 * type are all randomized, referenced to the weighting variables to try and achieve a uniform look.
 *
 * TODO
 * - Try using logarithmic adjustment?
 *
 * Last modified: 2017-03-11
 * Author: mailto:adk@abstractvisitorpattern.co.uk
 *
 * Copyright 2017 by Andrew Kennedy
 */

// Configuration
static final int DENSITY = 4;
static final boolean FIXED = true;
static final int SHAPE = 3; // 0 = ellipse; 1 = rectangle; 2 = triangle; 3 = curve
static final boolean RANDOM = true;
static final int SEED = 571;

// Globals
int n = 25 * (int) Math.pow(DENSITY, 1.25f);
int m = n;
float r, g, b;

// Screen setup
void setup() {
  fullScreen();
  //size(1600, 1000);
  //smooth();
  //pixelDensity(displayDensity());
  noCursor();

  if (!RANDOM) randomSeed(SEED);
  r = random(1);
  g = random(1);
  b = random(1);
  curveTightness(random(10) - 5);
  background(128 + (r * random(128)), 128 + (g * random(128)), 128 + (b * random(128)));
  frameRate(24);
}

// Frame rendering
void draw() {
  println(n);
  if (n > 0) {
    // Set colour and transparency
    float rr = r * random(255);
    float gg = g * random(255);
    float bb = b * random(255);
    float aa = (random(64 / DENSITY) * DENSITY);
    stroke(rr, gg, bb, aa);
    strokeWeight(DENSITY * random(10));
    fill(rr, gg, bb, aa);

    // Draw object
    switch (FIXED ? SHAPE : int(random(4))) {
      case 0:
        ellipse(
          random(width), random(height),
          random(width / 2), random(height / 2));
        break;
      case 1:
        rect(
          random(width), random(height),
          random(width / 2), random(height / 2),
          random(32));
        break;
      case 2:
        triangle(
          random(width), random(height),
          random(width), random(height),
          random(width), random(height));
        break;
      case 3:
        fill(255, 0); // Just draw the curve
        curve(
           0, 0,
           random(width), random(height),
           random(width), random(height),
           width, height);
        break;
    }
    
    n--; // Iterate
  } else {
    n = m; // Reset
    setup();
  }
}