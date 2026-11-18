
/*
  AUTUMN BOTANICA
  An abstract botanical painting inspired by the
  colours in the top-right section of the reference photo.

  Processing 4 - Java Mode
*/

int W = 1200;
int H = 900;

color[] leaves = {
  #EFA18E,  // soft coral
  #E77C72,  // salmon
  #D96C78,  // dusty rose
  #C75B62,  // muted crimson
  #D58B55,  // burnt orange
  #E6B66E,  // golden ochre
  #A88B53,  // olive
  #899B76,  // sage
  #A9B99D,  // pale sage
  #D9C7BA,  // warm blush
  #E9D8CB   // pale peach
};

color[] flowerColors = {
  #D92B80,
  #EC4B9B,
  #BE397C
};

void setup() {
  size(1200, 900);
  smooth(8);
  noLoop();
}

void draw() {
  randomSeed(28);

  background(#F0E5DA);

  // Soft atmospheric background
  drawBackground();

  // Underlying branches
  drawBranches();

  // Broad, overlapping foliage
  drawFoliage();

  // A few delicate flowers
  drawFlowers();

  // Subtle painterly surface
  drawTexture();

  saveFrame("Autumn_Botanica.png");
}

// --------------------------------
// BACKGROUND
// --------------------------------

void drawBackground() {
  noStroke();

  for (int i = 0; i < 90; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(50, 190);

    color[] bg = {
      #E9D8CB,
      #F0D9CF,
      #E8C7BD,
      #E4D8C7,
      #D7DDD0,
      #F3E8DB
    };

    fill(bg[int(random(bg.length))], 18);
    ellipse(x, y, s, s * 0.7);
  }
}

// --------------------------------
// BRANCHES
// --------------------------------

void drawBranches() {
  stroke(#A78B75, 180);
  strokeWeight(5);
  noFill();

  bezier(-50, 700, 300, 570,
         650, 850, 1250, 590);

  bezier(-50, 420, 250, 280,
         600, 500, 1230, 180);

  bezier(200, 950, 420, 680,
         760, 550, 1150, 300);

  bezier(100, 200, 350, 350,
         650, 200, 1050, -30);

  strokeWeight(2);

  bezier(50, 750, 320, 630,
         680, 750, 1180, 480);

  bezier(150, 300, 430, 450,
         800, 250, 1150, 120);
}

// --------------------------------
// FOLIAGE
// --------------------------------

void drawFoliage() {

  // Large leaves distributed organically
  for (int i = 0; i < 75; i++) {

    float x = random(-80, width + 80);
    float y = random(-80, height + 80);

    float s = random(55, 155);
    float angle = random(TWO_PI);

    color c = leaves[int(random(leaves.length))];

    drawLeaf(x, y, s, angle, c);
  }

  // Larger statement leaves, especially upper right
  drawLeaf(950, 110, 190, -0.5, #EFA18E);
  drawLeaf(1080, 220, 175, 0.6, #D58B55);
  drawLeaf(850, 300, 160, 0.2, #E77C72);
  drawLeaf(1040, 470, 175, 1.0, #A88B53);

  drawLeaf(720, 110, 150, 0.5, #E6B66E);
  drawLeaf(650, 720, 170, -0.3, #899B76);
  drawLeaf(350, 780, 150, 0.4, #A9B99D);
  drawLeaf(150, 530, 170, -0.6, #D96C78);

  drawLeaf(520, 320, 150, 0.9, #E9D8CB);
  drawLeaf(400, 150, 160, -0.4, #C75B62);
}

// --------------------------------
// INDIVIDUAL LEAF
// --------------------------------

void drawLeaf(float x, float y,
              float s, float angle, color c) {

  pushMatrix();
  translate(x, y);
  rotate(angle);
  scale(s / 100.0);

  noStroke();

  // Soft shadow
  fill(70, 45, 35, 20);
  ellipse(3, 5, 110, 43);

  // Leaf silhouette
  fill(c);

  beginShape();
  vertex(-55, 0);

  bezierVertex(-30, -42,
               25, -48,
               55, 0);

  bezierVertex(25, 45,
               -25, 42,
               -55, 0);

  endShape(CLOSE);

  // Subtle highlight
  fill(255, 255, 255, 35);

  beginShape();
  vertex(-40, -2);
  bezierVertex(-10, -35,
               25, -37,
               43, -5);
  bezierVertex(10, -16,
               -10, -10,
               -40, -2);
  endShape(CLOSE);

  // Central vein
  stroke(95, 80, 65, 85);
  strokeWeight(1.2);
  line(-48, 0, 48, 0);

  // Fine side veins
  stroke(100, 80, 60, 45);
  strokeWeight(0.7);

  for (int i = -30; i <= 30; i += 15) {
    line(i, 0, i + 12, -13);
    line(i, 0, i + 12, 13);
  }

  popMatrix();
}

// --------------------------------
// DELICATE FLOWERS
// --------------------------------

void drawFlowers() {

  // A few concentrated flower clusters
  for (int i = 0; i < 11; i++) {

    float x = random(100, 1100);
    float y = random(150, 800);

    float s = random(30, 65);

    color c = flowerColors[
      int(random(flowerColors.length))
    ];

    drawFlower(x, y, s, c);
  }

  drawFlower(820, 400, 65, #D92B80);
  drawFlower(250, 400, 55, #EC4B9B);
  drawFlower(620, 570, 70, #BE397C);
}

// --------------------------------
// STYLISED SPIDER FLOWER
// --------------------------------

void drawFlower(float x, float y,
                float s, color c) {

  pushMatrix();
  translate(x, y);

  stroke(c);
  strokeWeight(3);
  noFill();

  int petals = 12;

  for (int i = 0; i < petals; i++) {

    float a = TWO_PI * i / petals;

    float x1 = cos(a) * s * 0.2;
    float y1 = sin(a) * s * 0.2;

    float x2 = cos(a) * s;
    float y2 = sin(a) * s;

    bezier(0, 0,
           x1, y1,
           x2, y2,
           x2 * 1.1, y2 * 1.1);
  }

  noStroke();
  fill(#E9B66E);
  ellipse(0, 0, 10, 10);

  popMatrix();
}

// --------------------------------
// PAINTERLY TEXTURE
// --------------------------------

void drawTexture() {

  randomSeed(91);
  noStroke();

  for (int i = 0; i < 1800; i++) {

    float x = random(width);
    float y = random(height);

    fill(110, 85, 70, random(5, 15));

    ellipse(x, y,
            random(1, 3),
            random(1, 3));
  }
}
