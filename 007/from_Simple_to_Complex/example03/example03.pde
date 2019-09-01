/////////////////////////////////////////////// 2 шарика
float r1 = 50, x1, y1, dx1, dy1;
float r2 = 25, x2, y2, dx2, dy2;

///////////////////////////////////////////////
void setup()
{ 
  size(640, 480); smooth(); noStroke(); frameRate(25);
  x1 = random(r1, width - r1); y1 = random(r1, height - r1); dx1 = -5; dy1 = 5;
  x2 = random(r2, width - r2); y2 = random(r2, height - r2); dx2 = 5; dy2 = -5;
}

void draw()
{   
  background(0, 0, 0);
  x1 += dx1; y1 += dy1;
  if ((x1 > (width - r1)) || (x1 < r1)) dx1 = - dx1;
  if ((y1 > (height - r1)) || (y1 < r1)) dy1 = - dy1;  
  drawCircle(x1, y1, r1, color(255, 155, 0));
  x2 += dx2; y2 += dy2;
  if ((x2 > (width - r2)) || (x2 < r2)) dx2 = - dx2;
  if ((y2 > (height - r2)) || (y2 < r2)) dy2 = - dy2;  
  drawCircle(x2, y2, r2, color(175, 255, 0));
}

///////////////////////////////////////////////
void drawCircle(float x, float y, float r, color c)
{
  fill(c); ellipse(x, y, r * 2, r * 2);
  fill(red(c) - 25, green(c) - 25, 0); ellipse(x, y, r * 1.5, r * 1.5);
}

