int w = 16, h = 10;

void settings() { size(w, h); } 

void setup() { noStroke(); background(255, 255, 255); noLoop(); }

void draw()
{
  fill(255, 155, 0);
  ellipse(0, 0, 5, 5);
  ellipse(w, h, 5, 5);
  ellipse(w / 2 - 3, h / 2, 5, 5);
  fill(0, 155, 255);
  ellipse(w / 2 + 3 + 0.5, h / 2 + 0.5, 5, 5);

  stroke(100, 0, 0);
  point(0, 0);
  point(w / 2 - 3, h / 2);
  point(w - 1, h - 1);
  stroke(0, 0, 100);
  point(w / 2 + 3, h / 2);
}  