void setup() { size(800, 800); noLoop(); noStroke(); background(255); }

void draw()
{   
  float  cx = width / 2, cy = height / 2;

  fill(225); circ(cx, cy, 250);
  fill(155); circ4(cx, cy, 250, 20, 0, 4);
}

void circ4 (float cx, float cy, float r, float rm, int i, int d)
{
  float p = 2 * PI, h = p / 2, a, aa, as;

  if (i >= d) return;
  if (i == 0) { aa = 0; as = h / 2; 
              } else { aa = h / pow(2, i + 1); as = h / pow(2, i);  // pow(...) - возведение в степень   
                     }                  
  for (a = aa; a < p; a += as) circ(cx - r * cos(a), cy + r * sin(a), rm);
  circ4 (cx, cy, r, rm * 0.5, i + 1, d);
}

void circ(float x, float y, float r) { ellipse(x, y, r * 2, r * 2); }

