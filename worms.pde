/**
 * Worms 0.2.0-SNAPSHOT
 *
 * Random object display, weighted by DENSITY and FACTOR variables.
 *
 * Runs in full-screen mode. Fill colours, transparency, stroke width and colour and object
 * type are all randomized, referenced to the weighting variables to try and achieve a uniform look.
 *
 * TODO
 * - Try using logarithmic adjustment rather than fractional powers
 *
 * Last modified: 2017-02-01
 * Author: mailto:adk@abstractvisitorpattern.co.uk
 *
 * Copyright 2017 by Andrew Kennedy
 */

// Configuration
static final int DENSITY = 3;
static final float FACTOR = 0.67f;
static final boolean FIXED = false;
static final int SHAPE = 0; // 0 = ellipse; 1 = rectangle; 2 = triangle; 3 = curve
static final boolean RANDOM = true;
static final int SEED = 571;

// Globals
int n = (int) Math.pow(DENSITY, 1f - FACTOR);
int m = n;
int i = 0;
int s = 300 / (DENSITY * DENSITY);
int w = 600;
float r, g, b;

// Screen setup
void setup() {
  if (!RANDOM) randomSeed(SEED);
  fullScreen();
  //size(1600, 1000);
  //smooth();
  //pixelDensity(displayDensity());
  noCursor();
  s *= (1.25 - random(.5));
  background(255-random(32), 255-random(32), 255-random(32));
  frameRate(24);
  r = random(1);
  g = random(1);
  b = random(1);
  curveTightness(random(10) - 5);
}

// Frame rendering
void draw() {
  // Draw
  if (n > 0) {
    // Set colour and transparency
    float rr = r * random(255);
    float gg = g * random(255);
    float bb = b * random(255);
    float aa = (float) Math.pow(random(255), FACTOR) / DENSITY;
    stroke(rr, gg, bb, aa);
    strokeWeight(DENSITY * (float) Math.pow(random(s), FACTOR));
    fill(rr, gg, bb, aa);

    // Draw object
    switch (FIXED ? SHAPE : int(random(4))) {
      case 0:
        ellipse(
          i + (random(width) - (width / 2)), random(height),
          random(width / 2), random(height / 2));
        break;
      case 1:
        rect(
          i + (random(width) - (width / 2)), random(height),
          random(width / 2), random(height / 2),
          random(32));
        break;
      case 2:
        triangle(
          i + (random(width) - (width / 2)), random(height),
          i + (random(width) - (width / 2)), random(height),
          i + (random(width) - (width / 2)), random(height));
        break;
      case 3:
        fill(255, 0); // Just draw the curve
        curve(
           i, 0,
           i + (random(width) - (width / 2)), random(height),
           i + (random(width) - (width / 2)), random(height),
           i, height);
        break;
    }

    // Iterate
    if (i < width) {
      i += s/3;
    } else {
      i = 0;
      n--;
    }
  } else {
    // Reset
    n = m;
    setup();
  }
}