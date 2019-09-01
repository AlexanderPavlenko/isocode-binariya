////////////////////////////////////////////////////////////////////
int ic = 1, deep = 6;
float sc = 1, sr = 0.5, sl = 1.5, alpha = 0, ad = PI / 400;

////////////////////////////////////////////////////////////////////
float px, py;

class c_emouse
{
  float x, y, px, py, dx, dy, react, foff, m;
  boolean sw;
  c_emouse(float r, float f)
  { x = random(width * 0.25, width * 0.25);
    y = random(height * 0.25, height * 0.25);
    dx = dy = m = 0; react = r; foff = f; sw = true;
  }
  void regenerate()
  { 
    if (mousePressed)
    { if (sw)
      { x = mouseX; y = mouseY; m = 1;
        dx = 0.5 * (mouseX - px); dy = 0.5 * (mouseY - py);
        sw = false; px = mouseX; py = mouseY; return;
      }
      dx += (mouseX - x) * react; dy += (mouseY - y) * react;
      dx *= foff; dy *= foff;
      x += dx; y += dy;
    } else { sw = true; m *= 0.975; }
    dx *= 0.975; dy *= 0.975;
    x += dx; y += dy; px = mouseX; py = mouseY;
  }
}

c_emouse emouse;
////////////////////////////////////////////////////////////////////
void setup()
{ 
  size(800, 600); frameRate(30); noStroke(); background(0);
  emouse = new c_emouse(0.1, 0.85);
}

void draw()
{ 
  background(0);
  emouse.regenerate(); alpha += ad; 
  sCircle(emouse.x, emouse.y, 50 + emouse.m * 100, 25, alpha, deep);
}

void mouseReleased() { ic = (ic + 1) % 3; }

////////////////////////////////////////////////////////////////////
void sCircle(float x, float y, float r, int m, float a, float d)
{
  if (d == 0) return;          
  fill(getColor(m)); ellipse(x, y, r, r);
  fill(getColor(-m)); ellipse(x, y, r - 2, r - 2);
  d--; r *= sr; m = -m; a += alpha;
  sCircle(x + xRotate(r, a), y + yRotate(r, a), r * sc, m, a, d);
  sCircle(x + xRotate(r, a + PI / 2), y + yRotate(r, a + PI / 2), r * sc, m, a, d);
  sCircle(x + xRotate(r, a + PI), y + yRotate(r, a + PI), r * sc, m, a, d);
  sCircle(x + xRotate(r, a + PI * 3 / 2), y + yRotate(r, a + PI * 3 / 2), r * sc, m, a, d);
}

////////////////////////////////////////////////////////////////////
float xRotate(float r, float a) { return sl * r * cos(a); }
float yRotate(float r, float a) { return sl * r * sin(a); }

color getColor(int m)
{ 
  switch(ic)
  { case 0: return color(175 + m, 0, 30);
    case 1: return color(0, 110 + m, 210 + m);
    case 2: return color(230 + m, 110 + m, 0);
    default: return 0; 
  }
}
