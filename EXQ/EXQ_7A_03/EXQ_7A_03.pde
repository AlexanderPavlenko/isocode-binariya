/////////////////////////////////////////////////////////////////
int count = 100;                              // количество             

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
    float dd;                   
    circle(x, y, r + 4, color(0, 35));                            // тень
    circle(x, y, r, c); circle(x, y, 0.8 * r, darkColor(c, 0.8)); // круг
    float d = 1 - (dd = dist(x, y, mouseX, mouseY)) / (width / 4);  
    if (d > 0)                                 // d - величина обратная, чем это удобно? 
    { circle(x, y, d * r * 0.7, color(255));   // чем ближе мышка, тем больше белый круг
      if (mousePressed)
      { if (mouseButton == LEFT)            
        { dx -= (mouseX - x) / dd; dy -= (mouseY - y) / dd;        // лениво убегаем 
        } else if (mouseButton == RIGHT)
               { dx += (mouseX - x) / dd; dy += (mouseY - y) / dd; // лениво нападаем
               }
      } 
    }
    if (irandom(35) == 11) { dx += random(-2.0, 2.0); dy += random(-2.0, 2.0); } // нервничаем
    if (x < 0) dx += 2; else if (x > width)  dx -= 2;  // что бы не расползались за край экрана
    if (y < 0) dy += 2; else if (y > height) dy -= 2;
    x += dx; y += dy; dx *= 0.95; dy *= 0.95;          // всё прибавляем(движемся) и "затухаем"
  }
}
c_circ[] circ; 

/////////////////////////////////////////////// обязательные функции
void setup()
{ 
  size(800, 600); smooth(); noStroke(); frameRate(30);
  circ = new c_circ[count];
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
