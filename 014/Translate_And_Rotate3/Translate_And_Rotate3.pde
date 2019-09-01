float a = 0;

void setup()
{ 
  size(800, 800); frameRate(30); rectMode(CENTER); strokeWeight(5);
}

void draw()
{
  background(0); 
  translate(400, 400); rotate(a);
  fill(200); stroke(255); drawRect(0, 0, 50, 50);
  fill(225, 100, 0); stroke(255, 155, 0); usic(100, 0);
  fill(150, 0, 50); stroke(200, 0, 100); usic(-100, 0);
  fill(125, 185, 0); stroke(155, 225, 0); usic(0, 100);
  fill(0, 135, 200); stroke(0, 175, 255); usic(0, -100);
  a -= 0.025;
} 

void usic(float x, float y)
{
  pushMatrix();
  for (int i = 0; i < 30; i++)
  { scale(0.9); translate(x, y); rotate(a);
    drawRect(0, 0, 50, 50);
  }
  popMatrix();
}
