void setup()
{ 
  println(random(5));
  println(random(-5, 5));
  println((int)27.55);
}

int random(int max) { return int(random(max + 1.0)); }

int random(int min, int max) { return min + int(random(max - min + 1.0)); }
