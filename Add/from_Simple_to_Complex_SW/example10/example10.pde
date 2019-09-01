class swRing                // в переделке в объект - нет ничего страшного, только аккуратность и универсальность (в меру),
{                           // теперь всё само подстраивается под радиусы: внутренний и внешний   
  int timeIn, timeOut;      // время действия для внутренней части b внешней части
  color cb, c, ci;          // цвет: фона, частей и "огоньков"
  float angIn, addIn,       // угол поворота, прибавка для внутренней части 
        angOut, addOut,     // угол поворота, прибавка для внешней части
        speed,              // скорость
        contrast;           // контраст 
        
  
  swRing()
  {
    timeIn = timeOut = 0;  
    cb = color(255); c = color(200); ci = color(255, 155, 0);
    speed = 1.0; contrast = 0.0;
  }

  void draw(float cx, float cy, float rIn, float rOut)
  { 
    float z = 1.0, k = 0.5;
    if (rOut - rIn < 50) z = 0.5;  
    if (rOut < 150) { z = 0.5; k = 0.25; }
    float r1 = rIn, r3 = rOut, r2 = r1 + (r3 - r1) * 0.375, r2mz = r2 - z, r2pz = r2 + z,
          s1 = (r2mz - r1) * 0.45, s3 = (r3 - r2pz) * 0.5, v;
    color c1 = c, c2 = mcColor(c, 0.9, contrast), c3 = mcColor(c, 0.75, contrast), c4 = mcColor(c, 0.95, contrast);      
    pushStyle();
    noStroke(); strokeCap(SQUARE); ellipseMode(RADIUS); 
  
    // закончилось время действия? - генерируем новую прибавку к повороту и новое время действия:
    if (timeIn == 0) { addIn = irandom(-4, 4) * 0.01;  timeIn = irandom(5, 50); }  // отдельно для внутренней
    if (timeOut == 0) { addOut = irandom(-4, 4) * 0.01; timeOut = irandom(5, 50); } // и внешней части
    // irandom(-4, 4) - даёт нам как бы "ступенчатое" переключение, значения: -4, -3, -2, -1, 0, 1, 2, 3, 4
    // то есть и остановку (0) - тоже. уже только после этого - умножаем на 0.01 

    pushMatrix();  // вращаем теперь через rotate(...), ну и translate(...) - тоже понадобился
    
      translate(cx, cy);
  
      pushMatrix();

        fill(c1); drawBagel(0, 0, (r3 + r2) / 2, r3 - r2);  // рисуем теперь основную форму буликами, чтобы в центре действительно была дырка  
        fill(c2); drawBagel(0, 0, (r2 + r1) / 2, r2 - r1);          

        fill(c3); drawBagel(0, 0, r2, z * 2 + k);
        fill(cb); drawBagel(0, 0, r2pz + k, k);
        fill(cb); drawBagel(0, 0, r2mz - k, k);

        rotate(angOut);

        strokeWeight(k); stroke(cb);
        drawLine(r2pz + k, 0, r3, 0);     
        drawLine(-(r2pz + k), 0, -r3, 0);
        drawLine(0, r2pz + k, 0, r3);
        drawLine(0, -(r2pz + k), 0, -r3);
        noStroke();

        fill(cb); circR(r3, s3 * 1.25, z, 0, 4);  

        fill(c3); circR(r3, s3, 0, 0, 4);
        fill(c4); circR(r3, v = (s3 * 0.8 - z), 0, 0, 2);

        strokeWeight((s3 - v) * 0.7); stroke(c3);  // крутящиеся линии в самых больших из расставленных кружков (внешних)

        pushMatrix();                    
          translate(r3, 0); rotate(-13.5 * angOut); drawLine(0, 0, v + k, 0);
        popMatrix();
        pushMatrix();                    
          translate(-r3, 0); rotate(-12.5 * angOut); drawLine(-(v + k), 0, 0, 0);
        popMatrix();
        pushMatrix();                    
          translate(0, r3); rotate(-14.0 * angOut); drawLine(0, 0, 0, v + k);
        popMatrix();
        pushMatrix();                    
          translate(0, -r3); rotate(-12.0 * angOut); drawLine(0, 0, 0, -(v + k));
        popMatrix();

        noStroke();
        fill(c3); circR(r3, s3 * 0.32, 0, 0, 1);

        fill(cb); circR(r3, s3 * 0.24, 0, 0, 1);
        fill(ci); circR(r3, s3 * 0.17, 0, 0, 1);

      popMatrix();
      pushMatrix();
      
        rotate(angIn);
      
        strokeWeight(k); stroke(cb);
        drawLine(r1, 0, r2mz - k, 0);
        drawLine(-r1, 0, -(r2mz - k), 0);
        drawLine(0, r1, 0, r2mz - k);
        drawLine(0, -r1, 0, -(r2mz - k));
        noStroke(); 

        fill(cb); circR(r1, s1 * 1.225, z, 0, 3);

        fill(c3); circR(r1, s1, 0, 0, 3);
        fill(c4); circR(r1, v = (s1 * 0.8 - z), 0, 0, 2);

        strokeWeight((s1 - v) * 0.7); stroke(c3);  // крутящиеся линии в самых больших из расставленных кружков (внутренних)

        pushMatrix();                    
          translate(r1, 0); rotate(13.5 * angIn); drawLine(0, 0, v + k, 0);
        popMatrix();
        pushMatrix();                    
          translate(-r1, 0); rotate(12.5 * angIn); drawLine(-(v + k), 0, 0, 0);
        popMatrix();
        pushMatrix();                    
          translate(0, r1); rotate(14.0 * angIn); drawLine(0, 0, 0, v + k);
        popMatrix();
        pushMatrix();                    
          translate(0, -r1); rotate(12.0 * angIn); drawLine(0, 0, 0, -(v + k));
        popMatrix();

        noStroke();

        fill(c3); circR(r1, s1 * 0.32, 0, 0, 1);

        fill(cb); circR(r1, s1 * 0.24, 0, 0, 1);
        fill(ci); circR(r1, s1 * 0.17, 0, 0, 1);

      popMatrix();
      
    popMatrix();
  
    angOut += addOut * speed; if (timeOut != 0) timeOut--;
    angIn += addIn * speed;   if (timeIn != 0) timeIn--;
     
    popStyle();
  }
}

swRing swR1 = new swRing(),
       swR2 = new swRing(),
       swR3 = new swRing(); 

void setup()
{ 
  size(900, 900); frameRate(30);

  swR2.speed = 0.66;        swR2.c = color(220);
  swR3.speed = 0.66 * 0.66; swR3.c = color(230);
}

void draw()
{   
  drawBegin(); // перешли на AccuDraw. потому, что дальше нужны очень хорошенькие линии
  
  background(255);
  swR1.draw(width / 2, height / 2, 150, 250);
  swR2.draw(width / 2, height / 2, 300, 350); 
  swR3.draw(width / 2, height / 2, 400, 420);
  
  drawEnd();
}

void circR (float r, float rm, float rd, int i, int d)
{
  float p = 2 * PI, h = p / 2, a, aa, as;

  if (i >= d) return;
  if (i == 0) { aa = 0; as = h / 2; 
              } else { aa = h / pow(2, i + 1); as = h / pow(2, i);   
                     }                               // pow(...) - возведение в степень          
  for (a = aa; a < p; a += as) drawCirc(-r * cos(a), r * sin(a), rm + rd);
  circR (r, rm * 0.5, rd, i + 1, d);
}

//////////////////////////////////////////////// вспомогательные функции
int irandom(int m) { return (int)random(m + 1.0); }
int irandom(int mn, int mx) { return (int)random(mn, mx + 1.0); }
int zrandom() { return 1 - 2 * irandom(1); }

color mcColor (color c, float m, float co) { m = pow(m, 1 + co); return color(red(c) * m, green(c) * m, blue(c) * m); }

void drawBagel(float x, float y, float r, float w)
{
  pushStyle();
  stroke(g.fillColor); noFill(); strokeWeight(w); drawCirc(x, y, r);
  popStyle();
}

