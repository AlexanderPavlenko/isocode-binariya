int w = 20, h = 10, sc = 32, scs = 2, s = 0, m = 0;
float x1 = 2.5 * sc, y1 = 2.5 * sc, x2 = (w - 2.5) * sc, y2 = (h - 2.5) * sc, r = 15, mx, my, sw = 2.0; 

void settings() { size(w * sc, h * sc); } 

void setup() { frameRate(30); }

//// Test //////////////
void draw()
{  
  background(255); strokeWeight(sw);
  stroke(0); line(x1 / sc, y1 / sc, x2 / sc, y2 / sc);
  scale();
  fill(120); text("x1: " + (int)(x1 / sc) + "   y1: " + (int)(y1 / sc) + "   x2: " + (int)(x2 / sc) + "   y2: " + (int)(y2 / sc), 5, h * sc - 5);
  stroke(0, 175, 255); strokeWeight(2); line(x1, y1, x2, y2);
  strokeWeight(1);
  if (m == 1) line(mouseX + mx, mouseY + my, x2, y2);
  if (m == 2) line(x1, y1, mouseX + mx, mouseY + my);
  noStroke(); fill(0, 175, 255); ellipse(x1, y1, r, r); ellipse(x2, y2, r, r);
  fill(255); ellipse(x1, y1, r * 0.25, r * 0.25); ellipse(x2, y2, r * 0.25, r * 0.25);
  if (m != 0) { fill(0, 175, 255); ellipse(mouseX + mx, mouseY + my, r, r);
                fill(255); ellipse(mouseX + mx, mouseY + my, r * 0.75, r * 0.75);
                fill(0, 175, 255); ellipse(mouseX + mx, mouseY + my, r * 0.5, r * 0.5);
              }
}

/////////////////////////
void mousePressed()
{
  if (dist(mouseX, mouseY, x1, y1) < r)
  { mx = x1 - mouseX; my = y1 - mouseY; m = 1;
  } else if (dist(mouseX, mouseY, x2, y2) < r) { mx = x2 - mouseX; my = y2 - mouseY; m = 2; } 
}

void mouseReleased()
{
  if (m == 1)
  { x1 = mouseX + mx; y1 = mouseY + my; 
  } else if (m == 2) { x2 = mouseX + mx; y2 = mouseY + my; } 
  m = 0;
}

void keyReleased()
{ 
  if (keyCode == UP) sw += 0.5; 
  if (keyCode == DOWN) sw -= 0.5; 
  sw = constrain(sw, 1, 3);
}

void scale()
{
  loadPixels(); noStroke();
  for (int y = 0; y < h; y++) 
  for (int x = 0; x < w; x++) { fill(pixels[y * w * sc + x]); rect(x * sc, y * sc, sc, sc); }
  fill(255, 255, 255);  
  for (int y = 0; y <= h; y++)
  for (int x = 0; x <= w; x++)
  { rect(x * sc - 1, y * sc - sc / 4, 2, sc / 2); rect(x * sc - sc / 4, y * sc - 1, sc / 2, 2);
    rect(x * sc - 2, y * sc - 2, 4, 4);
  }
  fill(185, 185, 185); rect(2, 2, w * scs + 4, h * scs + 4);
  for (int y = 0; y < h * scs; y++) 
  for (int x = 0; x < w * scs; x++) set(4 + x, 4 + y, pixels[y / scs * (w * sc) + x / scs]);  
}