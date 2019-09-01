int w = 11, h = 11, sc = 32, scs = 2, s = 0;
float x1 = w / 2.0 * sc, y1 = h / 2.0 * sc, r = 6.0, mx, my, sw = 1.0; 

void setup() { size(w * sc, h * sc); frameRate(30); }

//// Test //////////////
void draw()
{  
  background(255);  
  noStroke(); fill(255, 125, 0); ellipse((int)(x1 / sc) + 0.5,(int)(y1 / sc) + 0.5, r, r);
  noFill(); stroke(0); ellipse((int)(x1 / sc),(int)(y1 / sc), r, r);
  
  scale();
  noFill(); stroke(0); ellipse(x1, y1, r * sc, r * sc);
  fill(120); text("x1: " + nfc((x1 / sc), 2) + "   y1: " + nfc((y1 / sc), 2) + "   r: " + nfc(r / 2, 2), 5, h * sc - 5);
}

/////////////////////////
void mousePressed() { mx = x1 - mouseX; my = y1 - mouseY; }

void mouseDragged() { x1 = mouseX + mx; y1 = mouseY + my; }

void mouseReleased() { x1 = ((int)(x1 / sc) + 0.5) * sc; y1 = ((int)(y1 / sc) + 0.5) * sc; }

void keyReleased()
{ 
  if (keyCode == UP) r += 0.5; 
  if (keyCode == DOWN) r -= 0.5; 
  sw = constrain(sw, 2, 12);
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
