int i = 0;
color c;
float sc = 0.95, sl = 1.5, ad = PI / 24;

void setup() { size(640, 480); noLoop(); noStroke(); background(0); if (sc > 1) sc = 1; }

void draw()
{ 
  fill(0, 0, 0, 25); rect(0, 0, width, height);
  switch(i = (i + 1) % 3)
  { case 0: c = color(175, 0, 30); break;
    case 1: c = color(0, 110, 210); break;
    case 2: c = color(230, 110, 0); break;
  }
  sCircle(mouseX, mouseY, random(50, 200), 25, 0);
}

void mouseReleased() { redraw(); }

void sCircle(float x, float y, float r, int m, float a)
{
  if (r < 3) return;          
  fill(red(c) + m, green(c) + m, blue(c) + m); ellipse(x, y, r, r);
  fill(red(c) - m, green(c) - m, blue(c) - m); ellipse(x, y, r - 2, r - 2);
  r *= 0.5; m = -m; a += ad;
  sCircle(x + xRotate(r, a), y + yRotate(r, a), r * sc, m, a);
  sCircle(x + xRotate(r, a + PI / 2), y + yRotate(r, a + PI / 2), r * sc, m, a);
  sCircle(x + xRotate(r, a + PI), y + yRotate(r, a + PI), r * sc, m, a);
  sCircle(x + xRotate(r, a + PI * 3 / 2), y + yRotate(r, a + PI * 3 / 2), r * sc, m, a);
}

float xRotate(float r, float a) { return sl * r * cos(a); }
float yRotate(float r, float a) { return sl * r * sin(a); }
