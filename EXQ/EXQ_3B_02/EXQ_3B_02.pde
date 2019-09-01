void setup()
{ 
  float a = -5, b = 17, c = -25, e;
  e = getMin(getMin(a, b), c); println(e);
}
float getMin(float a, float b) { if (a < b) return a; else return b; }
