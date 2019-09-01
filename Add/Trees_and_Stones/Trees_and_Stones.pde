///////////////////////////////////////////////////////////////////////////////////
float fq = 1.25; // частота
color c;
float[] level;   // тут храним уровень земли

void setup() { size(1200, 500); noLoop(); level = new float[width + 1]; noStroke(); }
 
void draw()
{
  c = getColor();  
  color cb = color(red(c) * 0.7, green(c) * 0.7, blue(c) * 0.7),
        cf = color(red(c) * 0.15, green(c) * 0.15, blue(c) * 0.15);
  background(cb); 
  noStroke(); fill(c); ellipse(width * 0.7, height * 0.45, height * 0.5, height * 0.5); // гигантская луна
  layer(0.275, lerpColor(cb, cf, 0.1), lerpColor(cb, cf, 0.15), 50, 8); // дальний слой(план) 
  layer(0.55, lerpColor(cb, cf, 0.4), lerpColor(cb, cf, 0.5), 40, 10);  // средний
  layer(1.1, lerpColor(cb, cf, 0.8), cf, 20, 12);                       // ближний
}

void keyPressed() { redraw(); }
void mousePressed() { redraw(); }

///////////////////////////////////////////////////////////////////////////// рисование слоя
void layer(float sz, color cs, color c, int g, int d)
{  
  level(sz, g);
  fill(cs);  
  for (int x = 0; x < width; x++) if (random(1.0) < (0.01 / sz)) stone(x, sz);
  fill(c); ground(sz);
  float x = random(80 * sz, 240 * sz) / fq;
  while (x < width) { tree(x, random(sz * 0.75, sz * 1.25), 0.3, 0.1, d); x += random(80 * sz, 240 * sz) / fq; }
  x = random(120 * sz, 360 * sz) / fq;
  while (x < width) { bush(x, random(sz * 0.75, sz * 1.25), 0.3, 0.1, d * 3 / 4); x += random(120 * sz, 360 * sz) / fq; }
}

///////////////////////////////////////////////////////////////////////////// расчёт общего уровня земли
void level(float sz, float g)
{
  int x = 0, d = (int)(sz * 150), p = (int)random(d / 4, d), s = 0;
  float v = 25 * sz, v1 = random(v), v2 = random(v); 
  while (x <= width)
  { level[x] = height - g - (v1 + (v2 - v1) * s / p); 
    x++;
    if (s == p)
    { s = 0; p = (int)random(d / 4, d);
      v1 = v2; v2 = random(v);
    } else s++;
  }
}

float level(float x) { return level[(int)(x + 2 * width) % width]; }       // узнать уровень в "месте" х

///////////////////////////////////////////////////////////////////////////// земля
void ground(float sz)
{
  beginShape();
  vertex(0, height);
  for (int x = 0; x <= width; x++) vertex(x, level[x] - sz * random(-2, 2));
  vertex(width, height);
  endShape(CLOSE);  
}  

///////////////////////////////////////////////////////////////////////////// камень
void stone(float x, float sz)
{
  float a = PI * 0.7, ad = - a, d = sz * width / 100, r, y = level(x);
  boolean f = true;
  d *= random(0.5, 1.5);
  if (random(1.0) < 0.1) d *= 3;
  r = random(d * 0.8, d * 1.2); y += random(d * 0.1, d * 0.25);
  beginShape();
  while (f)
  { if (ad > a) { ad = a; f = false; }
    r += random (-d * 0.1, d * 0.1);
    vertex(x + r * sin(ad), y - 0.5 * r * cos(ad)); 
    ad += random(0.1, 0.3);
  }
  endShape(CLOSE);  
}  

///////////////////////////////////////////////////////////////////////////// куст
void bush(float x, float sz, float rb, float rj, int d)
{
  sz *= random(0.3, 0.5);
  pushMatrix();
  translate(x, level(x) + random(100, 200) * sz); rotate(random(-0.1, 0.1));
  branch(sz, rb, rj, d, true);
  popMatrix();
}

///////////////////////////////////////////////////////////////////////////// дерево
void tree(float x, float sz, float rb, float rj, int d)
{
  pushMatrix();
  translate(x, level(x) + 6 * sz); rotate(random(-0.1, 0.1));
  branch(sz, rb, rj, d, true);
  popMatrix();
}

///////////////////////////////////////////////////////////////////////////// ветки
void branch(float sz, float b, float j, int d, boolean s) 
{
  float w = 12 * sz, sc;
  if (s) sc = 0.8; else sc = 0.9;
  if (d > 0)
  { boolean v = (random(1.0) < 0.6);
    fromto(0, 0, 0, -height * 0.15 * sz, w, w * sc, v);
    translate(0, -height * 0.15 * sz);
    rotate(random(-0.1, 0.1)); 
    if (v)
    { scale(sc * 0.833);
      pushMatrix(); rotate(random(b - j, b + j)); branch(sz, b, j, d - 1, false); popMatrix();    
      pushMatrix(); rotate(random(-b - j, -b + j)); branch(sz, b, j, d - 1, false); popMatrix();        
    } else { scale(sc); branch(sz, b, j, d, false); }
  }
}

///////////////////////////////////////////////////////////////////////////////////
color getColor() 
{
  switch(irandom(2))
  { case 0: return color(irandom(85, 105),  irandom(135, 155), irandom(165, 185));
    case 1: return color(irandom(165, 185), irandom(115, 135), irandom(125, 145));
    case 2: return color(irandom(140, 150), irandom(140, 160), irandom(140, 160));
    default: return color(255); 
  }
} 

//////////////////////////////////////////////// вспомогательные функции
int irandom(int m) { return (int)random(m + 1.0); }
int irandom(int mn, int mx) { return (int)random(mn, mx + 1.0); }
int zrandom() { return 1 - 2 * irandom(1); }

//////////////////////////////////////////////// "линия" переменной толщины и ещё с кой-какими особенностями...
void fromto (float x1, float y1, float x2, float y2, float w1, float w2, boolean v) 
{
  if (!calcDxDy(x1, y1, x2, y2)) return;
  beginShape();
  float dx = Dx * w1 / 2, dy = Dy * w1 / 2;
  vertex(x1 - dy , y1 + dx); vertex(x1 - dx , y1 - dy); vertex(x1 + dy , y1 - dx);
  dx = Dx * w2 / 2; dy = Dy * w2 / 2;
  if (v)
  { vertex(x2 + dy + dx / 2 , y2 - dx + dy / 2); vertex(x2 - dy + dx / 2, y2 + dx + dy / 2);
  } else { vertex(x2 + dy , y2 - dx); vertex(x2 + dx , y2 + dy); vertex(x2 - dy , y2 + dx); }
  endShape(CLOSE);    
}

float Dx, Dy;
boolean calcDxDy(float x1, float y1, float x2, float y2)
{
  float d;
  Dx = x2 - x1; Dy = y2 - y1; d = Dx * Dx + Dy * Dy;
  if (d < 0.001) return false;
  d = sqrt(d); Dx /= d; Dy /= d;
  return true;
}
