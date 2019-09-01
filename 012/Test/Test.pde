int w = 16, h = 10, sc = 32;

void settings() { size(w * sc, h * sc); }
void setup() { noStroke(); background(255, 255, 255); noLoop(); }

void draw()
{
  //// Test //////////////
  fill(255, 155, 0);
  ellipse(0, 0, 5, 5);
  ellipse(w, h, 5, 5);
  ellipse(w / 2 - 3, h / 2, 5, 5);
  fill(0, 155, 255);
  ellipse(w / 2 + 3 + 0.5, h / 2 + 0.5, 5, 5);

  stroke(100, 0, 0);
  point(0, 0);
  point(w / 2 - 3, h / 2);
  point(w - 1, h - 1);
  stroke(0, 0, 100);
  point(w / 2 + 3, h / 2);

  //// Scale //////////////
  loadPixels(); noStroke();
  for (int y = 0; y < h; y++) 
  for (int x = 0; x < w; x++) { fill(pixels[y * (w * sc) + x]); rect(x * sc, y * sc, sc, sc); }
  fill(255, 255, 255);  
  for (int y = 0; y <= h; y++)
  for (int x = 0; x <= w; x++)
  { rect(x * sc - 1, y * sc - sc / 4, 2, sc / 2); rect(x * sc - sc / 4, y * sc - 1, sc / 2, 2);
    rect(x * sc - 2, y * sc - 2, 4, 4);
  }
}  