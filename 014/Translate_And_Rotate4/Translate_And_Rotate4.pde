float aa = 0, a = 0;

void setup()
{ 
  size(700, 700); frameRate(30); rectMode(CENTER); strokeWeight(5);
}

void draw()
{
  background(0); 
  translate(350, 350); rotate(aa);
  if (focused) a = 0.7 * (mouseX - width / 2) / width;

  pushMatrix();
    fill(0, 135, 200); stroke(0, 175, 255); usic(25, 0, 15);
    pushMatrix();
      usic(25, 0, 40);
    popMatrix();
    pushMatrix();
      usic(-25, 0, 40);
    popMatrix();
  popMatrix();

  pushMatrix();
    fill(225, 100, 0); stroke(255, 155, 0); usic(0, 25, 15);
    pushMatrix();
      usic(0, 25, 40);
    popMatrix();
    pushMatrix();
      usic(0, -25, 40);
    popMatrix();
  popMatrix();

  pushMatrix();
    fill(150, 0, 50); stroke(200, 0, 100); usic(-25, 0, 15);
    pushMatrix();
      usic(25, 0, 40);
    popMatrix();
    pushMatrix();
      usic(-25, 0, 40);
    popMatrix();
  popMatrix();

  pushMatrix();
    fill(125, 185, 0); stroke(155, 225, 0); usic(0, -25, 15);
    pushMatrix();
      usic(0, 25, 40);
    popMatrix();
    pushMatrix();
      usic(0, -25, 40);
    popMatrix();
  popMatrix();
  
  aa -= 0.0125;
} 

void usic(float x, float y, int c)
{
  for (int i = 0; i < c; i++)
  { scale(0.94); translate(x, y); rotate(a);
    pushStyle();
      fill(0, 65); strokeWeight(2); drawCirc(0, 0, 75);
    popStyle();
    drawCirc(0, 0, 50);
  }
}
