int i = 0;
color c;

void setup() { size(640, 480); noLoop(); background(0); }

void draw()
{ 
  switch(i = (i + 1) % 3)
  { case 0: c = color(200, 0, 55); break;
    case 1: c = color(0, 155, 255); break;
    case 2: c = color(255, 135, 0); break;
  }
  sCircle(mouseX, mouseY, random(35, 200), 1, 5);
}

void mouseReleased() { redraw(); }

void sCircle(float x, float y, float r, float m, float s)
{
  if (r < 2) return;          
  strokeWeight(0.5 + s); fill(red(c) * m, green(c) * m, blue(c) * m); ellipse(x, y, r, r);
  sCircle(x, y, r * 0.75, m * 0.75, s * 0.35);
}
