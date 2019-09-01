float speed = 1.0;

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
  
  c_system()
  { 
    x = width / 2; y = height / 2; generate(irandom(7, 10), maxDist(x, y));
  }
  void setObjects(int count)
  { 
    if (p == null) p = new c_object[count]; else p = (c_object[])expand(p, count);
    for (int i = 0; i < p.length; i++) { p[i] = new c_object(); }
  }
  void setColor(int i, color c) { p[i].c = c; } 
  void setObject(int i, float r, float d, float a, float ad, color c)
  { 
    p[i].r = r; p[i].d = d; p[i].a = a; p[i].ad = ad; p[i].c = c;
  }
  void generate(int count, float d) { setObjects(count); regenerate(d); }
  void regenerate(float d)
  {
    int i = 0, count = p.length;
    float sd = d / count, r, m;
    p[0].d = 0; p[0].r = random(sd * 0.75, sd * 1.25);      // солнце
    p[0].c = sunColor(irandom(9)); p[0].a = p[0].ad = 0; 
    sd *= 2; count--;
    while (count != 0)                                      // планеты
    { i++; m = (d - sd) / count;
      p[i].d = sd + m - random(m * 0.2, m * 0.8); r = constrain(p[i].d - sd, 0, p[0].r * 0.6); 
      p[i].r = random(r * 0.15, r * 0.85); sd = p[i].d + p[i].r; 
      p[i].a = random(2 * PI); p[i].ad = -random(0.0025, 0.0075);
      p[i].c = planetColor();
      count--;
    }
  }
  void drawOrbitas()
  {
    noFill(); stroke(35);
    for (int i = 1; i < p.length; i++) drawCirc(x, y, p[i].d);
  }
  void drawRays()
  {
    float r = maxDist(s.x, s.y);
    noFill(); stroke(30);
    for (int i = 1; i < p.length; i++)
    {  pushMatrix(); translate(x, y); rotate(p[i].a);
       drawLine(0, 0, r, 0);
       popMatrix();
    }  
  }
  void drawObjects()
  {
    noStroke(); 
    fill(p[0].c, 35); drawCirc(x, y, p[0].r * 1.25);
    fill(p[0].c, 35); drawCirc(x, y, p[0].r * 1.1);
    fill(p[0].c, 75); drawCirc(x, y, p[0].r * 1.025);
    fill(p[0].c);     drawCirc(x, y, p[0].r);
    for (int i = 1; i < p.length; i++)
    { pushMatrix(); translate(x, y); rotate(p[i].a);
      fill(p[i].c); drawCirc(p[i].d, 0, p[i].r);
      fill(hiColor(p[i].c)); drawEllipse(p[i].d - p[i].r * 0.35, 0.0, p[i].r * 0.6, p[i].r * 0.8);
      popMatrix();
    }
  } 
  void regenerate()
  {
    for (int i = 1; i < p.length; i++) p[i].a = (p[i].a + p[i].ad * speed) % (2 * PI); // а могло быть p[i].a += p[i].ad;
  }
}

//////////////////////////////////////////////// инициализация и отрисовка
c_system s;

void setup()
{
  size(800, 800); frameRate(30); ellipseMode(RADIUS);
  s = new c_system();
}

void draw()
{ 
  background(0);
  if (focused) speed += (25 * ((float)width / 2 - mouseX) / width - speed) * 0.05;
  s.regenerate();
  s.drawOrbitas();
  s.drawRays();
  s.drawObjects();
}

void mouseReleased()
{ 
  s.x = mouseX; s.y = mouseY;
  s.setObjects(irandom(7, 10)); s.regenerate(maxDist(s.x, s.y));
}

void keyReleased()
{
  if (keyCode == ENTER)
  { s.x = width / 2; s.y = height / 2;
    s.setObjects(irandom(7, 10)); s.regenerate(maxDist(s.x, s.y));
  }
}

//////////////////////////////////////////////// цветовые функции 
color sc;
color sunColor(int i) 
{
  switch(i)
  { case 0: return sc = color(255,               irandom(100, 200), irandom(0, 55));
    case 1: return sc = color(irandom(175, 200), 255,               irandom(0, 55));
    case 2: return sc = color(irandom(0, 55),    255,               irandom(175,  255));
    case 3: return sc = color(irandom(0, 55),    irandom(155, 215), 255);
    case 4: return sc = color(255,               irandom(0, 35),    irandom(35, 85));
    case 5: return sc = color(255,               irandom(200, 225), irandom(150, 175));
    case 6: return sc = color(irandom(200, 225), 255,               irandom(150, 175));
    case 7: return sc = color(irandom(150, 175), 255,               irandom(200, 225));
    case 8: return sc = color(irandom(150, 200), irandom(200, 225), 255);
    case 9: return sc = color(255,               irandom(150, 175), irandom(200, 225));
    default: return sc = color(255, 255, 255);
  }
}  
color planetColor() 
{
  int r = (int)red(sc) / 2, g = (int)green(sc) / 2, b = (int)blue(sc) / 2;
  return color(irandom(r / 2, r), irandom(g / 2, g), irandom(b / 2, b));
} 

color hiColor(color c) { return color (red(c) * 1.2, green(c) * 1.2, blue(c) * 1.2); }

float maxDist(float x, float y)
{
  return max(max(dist(x, y, width, height), dist(x, y, 0, 0)), max(dist(x, y, 0, height), dist(x, y, width, 0))); 
}

//////////////////////////////////////////////// вспомогательные функции
int irandom(int m) { return (int)random(m + 1.0); }
int irandom(int mn, int mx) { return (int)random(mn, mx + 1.0); }
int zrandom() { return 1 - 2 * irandom(1); }
