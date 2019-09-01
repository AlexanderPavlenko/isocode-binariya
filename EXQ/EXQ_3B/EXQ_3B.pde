void setup()
{ 
  float a = -5, b = 17, c;
  c = getMin(a, b); println(c);
}
float getMin(float a, float b) { if (a < b) return a; else return b; }
