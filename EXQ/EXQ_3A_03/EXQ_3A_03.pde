void setup() { size(600, 500); frameRate(30); noStroke(); }

void draw()
{
  background(255);
  float s;
  for (int y = 0; y < 5; y++)
  for (int x = 0; x < 6; x++)
  { if ((x % 2) == (y % 2))  
    { s = 75; fill(255, 150, 0);
    } else { s = 50; fill(200, 50, 0);
           }
    ellipse(50 + x * 100 + random(-5, 5), 50 + y * 100 + random(-5, 5), s, s);
  }
}  
 
