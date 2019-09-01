float inA = 0, inAD,   // угол поворота, прибавка для внутренней части  
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

  pushMatrix();  // вращаем теперь через rotate(...), ну и translate(...) - тоже понадобился
    translate(cx, cy);
  
    fill(200); circ(0, 0, 250);
    fill(255); circ(0, 0, 195.5);
    fill(190); circ(0, 0, 195);
    fill(255); circ(0, 0, 150);
  
    pushMatrix();
      rotate(outA);
  
      fill(255); circR(250, 35, 0, 4); // от координат расположения избавились, translate(...) - теперь за них. 

      fill(155); circR(250, 25, 0, 4);
      fill(185); circR(250, 20, 0, 2);

      fill(255); circR(250, 7, 0, 1);
      fill(255, 155, 0); circR(250, 5, 0, 1);

    popMatrix();
      
    pushMatrix();
      rotate(inA);

      fill(255); circR(150, 25, 0, 3);

      fill(155); circR(150, 17, 0, 3);
      fill(185); circR(150, 13, 0, 2);

      fill(255); circR(150, 5, 0, 1);
      fill(255, 155, 0); circR(150, 3, 0, 1);
    popMatrix();

  popMatrix();
  
  inA += inAD;   if (inT != 0) inT--;
  outA += outAD; if (outT != 0) outT--;
}

void circR (float r, float rm, int i, int d)
{
  float p = 2 * PI, h = p / 2, a, aa, as;

  if (i >= d) return;
  if (i == 0) { aa = 0; as = h / 2; 
              } else { aa = h / pow(2, i + 1); as = h / pow(2, i);   
                     }                               // pow(...) - возведение в степень          
  for (a = aa; a < p; a += as) circ(-r * cos(a), r * sin(a), rm);
  circR (r, rm * 0.5, i + 1, d);
}

void circ(float x, float y, float r) { ellipse(x, y, r * 2, r * 2); }

