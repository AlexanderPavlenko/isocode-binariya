////////////////////////////////////////////////////////
float c_x = 0, c_y = 0, f = sqrt(2) / 2, ln, r, sw = 5.0;
int deep = 12;

////////////////////////////////////////////////////////
void setup() { size(1200, 480); frameRate(25); strokeCap(ROUND); }

////////////////////////////////////////////////////////
void draw()
{
  background(175, 55, 25); 
  noStroke();
  fill(255, 115, 0); ellipse(width * 0.7, height - height / 4, height, height);
  fill(45, 5, 0, 25); rect(0, height - 45, width, height - 15);
  fill(45, 5, 0); rect(0, height - 15, width, height);
  fill(255, 100, 0); 
  stroke(45, 5, 0);
  c_x += (radians(360.0 / height * mouseX) - c_x) / 20;
  c_y += (radians(360.0 / height * mouseY) - c_y) / 20;
  ln = height * 0.5;
  translate(width * 0.3, height - ln - 15);
  strokeWeight(sw); line(0, 0, 0, ln);
  branch(ln / 2, deep);
  branchDot(ln / 2, deep);
}

////////////////////////////////////////////////////////  
void branch(float l,int n)
{
  l *= f; n -= 1;
  if (n > 0)
  { pushMatrix(); rotate(c_x);
    strokeWeight(sw * (0.2 + 0.8 * l / ln)); line(0, 0, 0, -l);
    translate(0, -l); branch(l, n);
    popMatrix();
    pushMatrix(); rotate(c_x - c_y);
    strokeWeight(sw * (0.2 + 0.8 * l / ln)); line(0, 0, 0, -l);
    translate(0, -l); branch(l, n);
    popMatrix();
  }
} 

////////////////////////////////////////////////////////
void branchDot(float l,int n)
{
  l *= f; n -= 1;
  float r = l / 3;
  if ((r > 2) && (n > 0))
  { strokeWeight(sw * (0.2 + 0.8 * l / ln)); ellipse (0, 0, r, r);
    pushMatrix(); rotate(c_x);
    translate(0, -l); branchDot(l, n);
    popMatrix();
    pushMatrix(); rotate(c_x - c_y);
    translate(0, -l); branchDot(l, n);
    popMatrix();
  }
} 
