///////////////////////////////////////////////////////////////////////////////////
float fq = 1.25;
color c = color(175, 125, 135);

void setup() { size(1200, 500); noLoop(); }
 
void draw()
{
  color cb = color(red(c) * 0.7, green(c) * 0.7, blue(c) * 0.7),
        cf = color(red(c) * 0.15, green(c) * 0.15, blue(c) * 0.15);
  background(cb); 
  noStroke(); fill(c); ellipse(width * 0.7, height * 0.45, height * 0.5, height * 0.5);
  layer_ae(0.25, lerpColor(cb, cf, 0.15), 50, 8); 
  layer_ae(0.5, lerpColor(cb, cf, 0.5), 40, 10); 
  layer_ae(1.0, cf, 20, 12); 
}

void keyPressed() { redraw(); }
void mousePressed() { redraw(); }

///////////////////////////////////////////////////////////////////////////////////
void layer(float sz, color c, int g, int d)
{  
  g = height - g; noStroke(); fill(c); rect(0, g, width, height); stroke(c);
  float x = random(80 * sz, 240 * sz) / fq;
  while (x < width) { tree(x, g, random(sz * 0.75, sz * 1.25), 0.3, 0.1, d);  x += random(80 * sz, 240 * sz) / fq; }
}

///////////////////////////////////////////////////////////////////////////////////
void layer_ae(float sz, color c, int g, int d)
{  
  g = height - g; noStroke(); fill(c); 
  beginShape();
  vertex(0, height);
  float t = random(-PI, PI), tt;
  for (int x = 0; x <= width; x++)
  { vertex(x, tt = g + sz * (random(-3, 3) + 4 * sin(t + x * 0.015 / sz)));
    if (random(1.0) < (0.01 / sz)) {  float r = sz * random(10, 30); ellipse(x, tt + 3 * sz, r, r * 0.66); }  
  }
  vertex(width, height);
  endShape(CLOSE);
  stroke(c);
  float x = random(80 * sz, 240 * sz) / fq;
  while (x < width) { tree(x, g, random(sz * 0.75, sz * 1.25), 0.3, 0.1, d); x += random(80 * sz, 240 * sz) / fq; }
}

///////////////////////////////////////////////////////////////////////////////////
void tree(float x, float y, float sz, float rb, float rj, int d)
{
  pushMatrix(); translate(x, y + 10 * sz); rotate(random(-0.1, 0.1)); branch(sz, rb, rj, d); popMatrix();
}

///////////////////////////////////////////////////////////////////////////////////
void branch(float sz, float b, float j, int d)
{
  strokeWeight(12 * sz);
  if (d > 0)
  { line(0, 0, 0, -height * 0.15 * sz);
    translate(0, -height * 0.15 * sz);
    rotate(random(-0.1, 0.1)); 
    if (random(1.0) < 0.6)
    { scale(0.75);
      pushMatrix(); rotate(random(b - j, b + j)); branch(sz, b, j, d - 1); popMatrix();    
      pushMatrix(); rotate(random(-b - j, -b + j)); branch(sz, b, j, d - 1); popMatrix();        
    } else { scale(0.9); branch(sz, b, j, d); }
  }
}

