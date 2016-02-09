//SKETCH:  Vector Points
//AUTHOR:  Brendan Leder
int totalElements = 10;
float[] x = new float[totalElements];
float[] y = new float[totalElements];
float[] z = new float[totalElements];
float[] xSpeed = new float[totalElements];
float[] ySpeed = new float[totalElements];
float[] zSpeed = new float[totalElements];
int lightX = 0;
int lightY = 0;
int lightZ = 0;
void setup() {
  size(400, 400, P3D);
  colorMode(HSB);
  lights();
  for (int i = 0; i < totalElements; i++) {
    x[i] = random(width);
    y[i] = random(height);
    z[i] = random(float(width+height)/2);
    xSpeed[i] = random(float(width+height)/200);
    ySpeed[i] = random(float(width+height)/200);
    zSpeed[i] = random(float(width+height)/200);
  }
}

void draw() {
  background(0);
  ambientLight(100, 100, 100);
  pointLight(255, 0, 255, float(width)/2, float(height)/2, -float(height+width)/4);
  pushMatrix();
  translate(float(width)/2, float(height)/2, -float(height+width)/4);
  fill(255);
  sphere(5);
  popMatrix();
  drawBox();
  movePoints();
  //drawBoxes, drawSpheres
  drawSpheres(20);
}

void drawBox() {
  for (int i = 0; i < float(width+height)/2; i++) {
    pushMatrix();
    translate(0, 0, -i);
    fill(255);
    ellipse(0, 0, 3, 3);
    popMatrix();
  }

  for (int i = 0; i < float(width+height)/2; i++) {
    pushMatrix();
    translate(width, 0, -i);
    fill(255);
    ellipse(0, 0, 3, 3);
    popMatrix();
  }

  for (int i = 0; i < float(width+height)/2; i++) {
    pushMatrix();
    translate(width, height, -i);
    fill(255);
    ellipse(0, 0, 3, 3);
    popMatrix();
  }

  for (int i = 0; i < float(width+height)/2; i++) {
    pushMatrix();
    translate(0, height, -i);
    fill(255);
    ellipse(0, 0, 3, 3);
    popMatrix();
  }

  for (int i = 0; i < width; i++) {
    pushMatrix();
    translate(i, 0, -float(width+height)/2);
    fill(255);
    ellipse(0, 0, 3, 3);
    popMatrix();
  }

  for (int i = 0; i < width; i++) {
    pushMatrix();
    translate(i, height, -float(width+height)/2);
    fill(255);
    ellipse(0, 0, 3, 3);
    popMatrix();
  }

  for (int i = 0; i < height; i++) {
    pushMatrix();
    translate(0, i, -float(width+height)/2);
    fill(255);
    ellipse(0, 0, 3, 3);
    popMatrix();
  }

  for (int i = 0; i < height; i++) {
    pushMatrix();
    translate(width, i, -float(width+height)/2);
    fill(255);
    ellipse(0, 0, 3, 3);
    popMatrix();
  }
}

void drawBoxes(int size) {
  for (int i = 0; i < totalElements; i++) {
    pushMatrix();
    translate(x[i], y[i], -z[i]);
    noStroke();
    fill(255*(float(i)/float(totalElements)), 255, 255);
    box(size);
    popMatrix();
  }
}

void drawSpheres(int size) {
  for (int i = 0; i < totalElements; i++) {
    pushMatrix();
    translate(x[i], y[i], -z[i]);
    noStroke();
    fill(255*(float(i)/float(totalElements)), 255, 255);
    sphere(size);
    popMatrix();
  }
}

void movePoints() {
  for (int i = 0; i < totalElements; i++) {
    x[i] += xSpeed[i];
    if (x[i] > width || x[i] < 0) {
      xSpeed[i] *= -1;
    }
    y[i] += ySpeed[i];
    if (y[i] > height || y[i] < 0) {
      ySpeed[i] *= -1;
    }
    z[i] += zSpeed[i];
    if (z[i] > float(width+height)/2 || z[i] < 0) {
      zSpeed[i] *= -1;
    }
  }
}