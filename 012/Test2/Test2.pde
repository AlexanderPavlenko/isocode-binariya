int w = 10, h = 5, sc = 32, scs = 4;
float py = 1; 

void settings() { size(w * sc, h * sc); }

void setup() { noStroke(); noLoop(); }

//// Test //////////////
void draw()
{ 
  background(255);
  fill(0); rect(1, h / 2 + py, w - 2, 1);
  scale();
  fill(0, 25); rect(1 * sc,(h / 2 + py) * sc,(w - 2) * sc, 1 * sc);
  fill(120); text("x:" + 1.0 + "  y:" + (h / 2 + py), 5, h * sc - 5);
}

////////////////////////
void keyReleased()
{
  if (keyCode == UP) if (py > -1) py -= 0.25;
  if (keyCode == DOWN) if (py < 1) py += 0.25; 
  redraw();  
}

void scale()
{
  loadPixels(); noStroke();
  for (int y = 0; y < h; y++) 
  for (int x = 0; x < w; x++) { fill(pixels[y * (w * sc) + x]); rect(x * sc, y * sc, sc, sc); }
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