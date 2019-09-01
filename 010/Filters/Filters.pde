//////////////////////////////////////////////////////
float scale = 0.025, offs = 0;

//////////////////////////////////////////////////////
class c_noise
{
  float[] ns;
  int dim, i1, i2;
  float t, p1, p2, d; 
  c_noise(int d, float mn, float mx)
  { 
    ns = new float[d]; dim = d; for (int i = 0; i < d; i++) ns[i] = random(mn, mx);
  }
  void prepare(float tt)
  {
    t = (dim + tt % dim) % dim;
    i1 = (int)t; i2 = (i1 + 1) % dim; t -= i1; 
    p1 = ns[i1]; p2 = ns[i2]; d = p2 - p1;  
  }
  float get(float tt, int f) 
  {
    prepare(tt);
    switch(f)
    { case 0: return getSt(tt);
      case 1: return getLi(tt);
      case 2: return getHmLi(tt); 
      case 3: return getRnLi(tt); 
      case 4: return getLwLi(tt); 
      default: return 0;
    }
  }
  float getSt(float tt) { return p1; } 
  float getLi(float tt) { return p1 + d * t; } 
  float getHmLi(float tt) { return p1 + d * hermit(t); }
  float getRnLi(float tt) { return p1 + d * t + random(-0.05, 0.05); }
  float getLwLi(float tt) { return p1 + d * low(t, 0.85); } 
}
c_noise ns;

//////////////////////////////////////////////////////
void drawNoise(float lev, float h, float ofs, int f)
{
  lev *= height;
  beginShape(); vertex(0, lev);
  for (int x = 0; x <= width; x += 2) vertex(x, lev - height * h * ns.get(x * scale + ofs, f));
  vertex(width, lev); endShape(CLOSE);  
}

//////////////////////////////////////////////////////
void setup()
{ 
  size(1200, 400); smooth(); frameRate(30); noStroke(); 
  ns = new c_noise(100, 0.1, 1.0);
}

void draw()
{   
  background(0, 0, 0);
  offs += 0.1;
  fill(255, 145, 0); drawNoise(0.2, 0.15, offs, 0);
  fill(0, 175, 245); drawNoise(0.4, 0.15, offs, 1);
  fill(205, 0, 55); drawNoise(0.6, 0.15, offs, 2);
  fill(175, 215, 0); drawNoise(0.8, 0.15, offs, 3);
  fill(225, 75, 0); drawNoise(1.0, 0.15, offs, 4);
  stroke(0, 0, 0, 55);
  for (int x = 0; x < width; x += 20) line(x, 0, x, height);
  for (int y = 0; y < height; y += 5) line(0, y, width, y);
  noStroke();
}

///////////////////////////////////////////////////// Filters
float hermit(float t) { return 3 * t * t - 2 * t * t * t; }
float low(float t, float l) { l = 1 - t * l; return 1 - (1 - t) / l; }

