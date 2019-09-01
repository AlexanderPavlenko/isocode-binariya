void setup()
{ 
  float v[] = new float[2];
  prop(200, 25, v); println(v[0], " ", v[1]);
}  

void prop(float a, float p, float v[])
{ 
  v[0] = a * p / 100; v[1] = a - v[0];
}
