float x = 100, y = 100;
boolean h = false;                               

void setup() { size(800, 600); frameRate(30); noStroke(); }

void draw()
{ 
  background(255); fill(155, 215, 0); 
  if (h) ellipse(mouseX + x, mouseY + y, 100, 100); else ellipse(x, y, 100, 100);
}

void mousePressed()
{ 
  if (dist(mouseX, mouseY, x, y) < 50) {  x -= mouseX; y -= mouseY; h = true; }
}  

void mouseReleased()
{ 
  if (h) { x += mouseX; y += mouseY; h = false; }
} 
