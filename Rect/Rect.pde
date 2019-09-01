int w = 12, h = 8, sc = 32, scs = 4;

size(w * sc, h * sc); noStroke(); background(255, 255, 255);

//// Test //////////////
fill(0, 55, 100);
rect(1.5, 1.5, w - 3, h - 3);

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
fill(185, 185, 185); rect(2, 2, w * scs + 4, h * scs + 4);
for (int y = 0; y < h * scs; y++) 
for (int x = 0; x < w * scs; x++) set(4 + x, 4 + y, pixels[y / scs * (w * sc) + x / scs]);

