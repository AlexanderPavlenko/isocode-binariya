int s = 40;
float a[] = new float[s], m = 5.0;

void setup() { size(1000, 200); noLoop(); }

void draw() 
{
  for (int i = 0; i < s; i++) a[i] = random(-m, m);
  background(255); 
  stroke(225); line(0, height / 2, width, height / 2);
  drawHP(a);
}

void mouseReleased() { redraw(); }

void drawHP(float[] a)
{
  int l = a.length;
  if (l < 3) { println("lenght < 3"); return; }  
  float x, y, px = 0, py = 0, cy = height / 2, dy = 0.75 * cy / m, dx = (float)(width - 100) / (l - 1), 
        px1 = 0, py1 = 0, px2 = 0, py2 = 0;
  boolean p1 = false, p2 = false;      
  for (int i = 0; i < l; i++)                    
  { x = 50 + dx * i; y = cy - dy * a[i];          
    if (i != 0) { stroke(125); line(px, py, x, y); } 
    noStroke(); fill(125); ellipse(x, y, 5, 5);               
    if ((i != 0) && (i < (l - 1)))                
    if ((a[i] < a[i - 1]) && (a[i] < a[i + 1]))         
    { noStroke(); ellipse(x, y, 8, 8); fill(0, 125, 255); ellipse(x, y + 10, 5, 5); 
      if (p1) { stroke(0, 125, 255); line(px1, py1 + 10, x, y + 10); } 
      px1 = x; py1 = y; p1 = true; 
    } else if ((a[i] > a[i - 1]) && (a[i] > a[i + 1])) 
           { noStroke(); ellipse(x, y, 8, 8); fill(255, 125, 0); ellipse(x, y - 10, 5, 5);
             if (p2) { stroke(255, 125, 0); line(px2, py2 - 10, x, y - 10); }
             px2 = x; py2 = y; p2 = true;
           } 
    px = x; py = y; // запоминаем предыдущие x и y, чтобы рисовать линии графика
  }  
}

