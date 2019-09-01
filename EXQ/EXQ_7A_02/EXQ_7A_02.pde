/////////////////////////////////////////////////////////////////
int count = 100;                              // количество             

class c_circ
{
  float r, x, y;
  color c;
  c_circ()
  {
    r = random(15, 45); x = random(0, width); y = random(0, height);
    c = randomColor();
  }
  void update()
  { 
    circle(x, y, r + 4, color(0, 35));                            // тень
    circle(x, y, r, c); circle(x, y, 0.8 * r, darkColor(c, 0.8)); // круг и круг
    float d = 1 - dist(x, y, mouseX, mouseY) / (width / 4);  // над этим и  
    if (d > 0) circle(x, y, d * r * 0.7, color(255));        // и этим — думаем внимательно
  } // да, чем больше d, тем больше "сигнальный" круг, но как мы получили такое удобное d?
}
c_circ[] circ;                                // массив объектов

/////////////////////////////////////////////// обязательные функции
void setup()
{ 
  size(800, 600); smooth(); noStroke(); frameRate(30);
  circ = new c_circ[count];                   // создаём массив
  for (int i = 0; i < count; i++) circ[i] = new c_circ(); // создаём объекты  
}

void draw()
{   
  background(0);
  for (int i = 0; i < count; i++) circ[i].update();
}

/////////////////////////////////////////////// вспомогательные функции
int irandom(int m) { return (int)random(m + 1.0); }
int irandom(int mn, int mx) { return (int)random(mn, mx + 1.0); }

void circle(float x, float y, float r, color c) { fill(c); ellipse(x, y, r * 2, r * 2); }
color darkColor (color c, float d) { return color(red(c) * d, green(c) * d, blue(c) * d); }
color randomColor()
{ if (irandom(1) == 1) return color(irandom(155, 255), irandom(100, 150), 0);
  else return color(irandom(155, 205), 0, irandom(25, 50));
}    

