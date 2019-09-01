float min = 0, max = 0;
boolean start = true; 
for (int i = 0; i < 100; i++)
{ float f = random(-5, 5);
  if (start) { min = max = f; start = false; }
  if (f < min) min = f;
  else if (f > max) max = f;
}
println(min, "   ", max);

