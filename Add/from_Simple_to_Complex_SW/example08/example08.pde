float inA = 0, inAD,   // угол поворота, прибавка для внутренней части  
      outA = 0, outAD; // угол поворота, прибавка для внешней части

int inT = 0,  // время действия для внутренней части
    outT = 0; // время действия для внешней части

color cb = color(255), c1 = color(200), c2 = color(185), c3 = color(150), ci = color(255, 155, 0);

void setup() { size(800, 800); frameRate(30); }

void draw()
{   
  drawBegin(); // перешли на AccuDraw. потому, что дальше нужны очень хорошенькие линии
  
  background(cb);
  
  noStroke(); strokeCap(SQUARE); ellipseMode(RADIUS); 
  
  float  cx = width / 2, cy = height / 2;
  
  // закончилось время действия? - генерируем новую прибавку к повороту и новое время действия:
  if (inT == 0) {  inAD = (int)(random(-4, 4)) * 0.01;  inT = (int)random(5, 50); }  // отдельно для внутренней
  if (outT == 0) { outAD = (int)(random(-4, 4)) * 0.01; outT = (int)random(5, 50); } // и внешней части
  // (int)(random(-4, 4)) - даёт нам как бы "ступенчатое" переключение, значения: -3, -2, -1, 0, 1, 2, 3
  // то есть и остановку (0) - тоже. уже только после этого - умножаем на 0.01 

  pushMatrix();  // вращаем теперь через rotate(...), ну и translate(...) - тоже понадобился
    
    translate(cx, cy);
  
    pushMatrix();
      rotate(outA);

      fill(c1); drawCirc(0, 0, 250);  
      
      strokeWeight(0.5); stroke(cb);
      drawLine(192.5, 0, 250, 0);    // вот и линии, из-за которых AccuDraw понадобился 
      drawLine(-192.5, 0, -250, 0);
      drawLine(0, 192.5, 0, 250);
      drawLine(0, -192.5, 0, -250);
      noStroke(); 

      fill(cb); circR(250, 35, 0, 4); // от координат расположения избавились, translate(...) - теперь за них. 

      fill(c3); circR(250, 25, 0, 4);
      fill(c2); circR(250, 20, 0, 2);

      strokeWeight(4); stroke(150);  // крутящиеся линии в самых больших из расставленных кружков (внешних)

      pushMatrix();                    
         translate(250, 0); rotate(-13.5 * outA); drawLine(0, 0, 20, 0);
      popMatrix();
      pushMatrix();                    
         translate(-250, 0); rotate(-12.5 * outA); drawLine(-20, 0, 0, 0);
      popMatrix();
      pushMatrix();                    
         translate(0, 250); rotate(-14.0 * outA); drawLine(0, 0, 0, 20);
      popMatrix();
      pushMatrix();                    
         translate(0, -250); rotate(-12.0 * outA); drawLine(0, 0, 0, -20);
      popMatrix();

      noStroke();
      
      fill(c3); circR(250, 9, 0, 1);

      fill(cb); circR(250, 7, 0, 1);
      fill(ci); circR(250, 5, 0, 1);

    popMatrix();
      
    pushMatrix();
      rotate(inA);
      
      fill(cb); drawCirc(0, 0, 192.5);
      fill(c3); drawCirc(0, 0, 192);
      fill(cb); drawCirc(0, 0, 190);
      fill(c2); drawCirc(0, 0, 189.5);
      fill(cb); drawCirc(0, 0, 150);

      strokeWeight(0.5); stroke(cb);
      drawLine(150, 0, 189.5, 0);
      drawLine(-150, 0, -189.5, 0);
      drawLine(0, 150, 0, 189.5);
      drawLine(0, -150, 0, -189.5);
      noStroke(); 

      fill(cb); circR(150, 25, 0, 3);

      fill(c3); circR(150, 17, 0, 3);
      fill(c2); circR(150, 13, 0, 2);

      strokeWeight(2); stroke(150);  // крутящиеся линии в самых больших из расставленных кружков (внутренних)

      pushMatrix();                    
         translate(150, 0); rotate(13.5 * inA); drawLine(0, 0, 13, 0);
      popMatrix();
      pushMatrix();                    
         translate(-150, 0); rotate(12.5 * inA); drawLine(-13, 0, 0, 0);
      popMatrix();
      pushMatrix();                    
         translate(0, 150); rotate(14.0 * inA); drawLine(0, 0, 0, 13);
      popMatrix();
      pushMatrix();                    
         translate(0, -150); rotate(12.0 * inA); drawLine(0, 0, 0, -13);
      popMatrix();

      noStroke();

      fill(c3); circR(150, 6, 0, 1);
      
      fill(cb); circR(150, 5, 0, 1);
      fill(ci); circR(150, 3, 0, 1);
    popMatrix();
      
  popMatrix();
  
  inA += inAD;   if (inT != 0) inT--;
  outA += outAD; if (outT != 0) outT--;
  
  drawEnd();
}

void circR (float r, float rm, int i, int d)
{
  float p = 2 * PI, h = p / 2, a, aa, as;

  if (i >= d) return;
  if (i == 0) { aa = 0; as = h / 2; 
              } else { aa = h / pow(2, i + 1); as = h / pow(2, i);   
                     }                               // pow(...) - возведение в степень          
  for (a = aa; a < p; a += as) drawCirc(-r * cos(a), r * sin(a), rm);
  circR (r, rm * 0.5, i + 1, d);
}
