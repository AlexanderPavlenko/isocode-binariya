///////////////////////////////////////
int sx = 1000, sy = 280, b = 40, sxl = sy + b, sxl2 = sxl / 2, s = 10, sy2 = sy / 2, sy2b = sy2 - b, sxb = sx - b, sxw = sx - sxl - b;
float a = 0, ads = 2*PI / 360, ad = ads, sa = 2*PI / (sxw / s), r = sy / 2 - b;
PFont font;

///////////////////////////////////////
void setup()                            
{ 
  size(sx, sy); frameRate(30);
  font = createFont("Consolas", 11); textFont(font);
}

///////////////////////////////////////
void draw()                             
{   
  float xr, yr, ysin, ps = 0, ycos, pc = 0, ang = a;
  noStroke(); background(0);            
  
  strokeWeight(1); fill(150); textSize(11); textAlign(LEFT, CENTER);
  int ti = (int)(a / (PI / 2));
  float t = sxw * (PI/2 - a %(PI/2)) / (2 * PI);
  for (int i = 0; i < 4; i++)
  { float x;
    stroke(55); line(x = sxl + t + i * sxw / 4, sy2 - sy2b, x, sy2 + sy2b);
    stroke(70); line(x, sy2 - sy2b - 4, x, sy2 - sy2b - 8);
    switch((ti + i) % 4)
    { case 0: text("PI/2", x - 2, sy2 - sy2b - 16); break;
      case 1: text("PI", x - 2, sy2 - sy2b - 16); break;
      case 2: text("3*PI/2", x - 2, sy2 - sy2b - 16); break;
      case 3: text("0(2*PI)", x - 2, sy2 - sy2b - 16);
    }
  }
  stroke(70); noFill(); 
  line(sxl, sy2, sxb, sy2); rectMode(CORNERS); rect(sxl, sy2 - sy2b, sxb, sy2 + sy2b);
  line(sxl - 8, sy2 - sy2b, sxl - 4, sy2 - sy2b);
  line(sxl - 8, sy2 + sy2b, sxl - 4, sy2 + sy2b);
  line(sxl, sy2 + sy2b + 4, sxl, sy2 + sy2b + 8);
  ellipse(sxl2, sy2, sy - b * 2, sy - b * 2);

  xr = r * cos(a); yr = r * sin(a);
  noStroke(); fill(70); ellipse(sxl2 + xr, sy2 - yr, 15, 15); 
  strokeWeight(2); stroke(0, 155, 255); line(sxl2 + xr, sy2, sxl2 + xr, sy2 - yr);
  strokeWeight(2); stroke(70); line(sxl2 + xr, sy2 - yr, sxl, sy2 - yr);
  strokeWeight(7); stroke(125, 15, 0); line(sxl2, sy2, sxl / 2 + xr, sy2);
  strokeWeight(2); stroke(255); line(sxl2, sy2, sxl2 + xr, sy2 - yr); 
  noStroke(); fill(255); ellipse(sxl2 + xr, sy2 - yr, 10, 10);
  textSize(13); label("y", RIGHT, sxl2 + xr - 8, sy2 - yr / 2);
                label("x", CENTER, sxl2 + xr / 2, sy2 + 14);
                label("R", CENTER, sxl2 + xr / 2, sy2 - yr / 2);
  textSize(11);
  textAlign(RIGHT, CENTER); fill(255, 155, 0); text("x = R * cos(a)", sxl2 - 8, sy - b / 2);
  textAlign(LEFT, CENTER); fill(0, 155, 255); text("y = R * sin(a)", sxl2 + 8, sy - b / 2);
  
  fill(255); ellipse(sxl2, sy2, 5, 5); ellipse(sxl / 2 + xr, sy2, 5, 5);
  
  fill(150); textAlign(RIGHT, CENTER); textSize(11); 
  text("1.0", sxl - 10, sy2 - sy2b - 1);
  text("0.0", sxl - 10, sy2 - 1);
  text("-1.0", sxl - 10, sy2 + sy2b - 1);
  
  noStroke(); fill(70); ellipse(sxl, sy2, 4, 4); ellipse(sxl, sy2 - yr, 15, 15);
  for (int x = sxl; x <= sx - b; x += s)
  { ysin = sy2 - sy2b * sin(ang);
    ycos = sy2 - sy2b * cos(ang);
    noStroke(); fill(0, 155, 255); ellipse(x, ysin, 3.5, 3.5);
                fill(255, 155, 0); ellipse(x, ycos, 3.5, 3.5);
    strokeWeight(2);
    if (x != sxl)
    { stroke(0, 155, 255); line(x - s, ps, x, ysin);
      stroke(255, 155, 0); line(x - s, pc, x, ycos);
    } else { strokeWeight(7); stroke(125, 15, 0); line(sxl, sy2, sxl, ycos); strokeWeight(2); }
    ps = ysin; pc = ycos;
    ang += sa; 
  }
  noStroke(); fill(255); ellipse(sxl, sy2, 5, 5);
  textSize(13);
  ellipse(sxl, sy2 - yr, 10, 10); label("sin(a)", LEFT, sxl + 20, sy2 - yr);
  ellipse(sxl, yr = sy2 - sy2b * cos(a), 5, 5); label("cos(a)", LEFT, sxl + 20, yr);
  textAlign(LEFT, CENTER); textSize(11); fill(200);
  text("a = " + nfc(a, 2) + "(" + nfc(a / PI, 2) +" * PI) " + "Radians or " + round(a / (2*PI) * 360) + " Degrees", sxl - 3, sy - b / 2);

  a += ad; if (a > 2*PI) a -= 2*PI; 
}                                       

///////////////////////////////////////
void mouseReleased() { if (ad !=0) ad = 0; else ad = ads; }

///////////////////////////////////////
void label(String t, int al, float x, float y)
{
  pushStyle();
  rectMode(CENTER); textAlign(al, CENTER); 
  float w = textWidth(t), w2 = w / 2; 
  switch(al)
  { case RIGHT: w2 = -w2; break;
    case CENTER: w2 = 0;
  }
  noStroke(); fill(0, 0, 0, 150); rect(x + w2, y, w + 8, 16, 3);
  fill(200); text(t, x, y - 2);
  popStyle(); 
}

