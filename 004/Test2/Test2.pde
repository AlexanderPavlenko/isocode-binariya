int x = 0, s = 0;

void setup()
{ 
  size(720, 360); noStroke(); frameRate(50);
}

void draw()
{ 
  if (s == 0)
  { background(0); s = 1;
  } else { x = (x + 2) % width; s = 0;
           fill(255, 155, 0); ellipse(x, height / 2, 120, 120);
         }
}


