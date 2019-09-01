int n = 0, t = 90;
boolean auto = true;

float x1, y1, dx1 = 0.811, dy1 = -0.771, r = 70,
      x2, y2, dx2 = 0.125, dy2 = 0.125, d2 = 0, dd2 = 0.25, 
      x3, y3, dx3 = -0.0625, dy3 = -0.0625, d = 50,
      x4, y4, dx4 = -0.917, dy4 = -0.663, w = 50, a = 0, da = 0.003125,
      x5, y5, dx5 = -0.712, dy5 = 0.407;

void setup()
{ 
  //size(320, 320, P2D); smooth(8);
  size(320, 320);
  frameRate(30); 
  x1 = random(r, width - r); y1 = random(r, height - r);
  x2 = (int)random(d, width - d); y2 = (int)random(d, height - d);
  x3 = (int)random(d, width - d); y3 = (int)random(d, height - d);
  x4 = (int)random(d, width - w); y4 = (int)random(d, height - w);
  x5 = (int)random(d, width - w); y5 = (int)random(d, height - w);
}

void draw()
{
  background(35);
  noStroke(); strokeCap(SQUARE); ellipseMode(RADIUS);
  if (auto && (t != 0)) { t--; if (t == 0) { t = 90; n = 1 - n; }; }
  
  pushStyle();
  stroke(145, 155, 115);
  if (n == 1) { drawLine(2.5, y2 - d2, width - 3.5, y2 + d2); drawLine(x2 - d2, 2.5, x2 + d2, height - 3.5); }
  else { line(2.5, y2 - d2, width - 2.5, y2 + d2); line(x2 - d2, 2.5, x2 + d2, height - 2.5); }
  if ((d2 < -10.1) || (d2 > 10.1)) dd2 = -dd2;
  d2 += dd2;
  if (((x2 + d) > width) || ((x2 - d) < 0)) dx2 = - dx2; 
  if (((y2 + d) > height) || ((y2 - d) < 0)) dy2 = - dy2; 
  x2 += dx2; y2 += dy2;

  stroke(200);
  if (n == 1) { drawLine(1, y3, width - 2, y3); drawLine(x3, 1, x3, height - 2); } else { line(0, y3, width, y3); line(x3, 0, x3, height); }
  if (((x3 + d) > width) || ((x3 - d) < 0)) dx3 = - dx3; 
  if (((y3 + d) > height) || ((y3 - d) < 0)) dy3 = - dy3; 
  x3 += dx3; y3 += dy3;

  stroke(0);
  for (int i = 0; i < 25; i++)
  { fill(195 - (i & 1) * 50 + i * 2, 205 - (i & 1) * 40 + i * 2, 175 - (i & 1) * 60 + i * 2);
    if (n == 1) drawCirc(x1, y1, (r - i * 2.71)); else ellipse(x1 + 0, y1 + 0, r - i * 2.71, r - i * 2.71);
  } 
  if (((x1 + r) > width) || ((x1 - r) < 0)) dx1 = - dx1; 
  if (((y1 + r) > height) || ((y1 - r) < 0)) dy1 = - dy1; 
  x1 += dx1; y1 += dy1;
  
  stroke(255); rectMode(CENTER);
  fill(255, 135, 0); strokeWeight(3); 
  if ((a < -0.075) || (a > 0.075)) da = -da;
  a += da; if (abs(a) < 0.001) a = 0;
  pushMatrix();
  translate(x4, y4);
  if (abs(a) < 0.001) a = 0; else rotate(a);
  if (n == 1) drawRect(0, 0, 1.5 * w, w, 0.25 * w); else rect(0, 0, 1.5 * w, w, 0.25 * w);
  popMatrix();
  if (((x4 + w) > width) || ((x4 - w) < 0)) dx4 = - dx4; 
  if (((y4 + w) > height) || ((y4 - w) < 0)) dy4 = - dy4; 
  x4 += dx4; y4 += dy4;

  fill(200, 75, 0);
  if (n == 1) drawRect(x5, y5, 0.75 * w, 0.75 * w); else rect(x5, y5, 0.75 * w, 0.75 * w);
  if (((x5 + w) > width) || ((x5 - w) < 0)) dx5 = - dx5; 
  if (((y5 + w) > height) || ((y5 - w) < 0)) dy5 = - dy5; 
  x5 += dx5; y5 += dy5;
  
  stroke(255); strokeWeight(15); strokeCap(ROUND);
  if (n == 1) drawLine(y4, x4, y5, x5); else line(y4, x4, y5, x5);
  
  popStyle();
  fill(35, 155); rect(0, height - 20, width, 20);
  if (n == 1) 
  { fill(0, 215, 255); text("Accurate Draw functions now", 5, height - 5);
  } else { fill(0, 155, 195); text("Standart Draw functions now", 5, height - 5); }   
  fill(255, 155, 0); text("press Enter for change", width - 135, height - 5);
  
}  

void keyPressed() {  if (keyCode == ENTER) { n = 1 - n; auto = false; }; }
