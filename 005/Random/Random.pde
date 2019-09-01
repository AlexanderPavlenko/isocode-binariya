void setup()
{ 
  println(random(5));
  println(random(-5, 5));
  println((int)27.55);
}

int random(int max) { return int(random (max + 0.5)); }

int random(int min, int max) { return min + int(random(max - min + 0.5)); }
