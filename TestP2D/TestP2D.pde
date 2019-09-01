int w = 320, h = 320;
float px = w / 2, py = h / 2; 

void setup() { size(w, h, P2D); smooth(8); rectMode(CENTER); noLoop(); }

//// Test //////////////
void draw()
{ 
  background(255); 
  noStroke(); fill(0);
  rect(px, py, 200, 100); rect(px, py, 100, 200);
  ellipse(px - 50, py - 50, 100, 100); ellipse(px + 50, py - 50, 100, 100);
  ellipse(px - 50, py + 50, 100, 100); ellipse(px + 50, py + 50, 100, 100);
  fill(255);
  rect(px, py, 100, 100, 25);
  stroke(255); strokeWeight(1);
  line(px - 64, py - 20, px - 64, py + 20);
  line(px + 64, py - 20, px + 64, py + 20);
  line(px - 20, py - 64, px + 20, py - 64);
  line(px - 20, py + 64, px + 20, py + 64);
  strokeWeight(2);
  line(px - 57, py - 25, px - 57, py + 25);
  line(px + 57, py - 25, px + 57, py + 25);
  line(px - 25, py - 57, px + 25, py - 57);
  line(px - 25, py + 57, px + 25, py + 57);

  fill(120); text("двигаем стрелками, x:" + px + "  y:" + py, 5, h - 5);
}

////////////////////////
void keyReleased()
{
  if (keyCode == LEFT) if (px > 1) px -= 0.25;
  if (keyCode == RIGHT) if (px < w - 4) px += 0.25; 
  if (keyCode == UP) if (py > 1) py -= 0.25;
  if (keyCode == DOWN) if (py < h - 3) py += 0.25; 
  redraw();  
}

