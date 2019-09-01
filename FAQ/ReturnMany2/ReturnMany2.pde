class c_ret
{
  float p1, p2;
}

void setup()
{ 
  c_ret r = new c_ret();
  r = prop(200, 25); println(r.p1, " ", r.p2);
}  

c_ret prop(float a, float p)
{ 
  c_ret r = new c_ret(); 
  r.p1 = a * p / 100; r.p2 = a - r.p1;
  return r;
}
