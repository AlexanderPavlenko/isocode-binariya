float f1 = 0.2, f2 = 55.5;
int i1 = -10, i2 = 10;
color c1 = color(255, 155, 0), c2 = color (35, 100, 100), c3;

void setup()
{ 
  println("blend from", f1, "to", f2, "with k = 0.35 is", blend(f1, f2, 0.35));
  println("blend from", i1, "to", i2, "with k = 75% is", blend(i1, i2, 75));
  c3 = blend(c1, c2, 0.27);
  println("blend from color", red(c1), green(c1), blue(c1), "to", red(c2), green(c2), blue(c2), "with k = 0.27 is", red(c3), green(c3), blue(c3));
}

float blend(float a, float b, float k) { return a + (b - a) * k; }

int blend(int a, int b, int k) { return a + (b - a) * k / 100; }

color blend(color a, color b, float k)
{
  return color(red(a) + (red(b) - red(a)) * k,
               green(a) + (green(b) - green(a)) * k,
               blue(a) + (blue(b) - blue(a)) * k
              );  
}

