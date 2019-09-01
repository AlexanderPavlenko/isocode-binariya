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
  void drawOrbitasMorf(c_system s2, float k)
  {
    float xx = morf(x, s2.x, k), yy = morf(y, s2.y, k);
    noFill(); stroke(35);
    for (int i = 1; i < p.length; i++) drawCirc(xx, yy, morf(p[i].d, s2.p[i].d, k));
  }
  void drawRays()
  {
    float r = maxDist(x, y);
    noFill(); stroke(30);
    for (int i = 1; i < p.length; i++)
    {  pushMatrix(); translate(x, y); rotate(p[i].a);
       drawLine(0, 0, r, 0);
       popMatrix();
    }  
  }
  void drawRaysMorf (c_system s2, float k)
  {
    float r = max(maxDist(x, y), maxDist(s2.x, s2.y)),
          xx = morf(x, s2.x, k), yy = morf(y, s2.y, k);
    noFill(); stroke(30);
    for (int i = 1; i < p.length; i++)
    {  pushMatrix(); translate(xx, yy); rotate(morf(p[i].a, s2.p[i].a, k));
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
    { fill(p[i].c);
      pushMatrix(); translate(x, y); rotate(p[i].a);
      //if (i == 1) print(p[i].a, "");
      drawCirc(p[i].d, 0, p[i].r);
      fill(hiColor(p[i].c));
      drawEllipse(p[i].d - p[i].r * 0.35, 0.0, p[i].r * 0.6, p[i].r * 0.8);
      popMatrix();
    }
  } 
  void drawObjectsMorf(c_system s2, float k)
  {
    noStroke(); 
    float xx = morf(x, s2.x, k), yy = morf(y, s2.y, k), r = morf(p[0].r, s2.p[0].r, k), d;  
    color c = morf(p[0].c, s2.p[0].c, k);
    fill(c, 35); drawCirc(xx, yy, r * 1.25);
    fill(c, 35); drawCirc(xx, yy, r * 1.1);
    fill(c, 75); drawCirc(xx, yy, r * 1.025);
    fill(c);     drawCirc(xx, yy, r);
    for (int i = 1; i < p.length; i++)
    { c = morf(p[i].c, s2.p[i].c, k);
      pushMatrix(); translate(xx, yy); rotate(morfAngle(p[i].a, s2.p[i].a, k));
      //if (i == 1) print(morfAngle(p[i].a, s2.p[i].a, k), ""); 
      d = morf(p[i].d, s2.p[i].d, k); r = morf(p[i].r, s2.p[i].r, k); 
      fill(c); drawCirc(d, 0, r);
      fill(hiColor(c)); drawEllipse(d - r * 0.35, 0.0, r * 0.6, r * 0.8);
      popMatrix();
    }
  } 
  void draw() { drawOrbitas(); drawRays(); drawObjects(); }
  void drawMorf(c_system s2, float k)
  { 
    drawOrbitasMorf(s2, k); drawRaysMorf(s2, k); drawObjectsMorf(s2, k);
  }
  void regenerate()
  {
    for (int i = 1; i < p.length; i++) 
    { p[i].a = (p[i].a + p[i].ad * speed) % (2 * PI);
      //if (i == 1) print(p[i].a, ""); 
    }
  }
}

//////////////////////////////////////////////// инициализация и отрисовка
c_system[] s;
int i_from = 0, i_to = 1, mTime = 20, mTimer = 0;

void setup()
{
  size(800, 800); frameRate(30); ellipseMode(RADIUS);
  s = new c_system[2];
  s[0] = new c_system(); s[1] = new c_system();
}

void draw()
{ 
  background(0);
  if (focused) speed += (25 * ((float)width / 2 - mouseX) / width - speed) * 0.05;
  if (mTimer != 0)
  { s[i_from].regenerate(); s[i_to].regenerate();
    s[i_from].drawMorf(s[i_to], (float)(mTime - mTimer) / mTime);
    mTimer--; if (mTimer == 0) { int s = i_from;
                                 i_from = i_to; i_to = s;
                               }
  } else { s[i_from].regenerate(); s[i_from].draw(); }
}

void regenerate(float x, float y, boolean m)
{
  if (!m)
  { s[i_from].x = x; s[i_from].y = y;
    s[i_from].setObjects(irandom(7, 10)); s[i_from].regenerate(maxDist(s[i_from].x, s[i_from].y));
  } else if (mTimer == 0) { mTimer = mTime; s[i_to].x = x; s[i_to].y = y;
                            s[i_to].setObjects(s[i_from].p.length); s[i_to].regenerate(maxDist(s[i_to].x, s[i_to].y));
                          } 
}

void mouseReleased() { if (mTimer == 0) regenerate(mouseX, mouseY, mouseButton == RIGHT); }

void keyReleased() { if (mTimer == 0) regenerate(width / 2, height / 2, keyCode == ENTER); }

//void mouseWheel(MouseEvent event) { speed += event.getAmount(); speed = constrain(speed, -25.0, 25.0); }

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

float morf(float from, float to, float k) { return from + (to - from) * k; }

float morfAngle(float from, float to, float k)
{ 
  if (abs(to - from) > PI) { if (from < to) from += 2 * PI; else to += 2 * PI;
  //println(abs(to - from));
  } 
  return (from + (to - from) * k) % (2 * PI);
}

color morf(color from, color to, float k)
{
  return color(red(from) + (red(to) - red(from)) * k,
               green(from) + (green(to) - green(from)) * k,
               blue(from) + (blue(to) - blue(from)) * k);
}

//////////////////////////////////////////////// вспомогательные функции
int irandom(int m) { return (int)random(m + 1.0); }
int irandom(int mn, int mx) { return (int)random(mn, mx + 1.0); }
int zrandom() { return 1 - 2 * irandom(1); }

