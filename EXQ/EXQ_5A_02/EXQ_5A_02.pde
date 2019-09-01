float f1 = 0.2, f2 = 55.5;
int i1 = -10, i2 = 10;

void setup()
{ 
  println("blend from", f1, "to", f2, "with k = 0.35 is", blend(f1, f2, 0.35));
  println("blend from", i1, "to", i2, "with k = 75% is", blend(i1, i2, 75));
}

float blend(float a, float b, float k) { return a + (b - a) * k; }

int blend(int a, int b, int k) { return a + (b - a) * k / 100; }

