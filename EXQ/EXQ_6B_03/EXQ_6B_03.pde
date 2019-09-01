int c = 30, max = 99;
color c1 = color(155, 0, 55), c2 = color(255, 155, 55);
int[] a;

void setup()
{ 
  size(400, 400); frameRate(60); noStroke();
  a = new int[c];
  for (int i = 0; i < c; i++) a[i] = (int)random(1, max);
}

int si = 1, co = 0;  // номер текущей "перестановки" и счётчик операций
boolean sw = false;  // признак, что хоть одна переcтановка случилась за
                     // полный проход массива
void draw()
{
  if (a[si - 1] > a[si]) { int s = a[si - 1]; a[si - 1] = a[si]; a[si] = s; sw = true; } // перестановка
  background(0);
  float dx = (float)(width - 40) / c, wx = dx * 0.75, dy = height - 40, py = height - 20;
  for (int i = 0; i < c; i++)
  { fill(lerpColor(c1, c2, (float)a[i] / max));  // цвет в зависимости от значения
    rect(20 + dx * i, py - dy * a[i] / max, wx, dy * a[i] / max);
  }
  fill(255); rect(20 + dx * si, py + 5, wx, 10); // белый прямоугольничек обозначающий текущую позицию сортировки
  si++; co++;                                    // "идём" дальше 
  text(co, 20, 30);                              // выводим количество операций
  if (si == c)         // проход закончился?
  { si = 1;            // значит, потом снова начинаем с 1  
    if (!sw) noLoop(); // если за весь проход ни одной перестановки не случилось - останавливаем процесс 
    sw = false;        // и это обязательно нужно сделать, ведь начнётся новый проход 
  }                                                          
}  

