size(400, 400); noStroke();
for (int y = 0; y < 8; y++)
for (int x = 0; x < 8; x++)
{ if ((x % 2) == (y % 2)) fill(255); else fill(0);
  rect(x * 50, y * 50, 50, 50);
}  
 
