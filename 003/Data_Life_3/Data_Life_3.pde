int xs = 15, ys = 60, d = 8;    // тут добавили переменную
                             
void setup()                
{                           
  size(xs * d + d, ys * d + d); // размер окна теперь сам подстраивается 
  noStroke(); rectMode(CENTER); frameRate(20);  
}

void draw()                  
{                            
  background(0, 0, 0);
  for (int y = 0; y < ys; y++)
  for (int x = 0; x < xs; x++)
  if (random(1) < 0.5) drawDot(x, y); else drawDot2(x, y); // добавили условие
}                                            

void drawDot(int x, int y) 
{                            
  float r = random(d);           // немного больше универсальности
  if ((x & 1) == (y & 1)) fill(0, 155, 255); else fill(0, 55, 175); 
  ellipse(d + x * d, d + y * d, r, r); 
}

void drawDot2(int x, int y) 
{                             
  float r = random(d);       
  if ((x & 1) == (y & 1)) fill(255, 155, 0); else fill(155, 25, 0); 
  rect(d + x * d, d + y * d, r, r);
}
