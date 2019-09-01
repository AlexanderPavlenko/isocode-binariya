void setup() { size(400, 400); background(0,0,0); noStroke(); fill(0, 175, 255); noLoop(); }
void draw()  
{   
  beginShape(); vertex(0, height);
  for (int x = 4; x <= width; x += 4) vertex(x, height * (1 - hermit((float)x / width)));
  vertex(width, height); endShape(CLOSE);
}                                       
float hermit(float x) { return 3 * x * x - 2 * x * x * x; }
float low(float t, float l) { l = 1 - t * l; return 1 - (1 - t) / l; }

