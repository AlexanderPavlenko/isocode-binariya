/////////////////////////////////////////////////////////////////////////////
int m = 10, s = 5, px, py; 

/////////////////////////////////////////////////////////////////////////////
void setup()
{ 
  size(1200, 400);
  stroke(75, 0, 0); strokeWeight(1.25);
  background(0,0,0);
  frameRate(30);
  noLoop();
}

/////////////////////////////////////////////////////////////////////////////
void draw()
{ 
  fill(0, 0, 0, 5); noStroke(); rect(0, 0, width, height); stroke(75, 0, 0);     
  float r, d = m + 1.75 * dist(px, py, mouseX, mouseY), d2 = d / 2;
  for (int i = 0; i < s; i++)
  { d = d * 0.5 + random(d * 0.75); r = 0.5 + random(d * 0.25);
    fill(125 + random(130), 35 + random(50), 55 + random(25));
    ellipse(mouseX + random(-d2, d2), mouseY + random(-d2, d2), d, d);
    fill(255, 255, 255);
    ellipse(mouseX + random(-d, d), mouseY + random(-d, d), r, r);
  }  
  px = mouseX; py = mouseY; 
}

/////////////////////////////////////////////////////////////////////////////
void mousePressed() { px = mouseX; py = mouseY; loop(); }
void mouseReleased() { noLoop(); }

