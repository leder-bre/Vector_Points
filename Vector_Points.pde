//SKETCH:  Vector Points
//AUTHOR:  Brendan Leder
int totalElements = 10;
float[] x = new float[totalElements];
float[] y = new float[totalElements];
float[] z = new float[totalElements];
float[] xSpeed = new float[totalElements];
float[] ySpeed = new float[totalElements];
float[] zSpeed = new float[totalElements];
float lightX = 0;
float lightY = 0;
float lightZ = 0;

void setup() {
  size(1280, 750, P3D);
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
  lightX = float(width)/2;
  lightY = float(height)/2;
  lightZ = -float(height+width)/2;
}

void draw() {
  background(0);
  //drawBox();
  movePoints();
  //drawBoxes(size), drawSpheres(size), drawLines(maxDistance, size, detail), sceneLighting()
  drawLines(600, 10, 100);
  //drawSpheres(30);
  drawBoxes(30);
  sceneLighting();
  pushMatrix();
  translate(0, height/2, -float(height+width)/4);
  fill(170);
  box(4, height, float(height+width)/2);
  popMatrix();
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

void drawLines(int maxDistance, int size, int detail) {
  for (int i = 0; i < totalElements; i++) {
    pushMatrix();
    translate(x[i], y[i], -z[i]);
    noStroke();
    fill(255*(float(i)/float(totalElements)), 255, 255);
    sphere(1);
    popMatrix();
    for (int j = 0; j < totalElements; j++) {
      if (j != i) {
        if (sqrt(pow(x[i]-x[j], 2) + pow(y[i]-y[j], 2) + pow(z[i]-y[j], 2)) < maxDistance) {
          float distance = sqrt(pow(x[i]-x[j], 2) + pow(y[i]-y[j], 2) + pow(z[i]-y[j], 2));
          float xChange = (x[i] - x[j])/detail;
          float yChange = (y[i] - y[j])/detail;
          float zChange = (z[i] - z[j])/detail;
          for (int l = 0; l < detail; l++) {
            pushMatrix();
            translate(x[j] + xChange * l, y[j] + yChange * l, -z[j] - zChange * l);
            float color1 = 255*(float(i)/float(totalElements));
            float color2 = 255*(float(j)/float(totalElements));
            float colorChange = color1 - color2;
            fill(color2 + colorChange, 255, 255, 255-255*distance/maxDistance);
            ellipse(0, 0, size, size);
            popMatrix();
          }
        }
      }
    }
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

void moveLighting() {
}

void sceneLighting() {
  //ambientLight(100, 100, 100);
  pointLight(100, 100, 100, float(width)/2, float(height)/2, -float(height+width)/4);
  pushMatrix();
  translate(lightX, lightY, lightZ);
  fill(255);
  sphere(5);
  popMatrix();
}