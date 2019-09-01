size(400, 500);
background(0, 0, 0);
noStroke();

for (int i = 0; i < 2000; i++)
{ fill(155 + i / 20, 55 + i / 20, 0);
  float r = 2 + random(15);
  ellipse(random(400), random(500), r, r);
}  
