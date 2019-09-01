int w = 6, h = 4, sc = 64;

void settings() { size(w * sc, h * sc); } 

void setup() { background(255, 255, 255); noLoop(); }

void draw()
{ //// Test //////////////
  //noSmooth();
  strokeWeight(5); stroke(185, 205, 0); 
  line(-1, 2, 6, 6);

  //// Scale //////////////
  loadPixels();
  for (int y = 0; y < h * sc; y++) 
  for (int x = 0; x < w * sc; x++) set(x, y, pixels[y / sc * (w * sc) + x / sc]);
  noStroke(); fill(255, 255, 255);  
  for (int y = 0; y <= h; y++)
  for (int x = 0; x <= w; x++)
  { rect(x * sc - 1, y * sc - sc / 4, 2, sc / 2); rect(x * sc - sc / 4, y * sc - 1, sc / 2, 2);
    rect(x * sc - 2, y * sc - 2, 4, 4);
  }
}  