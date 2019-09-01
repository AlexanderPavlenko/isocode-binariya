class c_ret
{
  float p1, p2;
}

void setup()
{ 
  float[] r = new float[2];
  r = prop(200, 25); println(r[0], " ", r[1]);
}  

float[] prop(float a, float p)
{ 
  float[] r = new float[2]; 
  r[0] = a * p / 100; r[1] = a - r[0];
  return r;
}
