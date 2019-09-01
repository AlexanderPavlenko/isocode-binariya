int w = 12, h = 12, sc = 32, scs = 2, s = 0;
float x1 = w / 2.0 * sc, y1 = h / 2.0 * sc, r = 7, mx, my, sw = 1.0; 
int ad = 0;

void settings() { size(w * sc, h * sc); }

void setup() { smooth(); frameRate(30); } 

//// Test //////////////
void draw()
{  
  background(255); stroke(0);
  fill(255, 125, 0); 
  
  if (ad == 1) drawEllipse(x1 / sc, y1 / sc, r, r);
  else ellipse(x1 / sc, y1 / sc, r, r); 
  
  scale();
  noFill(); stroke(0); ellipse(x1, y1, r * sc, r * sc);
  fill(120); text("x1: " + nfc((x1 / sc), 2) + "   y1: " + nfc((y1 / sc), 2) + "   r: " + nfc(r / 2, 2), 5, h * sc - 5);
  text("Space key for change mode Standart <> accuDraw", 34, 14);
  text("Up-Down for change radius and Мouse for drag", 34, 29);
  
}

/////////////////////////
void mousePressed() { mx = x1 - mouseX; my = y1 - mouseY; }

void mouseDragged() { x1 = mouseX + mx; y1 = mouseY + my; }

void keyReleased()
{ 
  if (keyCode == UP) r += 0.5; 
  if (keyCode == DOWN) r -= 0.5; 
  r = constrain(r, 3, 12);
  if (keyCode == ' ') ad = 1 - ad;
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