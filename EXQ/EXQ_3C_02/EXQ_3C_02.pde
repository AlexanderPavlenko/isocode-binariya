float min = 9999, max = -9999; 
for (int i = 0; i < 100; i++)
{ float f = random(-5, 5);
  if (f < min) min = f;
  else if (f > max) max = f;
}
println(min, "   ", max);

