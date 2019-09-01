//////////////////////////////////////////////////////
float scale = 0.025, offs = 0, fq = 1.25, w = 0, sr = random(500);
color c = color(55, 175, 225);

//////////////////////////////////////////////////////
class c_noise
{
  float[] ns;
  float rands;
  int dm; 
  c_noise(int d) { ns = new float[dm = d]; rands = 0; for (int i = 0; i < d; i++) ns[i] = random(1.0); }
  float get(float t)
  {
    t = (dm + t % dm) % dm; 
    int i1 = (int)t, i2 = (i1 + 1) % dm; 
    return ns[i1] + (ns[i2] - ns[i1]) * (t - i1);
  }
  void startRandom(float s) { rands = s; }
  float getRandom() { rands = (rands + dm * 0.137) * 1.019 % dm; return get(rands); }
  float getRandom(float mx) { return getRandom() * mx; }
  float getRandom(float mn, float mx) { return mn + (mx - mn) * getRandom(); }
}
c_noise ns;

///////////////////////////////////////////////////////////////////////////////////
void setup() { size(640, 480); frameRate(30); ns = new c_noise(500); }

void draw()
{
  color cb = color(red(c) * 0.7, green(c) * 0.7, blue(c) * 0.7),
        cf = color(red(c) * 0.25, green(c) * 0.25, blue(c) * 0.25);
  background(cb); 
  noStroke(); fill(c); ellipse(width * 0.7, height * 0.35, height * 0.5, height * 0.5);
  ns.startRandom(sr);
  wind(-0.025, 0.1, 0.975);
  fill(cf); ground(0.1, 0.025);
  stroke(cf); tree(0.45, getGround(0.45), 0.9, 0.9, 0.3, 0.1, 11);
  float p, pw = w;
  w *= 1.25; for (int i = 0; i < 3; i++) tree(p = ns.getRandom(0.1, 0.9), getGround(p), ns.getRandom(0.35, 0.6), 0.7, 0.3, 0.1, 6);
  w *= 1.25; for (int i = 0; i < 25; i++) tree(p = ns.getRandom(), getGround(p), ns.getRandom(0.1, 0.3), 0.4, 0.3, 0.1,(int)ns.getRandom(2, 4));
  w = pw;
}

void mouseReleased() { sr = (sr + random(150)) % 500; }
void keyReleased() { sr = (sr + random(150)) % 500; }

///////////////////////////////////////////////////////////////////////////////////
void wind(float d, float s, float f)
{ 
  offs += d; s *= ns.get(offs); w = abs(w);
  if (s > w) w += (s - w) * 0.1; else w *= f;
  if (d < 0) w = -w;
}; 

///////////////////////////////////////////////////////////////////////////////////
float gl, gh; 
float getGround(float p) { return gl + gh * (1 + sin(3.5 + p * 5.5)); }

void ground(float l, float h)
{ 
  gl = l; gh = h;
  beginShape();
  vertex(0, height);
  for (int x = 0; x <= width; x += 1) vertex(x, height * (1 - getGround((float)x / width)) - random(0.0, 0.5 + 20 * abs(w)));
  vertex(width, height);
  endShape(CLOSE);
}

///////////////////////////////////////////////////////////////////////////////////
void tree(float p, float l, float sz, float t, float rb, float rj, int d)
{
  pushMatrix();
  translate(width * p, height * (1 - l)); rotate(w); branch(sz, t, rb, rj, d, d);
  popMatrix();
}

///////////////////////////////////////////////////////////////////////////////////
void branch(float sz, float t, float b, float j, int d, int dm)
{
  strokeWeight(12 * sz * t);
  if (d > 0)
  { line(0, 0, 0, -height * 0.15 * sz);
    translate(0, -height * 0.15 * sz);
    float ww = w * low((float)d / dm, 0.75); 
    rotate(ns.getRandom(-0.1 + ww, 0.1 + ww)); 
    if (ns.getRandom(1.0) < 0.6)
    { scale(0.75);
      pushMatrix(); rotate(ns.getRandom(b - j + ww, b + j + ww)); branch(sz, t, b, j, d - 1, dm); popMatrix();    
      pushMatrix(); rotate(ns.getRandom(-b - j + ww, -b + j + ww)); branch(sz, t, b, j, d - 1, dm); popMatrix();        
    } else { scale(0.9); branch(sz, t, b, j, d, dm); }
  }
}
///////////////////////////////////////////////////////////////////////////////////
float low(float t, float l) { l = 1 - t * l; return 1 - (1 - t) / l; }
