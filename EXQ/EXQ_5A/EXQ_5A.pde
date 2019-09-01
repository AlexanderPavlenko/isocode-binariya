float f1 = 0.55, f2 = 0.33;
int i1 = 8, i2 = 12;

void setup()
{ 
  println("middle beetwen", f1, "and", f2, "is", average(f1, f2));
  println("middle beetwen", i1, "and", i2, "is", average(i1, i2));
}

// используем механизм перегрузки, то есть - одно имя для всех:

float average(float a, float b) { return (a + b) / 2; }

int average(int a, int b) { return (a + b) / 2; }

