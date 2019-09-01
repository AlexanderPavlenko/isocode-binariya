float d = 0, u = 0;
for (int i = 0; i < 100; i++)
{ float f = random(-5, 5);
  if (f < 0) d += f; else u += f;
}
println(d, "   ", u);

