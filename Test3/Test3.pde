int w = 5, h = 5, sc = 32, scs = 4;
float px = (float)w / 2, py = (float)h / 2; 

void setup() { size(w * sc, h * sc); noStroke(); noLoop(); }

//// Test //////////////
void draw()
{ 
  background(255);
  fill(0); ellipse(px, py, 1, 1);
  scale();
  fill(0, 25); ellipse(px * sc, py * sc, 1 * sc, 1 * sc);
  fill(120); text("x:" + px + "  y:" + py + "  r:" + 0.5, 5, h * sc - 5);
}

////////////////////////
void keyReleased()
{
  if (keyCode == LEFT) if (px > 1.5) px -= 0.25;
  if (keyCode == RIGHT) if (px < w - 1.5) px += 0.25; 
  if (keyCode == UP) if (py > 1.5) py -= 0.25;
  if (keyCode == DOWN) if (py < h - 1.5) py += 0.25; 
  redraw();  
}

void scale()
{
  loadPixels();
  for (int y = 0; y < h * sc; y++) 
  for (int x = 0; x < w * sc; x++) set(x, y, pixels[y / sc * (w * sc) + x / sc]);
  noStroke(); fill(255, 255, 255);  
  for (int y = 0; y <= h; y++)
  for (int x = 0; x <= w; x++)
  { rect(x * sc - 1, y * sc - sc / 4, 2, sc / 2); rect(x * sc - sc / 4, y * sc - 1, sc / 2, 2);
    rect(x * sc - 2, y * sc - 2, 4, 4);
  }
  fill(185, 185, 185); rect(2, 2, w * scs + 4, h * scs + 4);
  for (int y = 0; y < h * scs; y++) 
  for (int x = 0; x < w * scs; x++) set(4 + x, 4 + y, pixels[y / scs * (w * sc) + x / scs]);
}

