int i = 0;
color c;
float sc = 1.0, sl = 1.25;

void setup()
{ 
  size(480, 640); noStroke(); background(0); noLoop();
  if (sc > 1) sc = 1;
}

void draw()
{ 
  fill(0, 0, 0, 25); rect(0, 0, width, height);
  switch(i = (i + 1) % 3)
  { case 0: c = color(175, 0, 30); break;
    case 1: c = color(0, 110, 210); break;
    case 2: c = color(230, 110, 0); break;
  }
  sCircle(mouseX, mouseY, random(50, 200), 25);
}

void mouseReleased() { redraw(); }

void sCircle(float x, float y, float r, int m)
{
  if (r < 3) return;          
  fill(red(c) + m, green(c) + m, blue(c) + m); ellipse(x, y, r, r);
  fill(red(c) - m, green(c) - m, blue(c) - m); ellipse(x, y, r - 2, r - 2);
  r *= 0.5; m = -m;
  sCircle(x + sl * r, y, r * sc, m); sCircle(x - sl * r, y, r * sc, m);
  sCircle(x, y - sl * r, r * sc, m); sCircle(x, y + sl * r, r * sc, m);
}
