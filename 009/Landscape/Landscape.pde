float scale = 0.002, h = 1.75, s, offs = 0, d = 0.0075;
int tm = 15, m = 0;

//////////////////////////////////////////////////////
class lnoise
{
  float[] ns;
  int dim;
  lnoise(int d) { ns = new float[d]; dim = d; for (int i = 0; i < d; i++) ns[i] = low(random(1.0), 0.75); }
  float get(float t)
  { 
    t = (dim + t % dim) % dim;
    int i1 = (int)t, i2 = (i1 + 1) % dim;
    return ns[i1] + (ns[i2] - ns[i1]) * (t - i1);
  } 
}

lnoise ns;

//////////////////////////////////////////////////////
void setup()
{ 
  size(1200, 400); smooth(); frameRate(30); noStroke();
  ns = new lnoise(100);
}

void draw()
{   
  background(70, 0, 0);
  fill(124, 25, 0); ellipse(width * 0.75, height * 0.55, height * 0.85, height * 0.85);
  fill(255, 115, 0); ellipse(width * 0.25, height * 0.075, height * 0.35, height * 0.35);
  
  if (tm == 0) { tm = (int)random(10, 35); m = 9 - m; } else tm--; 
  offs += d * (1 + m); s = scale * (1 + 0.5 * sin(offs * 0.25));
  
  landscape(1.4, 0.25, offs * 0.25 + 54, color(100, 5, 0)); 
  landscape(1.2, 0.5, offs * 0.5 + 12, color(150, 25, 0)); 
  landscape(0.8, 0.75, offs * 0.75 + 121, color(200, 50, 0)); 
  landscape(0.0, 1.5, offs, color(255, 100, 0)); 
}

//////////////////////////////////////////////////////
void landscape(float lev, float sc, float ofs, color c)
{
  fill(c);
  beginShape(); vertex(0, height);
  for (int x = 0; x <= width; x += 1)
  { float xsc = s * x / sc,
          n = lev + h * sc * (min(1.25 * ns.get(xsc + ofs), ns.get(xsc * 2 + ofs * 0.7 + 34))
                              + 0.1 * ns.get(xsc * 8 + ofs + 21)
                              + 0.015 * ns.get(xsc * 32 + ofs + 7));
    vertex(x, height - n * height / 3);
  }
  vertex(width, height); endShape(CLOSE);
}

//////////////////////////////////////////////////////
float low(float t, float l) { l = 1 - t * l; if (l == 0) return 1; else return 1 - (1 - t) / l; }

