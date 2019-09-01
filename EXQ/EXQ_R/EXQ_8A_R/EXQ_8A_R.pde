float rotateA = 0,                // общий угол поворота
      inA = 0, inAD = -0.0125,    // угол поворота и его прибавка для внутренней части  
      outA = 0, outAD = 0.0125;   // угол поворота и его прибавка для внешней части

void setup() { size(800, 800); frameRate(30); noStroke(); background(255); }

void draw()
{   
  background(255);
  
  float  cx = width / 2, cy = height / 2;

  fill(200); circ(cx, cy, 250);
  fill(190); circ(cx, cy, 195);
  
  rotateA = outA; // присваеваем угол поворота для внешней части
  
  fill(255); circR(cx, cy, 250, 35, 0, 3);

  fill(155); circR(cx, cy, 250, 25, 0, 3);
  fill(185); circR(cx, cy, 250, 20, 0, 2);

  fill(255); circR(cx, cy, 250, 7, 0, 1);
  fill(255, 155, 0); circR(cx, cy, 250, 5, 0, 1);

  fill(255); circ(cx, cy, 150);

  rotateA = inA;  // присваеваем угол поворота для внутренней части

  fill(255); circR(cx, cy, 150, 25, 0, 3);

  fill(155); circR(cx, cy, 150, 17, 0, 3);
  fill(185); circR(cx, cy, 150, 13, 0, 2);

  fill(255); circR(cx, cy, 150, 5, 0, 1);
  fill(255, 155, 0); circR(cx, cy, 150, 3, 0, 1);
  
  inA += inAD;
  outA += outAD;
}

void circR (float cx, float cy, float r, float rm, int i, int d)
{
  float p = 2 * PI, h = p / 2, a, aa, as;

  if (i >= d) return;
  if (i == 0) { aa = 0; as = h / 2; 
              } else { aa = h / pow(2, i + 1); as = h / pow(2, i);   
                     }                               // pow(...) - возведение в степень          
  for (a = aa; a < p; a += as) circ(cx - r * cos(a + rotateA), cy + r * sin(a + rotateA), rm);
  circR (cx, cy, r, rm * 0.5, i + 1, d);
}

void circ(float x, float y, float r) { ellipse(x, y, r * 2, r * 2); }

