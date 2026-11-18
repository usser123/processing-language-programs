
/*
  WHISPERS OF MAUVE
  Generative botanical abstract painting
  Processing 4 - Java Mode

  Click       : Generate a new painting
  Press S     : Save artwork
*/

int seed = 42;

color pink       = #D0A0C0;
color rose       = #C090B0;
color mauve      = #A080A0;
color deepMauve  = #806080;
color plum       = #604860;
color teal       = #708080;
color blueGrey   = #A0A0A8;
color ivory      = #E8DCE4;
color palePink   = #E0B8D0;

void setup() {
  size(900, 1100);
  smooth(8);
  generatePainting();
}

void generatePainting() {
  randomSeed(seed);
  noiseSeed(seed);

  background(rose);

  drawBackground();
  drawFlowingForms();
  drawBotanicalStems();
  drawFlowerClusters();
  drawFineDetails();
  drawTexture();

  noLoop();
}

// ----------------------------------
// BACKGROUND
// ----------------------------------

void drawBackground() {

  for (int y = 0; y < height; y++) {
    float t = map(y, 0, height, 0, 1);

    color c = lerpColor(
      palePink,
      mauve,
      t
    );

    stroke(c);
    line(0, y, width, y);
  }

  noStroke();

  // Soft atmospheric colour fields
  for (int i = 0; i < 35; i++) {

    float x = random(width);
    float y = random(height);
    float r = random(80, 280);

    fill(
      random(100, 190),
      random(110, 160),
      random(140, 195),
      13
    );

    ellipse(x, y, r, r);
  }
}

// ----------------------------------
// FLOWING ORGANIC FORMS
// ----------------------------------

void drawFlowingForms() {

  noFill();

  for (int i = 0; i < 18; i++) {

    float offset = i * 15;

    stroke(
      random(170, 220),
      random(130, 170),
      random(170, 210),
      random(25, 65)
    );

    strokeWeight(random(8, 30));

    beginShape();

    curveVertex(-100, 250 + offset);
    curveVertex(-100, 250 + offset);

    curveVertex(250, 100 + offset);
    curveVertex(500, 500 + offset);
    curveVertex(750, 250 + offset);
    curveVertex(1000, 600 + offset);

    curveVertex(1000, 600 + offset);

    endShape();
  }

  // Large translucent sweeping curves

  for (int i = 0; i < 9; i++) {

    stroke(
      235, 200, 220,
      random(15, 45)
    );

    strokeWeight(random(20, 55));

    bezier(
      -100, random(height),
      250, random(height),
      600, random(height),
      1000, random(height)
    );
  }
}

// ----------------------------------
// BOTANICAL STEMS AND LEAVES
// ----------------------------------

void drawBotanicalStems() {

  for (int i = 0; i < 24; i++) {

    float x = random(70, width - 70);
    float y = random(100, height - 100);

    float direction = random(-1, 1);

    stroke(teal, 150);
    strokeWeight(2);

    noFill();

    bezier(
      x, y,
      x + 40 * direction, y - 70,
      x - 40 * direction, y - 110,
      x + 20 * direction, y - 160
    );

    for (int j = 0; j < 4; j++) {

      float lx = x + random(-35, 35);
      float ly = y - j * 28;

      drawLeaf(lx, ly, random(-1.2, 1.2));
    }
  }
}

void drawLeaf(float x, float y, float angle) {

  pushMatrix();
  translate(x, y);
  rotate(angle);

  noStroke();

  fill(teal, 185);

  beginShape();
  vertex(0, 0);
  bezierVertex(
    35, -35,
    65, -15,
    55, 0
  );
  bezierVertex(
    35, 20,
    15, 12,
    0, 0
  );
  endShape(CLOSE);

  stroke(180, 190, 185, 100);
  strokeWeight(1);

  line(0, 0, 48, 0);

  popMatrix();
}

// ----------------------------------
// FLOWER CLUSTERS
// ----------------------------------

void drawFlowerClusters() {

  // Intentional asymmetrical composition
  float[][] locations = {
    {680, 180},
    {220, 390},
    {690, 660},
    {300, 900},
    {790, 970},
    {450, 520}
  };

  for (int i = 0; i < locations.length; i++) {

    float x = locations[i][0];
    float y = locations[i][1];

    drawFlowerCluster(x, y, random(0.7, 1.3));
  }
}

void drawFlowerCluster(
  float x, float y, float scaleFactor
) {

  pushMatrix();

  translate(x, y);
  scale(scaleFactor);

  for (int i = 0; i < 15; i++) {

    float angle = random(TWO_PI);
    float distance = random(5, 65);

    float fx = cos(angle) * distance;
    float fy = sin(angle) * distance;

    drawFlower(
      fx, fy,
      random(0.35, 0.85)
    );
  }

  popMatrix();
}

// ----------------------------------
// INDIVIDUAL FLOWERS
// ----------------------------------

void drawFlower(float x, float y, float s) {

  pushMatrix();

  translate(x, y);
  rotate(random(TWO_PI));
  scale(s);

  int petals = int(random(5, 8));

  noStroke();

  for (int i = 0; i < petals; i++) {

    pushMatrix();

    rotate(TWO_PI * i / petals);

    fill(
      random(215, 245),
      random(205, 225),
      random(215, 240),
      random(170, 230)
    );

    ellipse(0, -13, 12, 25);

    popMatrix();
  }

  // Flower centre

  fill(112, 112, 128, 220);
  ellipse(0, 0, 9, 9);

  fill(ivory, 180);
  ellipse(1, -1, 3, 3);

  popMatrix();
}

// ----------------------------------
// FINE DETAILS
// ----------------------------------

void drawFineDetails() {

  // Floating botanical dots

  for (int i = 0; i < 180; i++) {

    float x = random(width);
    float y = random(height);

    noStroke();

    fill(
      random(200, 240),
      random(180, 220),
      random(205, 240),
      random(40, 120)
    );

    ellipse(
      x, y,
      random(1, 5),
      random(1, 5)
    );
  }

  // Delicate decorative curved strokes

  noFill();

  for (int i = 0; i < 35; i++) {

    float x = random(width);
    float y = random(height);

    stroke(ivory, 75);
    strokeWeight(1);

    bezier(
      x, y,
      x + 20, y - 35,
      x + 50, y + 25,
      x + 80, y - 10
    );
  }
}

// ----------------------------------
// PAINTERLY TEXTURE
// ----------------------------------

void drawTexture() {

  loadPixels();

  for (int y = 0; y < height; y++) {

    for (int x = 0; x < width; x++) {

      int index = x + y * width;

      float n = noise(
        x * 0.018,
        y * 0.018
      );

      float grain = random(-5, 5);

      color original = pixels[index];

      pixels[index] = color(
        constrain(red(original) + grain, 0, 255),
        constrain(green(original) + grain, 0, 255),
        constrain(blue(original) + grain, 0, 255)
      );
    }
  }

  updatePixels();
}

// ----------------------------------
// INTERACTION
// ----------------------------------

void mousePressed() {

  seed = int(random(100000));

  generatePainting();
}

void keyPressed() {

  if (key == 's' || key == 'S') {

    saveFrame(
      "WhispersOfMauve-####.png"
    );
  }
}
