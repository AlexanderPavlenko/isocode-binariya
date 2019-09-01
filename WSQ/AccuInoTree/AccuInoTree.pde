//////////////////////////////////////////////////////
float scale = 0.025, offs = 0, fq = 1.25, sr = random(500), r = 0;
color c = color(125, 225, 255); 
int sw = 1, csw = 0;

//////////////////////////////////////////////////////
class c_noise
{
  float[] ns;
  float rands;
  int dm; 
  c_noise(int d) { ns = new float[dm = d]; rands = 0; for (int i = 0; i < d; i++) ns[i] = random(1.0); }
  float get(float t)
  {
    t = (dm + (t + rands) % dm) % dm; 
    int i1 = (int)t, i2 = (i1 + 1) % dm; 
    return ns[i1] + (ns[i2] - ns[i1]) * hermit(t - i1);
  }
  void startRand(float s) { rands = s; }
  float rand() { rands = (rands + dm * 0.137) * 1.019 % dm; return get(rands); }
  float rand(float mx) { return rand() * mx; }
  float rand(float mn, float mx) { return mn + (mx - mn) * rand(); }
}
c_noise ns;

///////////////////////////////////////////////////////////////////////////////////
void setup() { drawSize(800, 480); frameRate(30); ns = new c_noise(500); }
 
void draw()
{
  float p;
  color cb = color(red(c) * 0.7, green(c) * 0.7, blue(c) * 0.7),
        cf = color(red(c) * 0.25, green(c) * 0.25, blue(c) * 0.25);
  background(cb); 
  noStroke(); fill(c); drawCirc(width * 0.7, height * 0.35, height * 0.5);
  ns.startRand(sr);
  move(0.015, 1.25); 
  fill(cf); ground(0.05, 0.05); stroke(cf);
  r = 59; tree(0.45, level(0.45), 1.0, 1.0, 0.3, 0.1, 9);
  r = 20; sc *= 1.25;
  for (int i = 0; i < 3; i++) tree(p = ns.rand(0.1, 0.9), level(p), ns.rand(0.4, 0.65), 0.6, 0.3, 0.1, 5);
  r = 9; sc *= 1.5;
  for (int i = 0; i < 25; i++) tree(p = ns.rand(), level(p), ns.rand(0.1, 0.3), 0.5, 0.3, 0.1,(int)ns.rand(2, 5));
}

void keyReleased() { sr = random(500); }

void mouseReleased()
{ 
  if (dist(width * 0.7, height * 0.35, mouseX, mouseY) < height * 0.25)
  { csw = (csw + 1) % 4;
    switch(csw)
    { default: c = color(125, 225, 255); return;
      case 1: c = color(255, 100, 75); return;
      case 2: c = color(185, 215, 105); return;
      case 3: c = color(255, 75, 100); return;
    }
  }
  if (mouseY > height * (1 - level((float)mouseX / width))) sw = 1 - sw; else sr = random(500);
}

///////////////////////////////////////////////////////////////////////////////////
float sc;
void move(float d, float s) { offs += d; sc = s; }; 

///////////////////////////////////////////////////////////////////////////////////
float ll, lh; 
float level(float p) { return ll + lh * (1 + sin(3.5 + p * 5.5)); }

void ground(float l, float h) // земля
{ 
  ll = l; lh = h;
  drawBeginShape();
  vertex(drawXS, drawYL);
  for (float x = drawXS; x <= drawXL; x += 10) vertex(x, height * (1 - level(x / width)));
  vertex(drawXL, drawYL);
  drawEndShape(CLOSE);
}

///////////////////////////////////////////////////////////////////////////////////
float m1, m2; 

void tree(float p, float l, float sz, float t, float rb, float rj, int d)
{
  if (sw == 0) { m1 = abs(ns.get(offs) * sc); m2 = 1; } else { m1 = 0; m2 = 1 + abs(ns.get(offs) * sc); }
  pushMatrix();
  translate(width * p, height * (1 - l)); rotate(ns.rand(-0.1, 0.1)); branch(sz, t, rb, rj, d);
  popMatrix();
}

///////////////////////////////////////////////////////////////////////////////////
void branch(float sz, float t, float b, float j, int d)
{
  strokeWeight(12 * sz * t);
  if (d > 0)
  { drawLine(0, 0, 0, -height * 0.175 * sz);
    translate(0, -height * 0.175 * sz);
    rotate(ns.rand(-0.1, 0.1) * m2); 
    if (ns.rand(1.0) < 0.6)
    { scale(ns.rand(0.63, 0.87));
      pushMatrix(); rotate(ns.rand(b - j - m1, b + j + m1) * m2); branch(sz, t, b, j, d - 1); popMatrix();    
      pushMatrix(); rotate(ns.rand(-b - j - m1, -b + j + m1) * m2); branch(sz, t, b, j, d - 1); popMatrix();        
    } else { scale(ns.rand(0.85, 0.95)); branch(sz, t, b, j, d); }
  } else if (r > 0.1) { pushStyle(); noStroke(); drawCirc(0, 0, r); popStyle(); }
}

///////////////////////////////////////////////////////////////////////////////////
float hermit(float x) { return 3 * x * x - 2 * x * x * x; }
