/////////////////////////////////////////////// шарик
float r = 50, x, y, dx, dy;

///////////////////////////////////////////////
void setup()
{ 
  size(640, 480); smooth(); noStroke(); frameRate(25);
  x = width / 2; y = height / 2; dx = -5; dy = 5;
}

void draw()
{   
  background(0, 0, 0);
  x += dx; y += dy;
  if ((x > (width - r)) || (x < r)) dx = - dx;
  if ((y > (height - r)) || (y < r)) dy = - dy;  
  fill(255, 155, 0); ellipse(x, y, r * 2, r * 2);
  fill(235, 115, 0); ellipse(x, y, r * 1.5, r * 1.5);
}
