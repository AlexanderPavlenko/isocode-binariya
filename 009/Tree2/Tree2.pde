float rb = 0.3, rj = 0.1;

void setup() { size(700, 700); noLoop(); }
 
void draw()
{
  background(121, 135, 110);
  noStroke();
  fill(15, 20, 10); rect(0, height - 40, width, height);
  fill(145, 157, 135); ellipse(width * 0.65, height * 0.45, height * 0.5, height * 0.5);
  stroke(15, 20, 10); 
  translate(width / 2, height); strokeWeight(12); branch(12);
}

void mouseReleased() { redraw(); }
 
void branch(int d)
{
  if (d > 0)
  { line(0, 0, 0, -height * 0.15);
    translate(0, -height * 0.15);
    rotate(random(-0.1, 0.1)); 
    if (random(1.0) < 0.6)
    { scale(0.75);
      pushMatrix(); rotate(random(rb - rj, rb + rj)); branch(d - 1); popMatrix();    
      pushMatrix(); rotate(random(-rb - rj, -rb + rj)); branch(d - 1); popMatrix();        
    } else { scale(0.9); branch(d); }
  }
}
 
 
 
