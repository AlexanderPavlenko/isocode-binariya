//////////////////////////////////////////////// объекты
class c_object 
{
  float r, d, a, ad;
  color c;  
}

////////////////////////////////////////////////
class c_system
{
  float x, y;
  c_object[] p;
  
  c_system() {  x = width / 2; y = height / 2; generate(irandom(3, 7), width / 2); }
  
  void setObjects(int count)
  { 
    if (p == null) p = new c_object[count]; else p = (c_object[])expand(p, count);
    for (int i = 0; i < p.length; i++) { p[i] = new c_object(); }
  }
  void generate(int count, float d) { setObjects(count); regenerate(d); }
  
  void regenerate(float d)
  {
    int i = 0, count = p.length;
    float sd = d / count, r, m;
    p[0].d = 0; p[0].r = random(sd * 0.75, sd * 1.25);      // солнце
    p[0].c = color(255, 100 + random(75), 0);
    p[0].a = p[0].ad = 0; 
    sd *= 2; count--;
    while (count != 0)                                      // планеты
    { i++; m = (d - sd) / count;
      p[i].d = sd + m - random(m * 0.2, m * 0.8); r = constrain(p[i].d - sd, 0, p[0].r * 0.6); 
      p[i].r = random(r * 0.15, r * 0.85); sd = p[i].d + p[i].r; 
      p[i].a = random(2 * PI); p[i].ad = -random(0.005, 0.01);
      p[i].c = color(75 + random(55), 75 + random(55), 75 + random(55));;
      count--;
    }
  }
  void drawOrbitas()
  {
    noFill(); stroke(35);
    for (int i = 1; i < p.length; i++) drawCirc(x, y, p[i].d);
  }
  void drawObjects()
  {
    noStroke(); 
    fill(p[0].c); drawCirc(x, y, p[0].r);     
    for (int i = 1; i < p.length; i++)
    { pushMatrix(); translate(x, y); rotate(p[i].a);
      fill(p[i].c); drawCirc(p[i].d, 0, p[i].r);
      popMatrix();
    }
  } 
  void regenerate()
  {
    for (int i = 1; i < p.length; i++) p[i].a = (p[i].a + p[i].ad) % (2 * PI); // а могло быть p[i].a += p[i].ad;
  }
}

//////////////////////////////////////////////// инициализация и отрисовка
c_system s;

void setup()
{
  size(600, 600); frameRate(30); ellipseMode(RADIUS);
  s = new c_system();
}

void draw()
{ 
  background(0);
  s.regenerate();
  s.drawOrbitas();
  s.drawObjects();
}

void keyReleased()
{
  if (keyCode == ENTER)
  { s.x = width / 2; s.y = height / 2;
    s.setObjects(irandom(3, 7)); s.regenerate(width / 2);
  }
}

//////////////////////////////////////////////// вспомогательные функции
int irandom(int m) { return (int)random(m + 1.0); }
int irandom(int mn, int mx) { return (int)random(mn, mx + 1.0); }
int zrandom() { return 1 - 2 * irandom(1); }
