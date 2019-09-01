///////////////////////////////////
int   push = 0, md = 11, area = 3, sz, ly, dst = 20, hdst = dst / 2;
float lev = 0, k1 = 0.05, k2 = 0.05, foff = 0.98, st = 5, md1 = md - 1;
float[] value, speed;

///////////////////////////////////
void setup()
{ 
  size(800, 400); frameRate(30); cursor(CROSS);
  sz = width / dst; ly = height / 2; 
  value = new float[sz]; speed = new float[sz];
  for (int i = 0; i < sz; i++) value[i] = speed[i] = 0;
}

///////////////////////////////////
float herm(float t) { return t * t * (3 - 2 * t); }

void falloff(color c, int a) { fill(c, a); pushStyle(); noStroke(); rect(0, 0, width, height); popStyle(); }

///////////////////////////////////
void draw()
{   
  float v, x, y, px = 0, py = 0, m, r, r2;
  int i, j, ix, i2;
  background(255, 175, 55);
  for (i = 0; i < sz; i++)                                           // расчет взаимного влияния и приближения к общему уровню: 
  { speed[i] -= k1 * ((v = value[i]) - lev);                         // приближение к уровню
    for (j = 1; j <= area; j++)                                      // влияние соседей с глубиной просчета - area
    speed[i] += k2 * (value[max(i - j, 0)] + value[min(i + j, sz - 1)] - 2 * v) / j;
  }
  if (mousePressed)                                                  // расчет толчка кликом мыши
  { ix = (constrain(mouseX, 0, width - 1) - hdst) / dst; 
    if (mouseY > ly) m = st; else m = - st; 
    speed[ix] += m; 
    for (i = 1; i < md; i++)
    { i2 = ix - i; if (i2 >= 0) speed[i2] += m * herm((md1 - i) / md1);
      i2 = ix + i; if (i2 < sz) speed[i2] += m * herm((md1 - i) / md1);
    }
    if (push == 0) push = 10;
  }
  if (push > 0)                                                      // украшательства действия толчка
  { noFill(); stroke(255, 255, 255, 255); strokeWeight(push * 0.5);
    float p = (15 - push) * 1.25;
    p *= p; ellipse(mouseX, mouseY, p, p); push--; 
  }
  for (i = 0; i < sz; i++) value[i] += speed[i] *= foff;             // сумма всех воздействий -> + к скорости, а ее + к уровням
                                                                     // отрисовка
  noFill(); strokeWeight(1); stroke(225, 125, 0);                    // визуализация скоростей 
  for (i = 0; i < sz; i++)                                           // через квадраты скоростей и кружочки
  { r = sq(speed[i]) * 0.5; ellipse(hdst + i * dst, ly - value[i], r, r);
  }
  strokeWeight(1.5); stroke(255, 255, 255);
  for (i = 0; i < sz; i++)                                           // через кружочки
  { r = abs(speed[i]) * 3; ellipse(hdst + i * dst, ly - value[i], r, r);
  }
  strokeWeight(1); stroke(50, 70, 30);
  for (i = 0; i < sz; i++)                                           // визуализация линиями
  { x = hdst + i * dst; y = ly - value[i];
    if (i != 0) line(px, py, x, y); px = x; py = y;
  }
  noStroke();  
  for (i = 0; i < sz; i++)                                           // визуализация кружочками
  { r = 2.5;  x = hdst + i * dst + 0.5; y = ly - value[i] + 0.5;                                       
    r += abs(speed[i]) * 0.175;                                      // визуализация абс. значения скорости через размер
    fill(50, 70, 30); ellipse(x, y, r + 1.75, r + 1.75);
    fill(255, 225, 155); ellipse(x, y, r, r);
  }
}
