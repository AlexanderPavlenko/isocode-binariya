int w = 14, h = 11, d = 3, sc = 32, scs = 4, s = 0;

void settings() { size(w * sc, h * sc); } 

void setup() { noLoop(); }

//// Test //////////////
void draw()
{  
  background(255);
  noStroke(); fill(255, 135, 0);
  ellipse(d, d, 3, 3);
  ellipse(w - d, d, 3, 3);
  ellipse(d, h - d, 3, 3);
  ellipse(w - d, h - d, 3, 3);
  switch(s)
  { case 1: fill(0, 55, 100); rect(d, d, w - 2 * d, h - 2 * d); break;
    case 2: fill(0, 125, 175); beginShape();
            vertex(d, d); vertex(d, h - d); vertex(w - d, h - d); vertex(w - d, d);
            endShape(CLOSE); break;
    case 3: noFill(); stroke(0); rect(d, d, w - 2 * d, h - 2 * d); break;
    case 4: noFill(); stroke(55); beginShape();
            vertex(d, d); vertex(d, h - d); vertex(w - d, h - d); vertex(w - d, d);
            endShape(CLOSE); break;
  }
  scale();
  fill(120);
  switch(s)
  { case 0: text("only circles", 5, h * sc - 5); break;
    case 1: text("noStroke(); fill(...); rect(...)", 5, h * sc - 5); break;
    case 2: text("beginShape(...); vertex(...);  ...; endShape(...);", 5, h * sc - 5); break;
    case 3: text("noFill(...); stroke(...); rect(...);", 5, h * sc - 5); break;
    case 4: text("noFill(...); stroke(...); beginShape(...); vertex(...); ...; endShape(...);", 5, h * sc - 5); break;
  }
}

////////////////////////
void keyReleased()
{
  if (keyCode == ENTER) s = (s + 1) % 3;
  if (keyCode == BACKSPACE) if (s == 3) s = 4; else s = 3;
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