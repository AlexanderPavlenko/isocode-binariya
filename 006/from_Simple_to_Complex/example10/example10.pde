/////////////////////////////////////////////// всё о шариках
float offsx = 0, offsy = 0, offsc = 0.1, speed = 1.25, radius = 40, reaction = 0.2, falloff = 0.975, border = 1.0;
int count = 850;
boolean deep = true, shdw = true;

class c_circ
{
  float rad, rm, bord, x, y, dx, dy, xx, yy, ddx, ddy;
  color c;
  c_circ()
  {
    rad  = random(radius * 0.35, radius * 1.15); bord = rad * border; rm = 0;
    xx = x = random(bord, width - bord);
    yy = y = random(bord, height - bord);
    float d = random(3, 5) * speed;
    ddx = 0; dx  = d * zrandom();
    ddy = 0; dy  = d * zrandom();
    if (irandom(1) == 1) c = color(irandom(155, 255), irandom(100, 150), 0); else c = color(irandom(155, 205), 0, irandom(25, 50));
  }
  void regenerate()
  { 
    x += dx; y += dy;
    if ((x > (width - bord)) || (x < bord)) dx = - dx; else if (irandom(37) == 11) dx = - dx;
    if ((y > (height - bord)) || (y < bord)) dy = - dy; else if (irandom(37) == 11) dy = - dy;  
    float d = dist(x, y, xx, yy);
    ddx += (x - xx) / d * reaction;
    ddy += (y - yy) / d * reaction;
    ddx *= falloff;
    ddy *= falloff;
    xx += ddx;
    yy += ddy;
  }
  void draw(int i, float r)
  {
    color cc;
    if (deep) { float t = 0.7 * i / count + 0.4; cc = color(red(c) * t, green(c) * t, blue(c) * t); } else cc = c;  
    if (shdw) circle(xx, yy, r + 4, color(0, 0, 0, 35));
    circle(xx, yy, r, cc);
    float oc = 1 + offsc;
    circle(xx + offsx * r * 0.1, yy + offsy * r * 0.1, 0.8 * r, color(red(cc) * oc, green(cc) * oc, blue(cc) * oc));
    circle(xx + offsx * r * 0.25, yy + offsy * r * 0.25, 0.05 * r, color(255, 255, 255));
  }
  void fill(float px, float py, float r)
  {
    rm += force(r, xx, yy, px, py);
    if (rm > 1) rm = 1;
  }
  void draw(int i) { if (rm > 0.05) draw(i, rad * rm); rm *= 0.95; }
}

c_circ[] circ;
/////////////////////////////////////////////// инерционная мышка
float px, py;

class c_emouse
{
  float x, y, px, py, dx, dy, react, foff, m;
  boolean sw;
  c_emouse(float r, float f) { x = y = dx = dy = m = 0; react = r; foff = f; sw = true; }
  void regenerate()
  { 
    if (mousePressed)
    { if (sw)
      { x = mouseX; y = mouseY; m = 0.05;
        dx = 0.5 * (mouseX - px);
        dy = 0.5 * (mouseY - py);
        sw = false; px = mouseX; py = mouseY; return;
      }
      dx += (mouseX - x) * react; dy += (mouseY - y) * react;
      dx *= foff; dy *= foff;
      x += dx; y += dy;
      m += 0.075; if (m > 1) m = 1;
    } else sw = true;
    dx *= 0.975; dy *= 0.975; m *= 0.975;
    x += dx; y += dy;
    px = mouseX; py = mouseY;
  }
}

c_emouse emouse;
/////////////////////////////////////////////// обязательные функции

void setup()
{ 
  size(800, 600); smooth(); noStroke(); frameRate(25);
  circ = new c_circ[count];
  for (int i = 0; i < count; i++) circ[i] = new c_circ();  
  emouse = new c_emouse(0.1, 0.85);
}

void draw()
{   
  background(0, 0, 0);
  emouse.regenerate();
  for (int i = 0; i < count; i++)
  { circ[i].regenerate();
    if (emouse.m > 0.04) circ[i].fill(emouse.x, emouse.y, 20 + 35 * emouse.m);
    circ[i].draw(i);
  }  
}

/////////////////////////////////////////////// вспомогательные функции
int irandom(int m) { return (int)random(m + 1.0); }
int irandom(int mn, int mx) { return (int)random(mn, mx + 1.0); }
int zrandom() { return 1 - 2 * irandom(1); }

void circle(float x, float y, float r, color c) { fill(c); ellipse(x, y, r * 2, r * 2); }

float force(float r, float x1, float y1, float x2, float y2)
{
  float d = dist(x1, y1, x2, y2);
  if (d > r) return 0; else return 1 - d / r;
}
