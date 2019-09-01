void setup() { size(400, 400); noLoop(); noStroke(); background(255); }

void draw()
{
  translate(80, 50); rotate(PI / 25);
  drawXY(200, color(100)); 
  fill(255, 155, 0); drawCirc(100, 100, 50);

  translate(200, 200); rotate(PI / 15); scale(0.5);
  drawXY(200, color(100));  
  fill(155, 215, 0); drawCirc(100, 100, 50);
}
 
