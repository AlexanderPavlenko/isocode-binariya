//// глобальные переменные ///////////////////////////////////////////////////
int m = 10, s = 3; 

//// общие параметры и начальные установки ///////////////////////////////////
void setup()
{ 
  size(1200, 400); stroke(75, 0, 0); background(0,0,0);
  frameRate(30);
}

//// рисование с установленной frameRate(...) частотой ///////////////////////
void draw()
{ 
  if (mousePressed)
  { fill(0, 0, 0, 5); noStroke(); rect(0, 0, width, height); stroke(75, 0, 0); // так стираем экран, по чу-чуть, постепенно      
    float r, d = m + 1.5 * dist(pmouseX, pmouseY, mouseX, mouseY);
    d = d * 0.5 + random(d * 0.75);
    r = 0.05 + random(d * 0.2);
    fill(185 + random(70), 75 + random(50), 55 + random(25));  
    ellipse(mouseX, mouseY, d, d);
    fill(255, 255, 255); 
    for (int i = 0; i < s; i++) ellipse(mouseX + random(-d, d), mouseY + random(-d, d), r, r);
  }
}

