int ai = 100, bi = 55;
float af = 17.32, bf = 46.87; 

void setup()
{
  println(getMax(ai, bi));
  println(getMax(af, bf));
}

int getMax(int a, int b) { if (a > b) return a; else return b; }

float getMax(float a, float b) { if (a > b) return a; else return b; }
