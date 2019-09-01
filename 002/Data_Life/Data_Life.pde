int xs = 50, ys = 50;  

void setup()
{ 
  size(xs * 5 + 5, ys * 5 + 5);
  noStroke(); frameRate(20);
}

void draw()
{ 
  background(0, 0, 0);
  for (int y = 0; y < ys; y++)
  for (int x = 0; x < xs; x++)
  { float r = random(5);
    fill(0, 155, 255); ellipse(5 + x * 5, 5 + y * 5, r, r);
  }
}                                            

