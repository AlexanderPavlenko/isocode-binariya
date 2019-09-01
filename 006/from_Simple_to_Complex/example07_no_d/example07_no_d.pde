/////////////////////////////////////////////// все о шариках
float offsx = 0, offsy = 0, offsc = 0.1, speed = 1.15, radius = 40, reaction = 0.01, falloff = 0.8, border = 1.0;
int count = 100;
boolean deep = true, shdw = true;

class c_circ
{
  float rad, bord, x, y, dx, dy, xx, yy, ddx, ddy;
  color c;
  c_circ ()
  {
    rad  = random(radius * 0.35, radius * 1.15); bord = rad * border;
    xx = x = random(bord, width - bord);
    yy = y = random(bord, height - bord);
    float d = random(3, 5) * speed;
    ddx = 0; dx  = d * zrandom ();
    ddy = 0; dy  = d * zrandom ();
    if (irandom(1) == 1) c = color (irandom(155, 255), irandom(100, 150), 0); else c = color (irandom(155, 205), 0, irandom(25, 50));
  }
  void regenerate()
  { 
    x += dx; y += dy;
    if ((x > (width - bord)) || (x < bord)) dx = - dx; else if (irandom(37) == 11) dx = - dx;
    if ((y > (height - bord)) || (y < bord)) dy = - dy; else if (irandom(37) == 11) dy = - dy;  
    ddx += (x - xx) * reaction;
    ddy += (y - yy) * reaction;
    ddx *= falloff;
    ddy *= falloff;
    xx += ddx;
    yy += ddy;
  }
  void draw(int i)
  {
    color cc;
    if (deep) { float t = 0.7 * i / count + 0.4; cc = color(red(c) * t, green(c) * t, blue(c) * t); } else cc = c;  
    if (shdw) circle (xx, yy, rad + 4, color(0, 0, 0, 35));
    circle (xx, yy, rad, cc);
    float oc = 1 + offsc;
    circle(xx + offsx * rad * 0.1, yy + offsy * rad * 0.1, 0.8 * rad, color(red(cc) * oc, green(cc) * oc, blue(cc) * oc));
    circle(xx + offsx * rad * 0.25, yy + offsy * rad * 0.25, 0.05 * rad, color(255, 255, 255));
  }
}

c_circ[] circ; 

/////////////////////////////////////////////// обязательные функции
void setup()
{ 
  size(640, 480); smooth(); noStroke(); frameRate(25);
  circ = new c_circ[count];
  for (int i = 0; i < count; i++) circ[i] = new c_circ();  
}

void draw()
{   
  background(0, 0, 0);
  for (int i = 0; i < count; i++)
  { circ[i].regenerate();
    circ[i].draw(i);
  }  
}

/////////////////////////////////////////////// вспомогательные функции
int irandom(int m) { return (int)(random(m) + 0.5); }
int irandom(int mn, int mx) { return (int)(random(mn, mx) + 0.5); }
int zrandom() { return 1 - 2 * irandom(1); }

void circle(float x, float y, float r, color c) { fill(c); ellipse(x, y, r * 2, r * 2); }
