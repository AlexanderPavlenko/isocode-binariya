///////////////////////////////////////////////
float offsx = 0, offsy = 0, offsc = 0.1, speed = 1.25, radius = 40, reaction = 0.2, falloff = 0.975, border = 1.0;
int count = 850;
boolean deep = true, shdw = true;

class c_circ
{
  float rad, bord, x, y, dx, dy, xx, yy, ddx, ddy, f;
  color c;
  c_circ ()
  {
    rad  = random(radius * 0.35, radius * 1.15); bord = rad * border;
    xx = x = random (bord, width - bord);
    yy = y = random (bord, height - bord);
    float d = random(3, 5) * speed;
    ddx = 0; dx  = d * zrandom ();
    ddy = 0; dy  = d * zrandom ();
    if (irandom(1) == 1) c = color(irandom(155, 255), irandom(100, 150), 0); else c = color(irandom(155, 205), 0, irandom(25, 50));
  }
  void regenerate()
  { 
    x += dx; y += dy; f = 0;
    if ((x > (width - bord)) || (x < bord)) dx = - dx; else if (irandom(37) == 11) dx = - dx;
    if ((y > (height - bord)) || (y < bord)) dy = - dy; else if (irandom(37) == 11) dy = - dy;  
    float d = dist (x, y, xx, yy);
    ddx += (x - xx) / d * reaction;
    ddy += (y - yy) / d * reaction;
    ddx *= falloff;
    ddy *= falloff;
    xx += ddx;
    yy += ddy;
  }
  void addForce(float px, float py, float r) { f += force (r, xx, yy, px, py); }
  void draw(int i, float r)
  {
    color cc;
    if (deep) { float t = 0.7 * i / count + 0.4; cc = color(red(c) * t, green(c) * t, blue(c) * t); } else cc = c;  
    if (shdw) circle (xx, yy, r + 4, color(0, 0, 0, 35));
    circle (xx, yy, r, cc);
    float oc = 1 + offsc;
    circle(xx + offsx * r * 0.1, yy + offsy * r * 0.1, 0.8 * r, color(red(cc) * oc, green(cc) * oc, blue(cc) * oc));
    circle(xx + offsx * r * 0.25, yy + offsy * r * 0.25, 0.05 * r, color(255, 255, 255));
  }
  void drawForce(int i) { if (f > 0) draw(i, 0.7 * rad * f); }
}

c_circ[] circ, pcirc;

///////////////////////////////////////////////
void setup()
{ 
  size (640, 480); smooth(); noStroke(); frameRate(25);
  
  circ = new c_circ[count];
  for (int i = 0; i < count; i++) circ[i] = new c_circ();  
  pcirc = new c_circ[3];
  for (int i = 0; i < 3; i++) pcirc[i] = new c_circ();

}

void draw()
{   
  background(0, 0, 0);
  for (int i = 0; i < 3; i++) pcirc[i].regenerate(); 
  for (int i = 0; i < count; i++)
  { circ[i].regenerate();
    for (int j = 0; j < 3; j++) circ[i].addForce(pcirc[j].xx, pcirc[j].yy, 175);
    circ[i].drawForce(i);
  }  
  
}

///////////////////////////////////////////////
int irandom(int m) { return (int)(random(m) + 0.5); }
int irandom(int mn, int mx) { return (int)(random(mn, mx) + 0.5); }
int zrandom() { return 1 - 2 * irandom(1); }

void circle(float x, float y, float r, color c) { fill(c); ellipse(x, y, r * 2, r * 2); }

float force(float r, float x1, float y1, float x2, float y2)
{
  float d = dist (x1, y1, x2, y2);
  if (d > r) return 0; else return 1 - d / r;
}
