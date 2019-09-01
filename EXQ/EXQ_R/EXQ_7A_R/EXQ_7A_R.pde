/////////////////////////////////////////////////////////////////
int count;                                          // количество             

class c_circ
{
  float r, x, y, dx, dy;
  color c;
  c_circ()
  {
    r = random(15, 45); x = random(0, width); y = random(0, height); dx = dy = 0;
    c = randomColor();
  }
  void update()
  { 
    float xr = 0, yr = 0, dd;
    boolean f = false;
    float d = 1 - (dd = dist(x, y, mouseX, mouseY)) / (width / 4);  
    if (d > 0)                                  
    { f = true;
      xr = 3 * random(-d, d); yr = 3 * random(-d, d);  // дрожалки
      if (d > 0.66)                         // больше двух третей, значит - меньше одной трети
      { dx -= (mouseX - x) / dd; dy -= (mouseY - y) / dd;
      }
    }
    if (irandom(35) == 11) { dx += random(-2.0, 2.0); dy += random(-2.0, 2.0); } // нервничаем
    if (x < 0) dx += 2; else if (x > width)  dx -= 2;  // что бы не расползались за край экрана
    if (y < 0) dy += 2; else if (y > height) dy -= 2;
    x += dx; y += dy; dx *= 0.95; dy *= 0.95;          // всё прибавляем(движемся) и "затухаем"

    circle(x + xr, y + yr, r + 4, color(0, 35));       // всё рисуем                      
    circle(x + xr, y + yr, r, c); circle(x + xr, y + yr, 0.8 * r, darkColor(c, 0.8));
    if (f) circle(x + xr, y + yr, d * r * 0.7, color(255));

  }
}
c_circ[] circ; 

/////////////////////////////////////////////// обязательные функции
void setup()
{ 
  size(800, 600); smooth(); noStroke(); frameRate(30);
  count = 100 * (width * height) / (800 * 600); // количество зависит от площади окна, за "эталон" 
  circ = new c_circ[count];                     // принято 100 объектов в разрешении 800х600  
  for (int i = 0; i < count; i++) circ[i] = new c_circ();  
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
