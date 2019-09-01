void setup()
{ 
  float a = -5, b = 17, c = -25, d = 56, e = 41, f, g;
  f = getMin(getMin(getMin(getMin(a, b), c), d), e);
  g = getMin(getMax(getMax(getMax(a, b), c), d), e); println(f, "  ", g);
  
}
float getMin(float a, float b) { if (a < b) return a; else return b; }
float getMax(float a, float b) { if (a > b) return a; else return b; }
