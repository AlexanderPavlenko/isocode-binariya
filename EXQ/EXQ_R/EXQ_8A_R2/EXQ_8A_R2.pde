float rotateA = 0,     // общий угол поворота
      inA = 0, inAD,   // угол поворота, прибавка для внутренней части  
      outA = 0, outAD; // угол поворота, прибавка для внешней части

int inT = 0,  // время действия для внутренней части
    outT = 0; // время действия для внешней части

void setup() { size(800, 800); frameRate(30); noStroke(); background(255); }

void draw()
{   
  background(255);
  
  float  cx = width / 2, cy = height / 2;
  
  // закончилось время действия? - генерируем новую прибавку к повороту и новое время действия:
  if (inT == 0) {  inAD = (int)(random(-4, 4)) * 0.01;  inT = (int)random(5, 50); }  // отдельно для внутренней
  if (outT == 0) { outAD = (int)(random(-4, 4)) * 0.01; outT = (int)random(5, 50); } // и внешней части
  // (int)(random(-4, 4)) - даёт нам как бы "ступенчатое" переключение, значения: -3, -2, -1, 0, 1, 2, 3
  // то есть и остановку (0) - тоже. уже только после этого - умножаем на 0.01 

  fill(200); circ(cx, cy, 250);
  fill(255); circ(cx, cy, 195.5);
  fill(190); circ(cx, cy, 195);
  
  rotateA = outA; // присваеваем угол поворота для внешней части
  
  fill(255); circR(cx, cy, 250, 35, 0, 4);

  fill(155); circR(cx, cy, 250, 25, 0, 4);
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
  
  inA += inAD;   if (inT != 0) inT--;
  outA += outAD; if (outT != 0) outT--;
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

