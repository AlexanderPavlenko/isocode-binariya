///////////////////////////////////
int   push = 0, md = 11, area = 3, sz, ly, dst = 20, hdst = dst / 2;
float lev = 0, k1 = 0.05, k2 = 0.05, foff = 0.98, st = 4, md1 = md - 1;
float[] value, speed;
color c = color(55, 185, 225), c2, c3, c4;

///////////////////////////////////
void setup()
{ 
  size(1000, 300); frameRate(30);
  sz = width / dst; ly = height / 2; 
  value = new float[sz]; speed = new float[sz];
  for (int i = 0; i < sz; i++) value[i] = speed[i] = 0;
  c2 = color(red(c) * 0.8, green(c) * 0.8, blue(c) * 0.8);
  c3 = color(red(c) * 0.5, green(c) * 0.5, blue(c) * 0.5);
  c4 = color(red(c) * 2, green(c) * 2, blue(c) * 2);
}

///////////////////////////////////
float herm(float t) { return t * t * (3 - 2 * t); }

///////////////////////////////////
void draw()
{   
  float v, x, y, px = 0, py = 0, m, r, r2;
  int i, j, ix, i2;
  background(c); 
  for (i = 0; i < sz; i++)                                            // расчет взаимного влияния и приближения к общему уровню: 
  { speed[i] -= k1 * ((v = value[i]) - lev);                          // приближение к уровню
    for (j = 1; j <= area; j++)                                       // влияние соседей с глубиной просчета - area
     speed[i] += k2 * (value[max(i - j, 0)] + value[min(i + j, sz - 1)] - 2 * v) / j;
  }
  for (i = 0; i < sz; i++) value[i] += speed[i] *= foff;              // сумма всех воздействий -> + к скорости, а ее + к уровням
  noStroke(); fill(c2); 
  beginShape(); vertex(hdst, height - hdst);                          // визуализация общей формой
  for (i = 0; i < sz; i++) vertex(hdst + i * dst, ly - value[i]);     
  vertex(width - hdst, height - hdst); endShape(CLOSE);
  strokeWeight(1); stroke(c3);
  for (i = 0; i < sz; i++)                                            // визуализация линиями
  { x = hdst + i * dst; y = ly - value[i];
    if (i != 0) line(px, py, x, y); px = x; py = y;
  }
  noStroke();  
  for (i = 0; i < sz; i++)                                            // визуализация кружочками
  { r = 2.5;  x = hdst + i * dst + 0.5; y = ly - value[i] + 0.5;                                       
    fill(c3); ellipse(x, y, r + 3, r + 3);
    fill(c4); ellipse(x, y, r, r);
  }
  if (mousePressed)                                                   // расчет толчка кликом мыши
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
  { noFill(); stroke(255, 255, 255); strokeWeight(push * 0.5);
    float p = (15 - push) * 1.25;
    p *= p; ellipse(mouseX, mouseY, p, p); push--;
  }
}
