//////////////////////////////////////////// 
int xD, yD, mD = 11, vFnow = 0, vCnow = 0;  
float vDef = 1.5, vMin = 1, vMax = 8, vDelta = vMax - vMin, vP = vMax - 2; 
float[][] value;
color vC1 = color(0, 50, 170), vC2 = color(15, 155, 255), vC3 = color(255, 255, 255);

float hermit(float t) { float t2 = t * t; return 3 * t2 - 2 * t2 * t; }

////////////////////////////////////////////
void setup()
{ 
  size(640, 480); frameRate(20); smooth(); noStroke();
  xD = width / 8; yD = height / 8;
  value = new float[yD][xD];
  for (int y = 0; y < yD; y++)
  for (int x = 0; x < xD; x++) value[y][x] = vDef;
}

////////////////////////////////////////////
void keyPressed()
{
  if (keyCode == ENTER) vCnow = (vCnow + 1) % 3;
  if (keyCode == UP) vFnow = 0;
  if (keyCode == DOWN) vFnow = 1; 
  if (keyCode == LEFT) vFnow = 2;
  if (keyCode == RIGHT) vFnow = 3; 

  switch(vCnow)
  { case 0: vC1 = color(0, 50, 170); vC2 = color(15, 155, 255); vC3 = color(255, 255, 255); break;
    case 1: vC1 = color(105, 0, 0); vC2 = color(255, 150, 0); vC3 = color(255, 255, 255); break;
    case 2: vC1 = color(40, 65, 0); vC2 = color(165, 215, 0); vC3 = color(255, 255, 255); break;
  }
}

////////////////////////////////////////////
void filterUp()
{
  for (int y = 0; y < yD - 1; y++)
  for (int x = 0; x < xD; x++) value[y][x] = value[y + 1][x] + random(-0.15, 0.15); 
}

////////////////////////////////////////////
void filterDown()
{
  for (int y = yD - 1; y > 1; y--)
  for (int x = 0; x < xD; x++) value[y][x] = value[y - 1][x] + random(-0.15, 0.15); 
}

////////////////////////////////////////////
void filterLeft()
{
  for (int y = 0; y < yD; y++)
  for (int x = 0; x < xD - 1; x++) value[y][x] = value[y][x + 1] + random(-0.15, 0.15); 
}

////////////////////////////////////////////
void filterRight()
{
  for (int y = 0; y < yD; y++)
  for (int x = xD - 1; x > 1; x--) value[y][x] = value[y][x - 1] + random(-0.15, 0.15); 
}

////////////////////////////////////////////
void vFilter()
{
  switch(vFnow)
  { case 0: filterUp(); break;
    case 1: filterDown(); break;
    case 2: filterLeft(); break;
    case 3: filterRight(); break;
  }
}

////////////////////////////////////////////
void vDraw()
{
  float r;
  background(0, 0, 0);
  if (mousePressed)
  { int xx = (mouseX - 4) / 8, yy = (mouseY - 4) / 8,
        x1 = max(xx - mD, 0), y1 = max(yy - mD, 0),
        x2 = min(xx + mD, xD - 1), y2 = min(yy + mD, yD - 1); 
    for (int y = y1; y <= y2; y++)
    for (int x = x1; x <= x2; x++)
    { r = dist(xx, yy, x, y); 
      if (r < mD) value[y][x] = constrain(value[y][x] + 3.75 * hermit((float)(mD - r) / mD), vMin, vMax);
    }  
  }
  for (int y = 0; y < yD; y++)
  for (int x = 0; x < xD; x++)
  { r = value[y][x] = max(value[y][x] * 0.97 - 0.001, vMin);
    fill(lerpColor(vC1, vC2,(r - vMin) / vDelta));
    ellipse(0.5 + 4 + x * 8, 0.5 + 4 + y * 8, r, r);
    if (r > vP) { fill(vC3); ellipse(0.5 + 4 + x * 8, 0.5 + 4 + y * 8, r - 5, r - 5); } 
  }
}

////////////////////////////////////////////
void draw()
{ 
  vDraw();
  vFilter();
}                                            

