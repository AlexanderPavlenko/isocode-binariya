int s = 20;
float a[] = new float[s], m = 5.0;

void setup() { size(600, 300); noLoop(); }

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
  if (l < 3) { println("lenght < 3"); return; }  // кое-что сделано для того, чтобы всё было нарисовано корректно в зависимости
  float x, y, px = 0, py = 0, cy = height / 2, dy = 0.75 * cy / m, dx = (float)(width - 100) / (l - 1); // от размера окна. 
  for (int i = 0; i < l; i++)                    // а ещё - не забываем, что ось Y экрана направлена
  { x = 50 + dx * i; y = cy - dy * a[i];         // вниз. а значит кое-что считается наоборот. 
    if (i != 0) { stroke(125); line(px, py, x, y); } // чтобы расположиться там, где нам привычней
    noStroke(); fill(125); ellipse(x, y, 5, 5);  // исходя из математических изобразительных традиций. 
    if ((i != 0) && (i < (l - 1)))               // иначе "ямы" у нас окажутся выше "пиков" 
    if ((a[i] < a[i - 1]) && (a[i] < a[i + 1]))        // это "ямы" 
    { ellipse(x, y, 8, 8); fill(0, 125, 255); ellipse(x, y + 10, 5, 5);
    } else if ((a[i] > a[i - 1]) && (a[i] > a[i + 1])) // это пики
           { ellipse(x, y, 8, 8); fill(255, 125, 0); ellipse(x, y - 10, 5, 5);
           } 
    px = x; py = y; // запоминаем предыдущие x и y, чтобы рисовать линии графика
  }  
}

