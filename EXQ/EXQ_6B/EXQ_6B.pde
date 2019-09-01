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
  for (int i = 1; i < a.length; i++)
   if (a[i - 1] > a[i]) { int s = a[i - 1]; a[i - 1] = a[i]; a[i] = s; }
}

void printArr(int[] a)
{
  for (int i = 0; i < a.length; i++) print(nfs(a[i], 2), "");
  println();
}
