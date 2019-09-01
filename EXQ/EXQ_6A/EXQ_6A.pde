int s = 20;
float a[];            // конечно, массив надо завести: сперва объявить

void setup()
{ 
  a = new float[s];   // создать
  for (int i = 0; i < s; i++) a[i] = random(-5.0, 5.0); // и заполнить
  printHoles(a);
}

void printHoles(float[] a)
{
  if (a.length < 3) { println("lenght < 3"); return; } // а вдруг...  
  for (int i = 1; i < (a.length - 1); i++)
  if ((a[i] < a[i - 1]) && (a[i] < a[i + 1])) print(i, " "); 
}
