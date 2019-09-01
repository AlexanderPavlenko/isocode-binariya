///////////////////////////////////
int push = 0;

class spring_ball
{
  float cx, cy, px, py, vx, vy, f;
  spring_ball(float x, float y, float fo) { cx = px = x; cy = py = y; vx = vy = 0; f = fo; }
  void regenerate(boolean p, float di, float s)
  {
    if (p) { float x = px - mouseX, y = py - mouseY, d = sqrt(x * x + y * y);
             if (d < di) { float t = (1 - d / di) / d * s; vx += x * t; vy += y * t; }
           }
    vx += (cx - px) * 0.025; vy += (cy - py) * 0.025;       
    px += vx; py += vy;
    vx *= f; vy *= f;
  }
  void repaint(color c, float r)
  {
    strokeWeight(8);
    stroke(255, 255, 255); noFill(); line(cx, cy, px, py);
    float d = 2 * dist(px, py, cx, cy);
    strokeWeight(1.5); ellipse(cx, cy, d, d);
    noStroke(); fill(255); ellipse(cx, cy, 25, 25); ellipse(px, py, r, r);
    fill(c); ellipse(px, py, r - 20, r - 20);
    fill(red(c) * 1.25, green(c) * 1.25, blue(c) * 1.25); ellipse(px, py, r * 0.5, r * 0.5);
  }
}
spring_ball sb;

///////////////////////////////////
void setup()
{ 
  size(640, 640); frameRate(30);
  sb = new spring_ball(width / 2, height / 2, 0.95); 
}

///////////////////////////////////
void draw()
{   
  background(255, 165, 95);
  if (mousePressed && (push == 0)) push = 10;
  sb.regenerate((push == 10), width, 70);
  if (push > 0) { noFill(); stroke(255, 255, 255); strokeWeight(push * 1.5);
                  float p = (15 - push) * 1.25;
                  p *= p; ellipse(mouseX, mouseY, p, p); push--;
                }
  sb.repaint(color(165, 65, 55), 150);
}
