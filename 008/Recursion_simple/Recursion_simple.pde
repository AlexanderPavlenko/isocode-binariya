void setup() { size(640, 480); noLoop(); noStroke(); background(0); }

void draw() { sCircle(mouseX, mouseY, random(25, 250), 35); }

void mouseReleased() { redraw(); }

void sCircle (float x, float y, float r, float c)
{
  if (r > 2) { fill(200 + c); ellipse(x, y, r, r); sCircle(x, y, r * 0.75, -c); }  
}
