/////////////////////////////////////////////// все о шариках
int count = 100;

class c_circ
{
  float rad, x, y, dx, dy;
  color c;
  c_circ()
  {
    rad = random(20, 55); 
    x = random(rad, width - rad);
    y = random(rad, height - rad);
    float d = random(3, 5);
    dx  = d * zrandom();
    dy  = d * zrandom();
    c = color(irandom(55, 255), irandom(50, 150), 0);
  }
  void redraw()
  {
    x += dx; y += dy;
    if ((x > (width - rad)) || (x < rad)) dx = - dx;
    if ((y > (height - rad)) || (y < rad)) dy = - dy;  
    circle(x, y, rad, c);
    circle(x, y, rad * 0.75, color(red(c) - 15, green(c) - 20, 0));    
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
  for (int i = 0; i < count; i++) circ[i].redraw();
}

/////////////////////////////////////////////// вспомогательные функции
int irandom(int m) { return (int)(random(m) + 0.5); }
int irandom(int mn, int mx) { return (int)(random(mn, mx) + 0.5); }
int zrandom() { return 1 - 2 * irandom(1); }

void circle(float x, float y, float r, color c) { fill(c); ellipse(x, y, r * 2, r * 2); }
