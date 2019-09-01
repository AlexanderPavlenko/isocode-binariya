float x = 100, y = 100, px, py;
boolean h = false;                               

void setup() { size(800, 600); frameRate(30); noStroke(); }

void draw()
{ 
  background(255); fill(155, 215, 0); 
  if (h)
  { ellipse(px, py, 25, 25);
    stroke(155, 215, 0); line(px, py, mouseX + x, mouseY + y); noStroke();
    ellipse(mouseX + x, mouseY + y, 150, 150);
    fill(255); ellipse(mouseX + x, mouseY + y, 65, 65);
    fill(255, 175, 0); ellipse(mouseX + x, mouseY + y, 50, 50);
  } else ellipse(x, y, 150, 150);
}

void mousePressed()
{ 
  if (dist(mouseX, mouseY, x, y) < 50) { px = x; py = y; x -= mouseX; y -= mouseY; h = true; }
}  

void mouseReleased()
{ 
  if (h) { x += mouseX; y += mouseY; h = false; }
} 
