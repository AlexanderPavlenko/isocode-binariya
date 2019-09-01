/////////////////////////////////////////////// все о шариках
float offsx = 0, offsy = 0, offsc = -0.1, radius = 40;
int count = 200;
boolean deep = true, shdw = true;

class c_circ
{
  float rad, x, y, dx, dy;
  color c;
  c_circ ()
  {
    rad  = random(radius * 0.35, radius * 1.15);
    x = random(rad, width - rad);
    y = random(rad, height - rad);
    float d = random(3, 5);
    dx  = d * zrandom();
    dy  = d * zrandom();
    if (irandom(1) == 1) c = color (irandom(155, 255), irandom(50, 150), 0); else c = color (irandom(155, 205), 0, irandom(25,50));
  }
  void draw(int i)
  {
    x += dx; y += dy;
    if ((x > (width - rad)) || (x < rad)) dx = - dx; else if (irandom(37) == 11) dx = - dx;
    if ((y > (height - rad)) || (y < rad)) dy = - dy; else if (irandom(37) == 11) dy = - dy;  
    color cc;
    if (deep) { float t = 0.7 * i / count + 0.4; cc = color(red(c) * t, green(c) * t, blue(c) * t); } else cc = c;  
    if (shdw) circle (x, y, rad + 4, color(0, 0, 0, 35));
    circle (x, y, rad, cc);
    float oc = 1 + offsc;
    circle (x + offsx * rad * 0.1, y + offsy * rad * 0.1, 0.8 * rad, color(red(cc) * oc, green(cc) * oc, blue(cc) * oc));
    circle (x + offsx * rad * 0.25, y + offsy * rad * 0.25, 0.05 * rad, color(255, 255, 255));
  }
}

c_circ[] circ;

/////////////////////////////////////////////// обязательные функции
void setup()
{ 
  size (1200, 400); smooth(); noStroke(); frameRate(25);
  circ = new c_circ[count];
  for (int i = 0; i < count; i++) circ[i] = new c_circ();  
}

void draw()
{   
  background(0, 0, 0);
  for (int i = 0; i < count; i++) { circ[i].draw(i); }  
}
/////////////////////////////////////////////// вспомогательные функции
int irandom(int m) { return (int)(random(m) + 0.5); }
int irandom(int mn, int mx) { return (int)(random(mn, mx) + 0.5); }
int zrandom() { return 1 - 2 * irandom(1); }

void circle(float x, float y, float r, color c) { fill(c); ellipse(x, y, r * 2, r * 2); }
