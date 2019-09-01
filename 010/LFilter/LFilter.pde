//////////////////////////////////////////////////////
float scale = 0.0075, offs = 0;

//////////////////////////////////////////////////////
class c_noise
{
  float[] ns;
  int dm; 
  c_noise(int d) { ns = new float[dm = d]; for (int i = 0; i < d; i++) ns[i] = random(1.0); }
  float get(float t)
  {
    if (t < 0) t = dm + t % dm; else t = t % dm; 
    int i1 = (int)t, i2 = (i1 + 1) % dm; 
    return ns[i1] + (ns[i2] - ns[i1]) * (t - i1);
  }
}
c_noise ns;

//////////////////////////////////////////////////////
void setup()
{ 
  size(1200, 160); smooth(); frameRate (30); noStroke(); fill(255, 145, 0); 
  ns = new c_noise(100);
}

void draw()
{   
  background(0, 0, 0); offs += 0.1; 
  beginShape(); vertex (0, height);
  for (int x = 0; x <= width; x += 2) vertex (x, height - height * 0.9 * ns.get(x * scale + offs));
  vertex (width, height); endShape(CLOSE);  
}


