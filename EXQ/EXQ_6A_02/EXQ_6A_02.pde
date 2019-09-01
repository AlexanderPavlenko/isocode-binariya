int s = 20;
float a[];

void setup()
{ 
  a = new float[s];
  for (int i = 0; i < s; i++) a[i] = random(-5.0, 5.0);
  printHoles(a);
}

void printHoles(float[] a)
{
  if (a.length < 3) { println("lenght < 3"); return; }  
  for (int i = 1; i < (a.length - 1); i++)        // про nfc(...) почитаем в reference
  if ((a[i] < a[i - 1]) && (a[i] < a[i + 1])) print("[", nfc(a[i], 1), "]   "); else print(nfc(a[i], 1), "  ");  
}
