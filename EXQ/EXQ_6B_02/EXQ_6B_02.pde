int c = 25, min = 0, max = 99;
int[] arr;

void setup()
{ 
  arr = new int[c];
  print("before sort: ");
  fillArr(arr, min, max); printArr(arr);
  print(" after sort: ");
  sortArr(arr); printArr(arr);
}

void fillArr(int[] a, int min, int max)
{
  for (int i = 0; i < a.length; i++) a[i] = (int)random(min, max);
}

void sortArr(int[] a)
{
  boolean sw = true; 
  while (sw)         // бегаем по массиву пока sw = true 
  { sw = false;      // чтобы потом ещё раз пробежать по массиву - нужна причина, 
    for (int i = 1; i < a.length; i++)                          // а пока её нет
     if (a[i - 1] > a[i]) { int s = a[i - 1]; a[i - 1] = a[i]; a[i] = s;
                            sw = true; // если случилась хоть одна перестановка,
                          }            // значит ещё раз потом "пробежим" по массиву  
  }  
}

void printArr(int[] a)
{
  for (int i = 0; i < a.length; i++) print(nfs(a[i], 2), "");
  println();
}
