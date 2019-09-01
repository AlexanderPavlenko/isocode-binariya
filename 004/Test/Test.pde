int x = 0;

void setup()
{ 
  size(720, 360); noStroke(); frameRate(25);
}

void draw()
{ 
  background(0);
  x = (x + 2) % width;
  fill(255, 155, 0); ellipse(x, height / 2, 120, 120);
}


