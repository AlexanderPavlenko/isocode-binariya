/////////////////////////////////////////////// все о шариках
int count = 100;
float[] r, x, y, dx, dy;
color[] c;

void define(int i)
{
  r[i] = random(20, 55); 
  x[i] = random(r[i], width - r[i]); y[i] = random(r[i], height - r[i]);
  dx[i] = random(3, 5) * zrandom(); dy[i] = random(3, 5) * zrandom();
  c[i] = color(irandom(55, 255), irandom(50, 150), 0);
}

void drawing(int i)
{
  x[i] += dx[i]; y[i] += dy[i];
  if ((x[i] > (width - r[i])) || (x[i] < r[i])) dx[i] = - dx[i];
  if ((y[i] > (height - r[i])) || (y[i] < r[i])) dy[i] = - dy[i];  
  circle(x[i], y[i], r[i], c[i]);
  circle(x[i], y[i], r[i] * 0.75, color(red(c[i]) - 15, green(c[i]) - 20, 0));
}

/////////////////////////////////////////////// обязательные функции
void setup()
{ 
  size(640, 480); smooth(); noStroke(); frameRate(25);
  x = new float[count]; y = new float[count]; r = new float[count];
  dx = new float[count]; dy = new float[count]; c = new color[count];
  for (int i = 0; i < count; i++) define(i);
}

void draw()
{   
  background(0, 0, 0);
  for (int i = 0; i < count; i++) drawing(i);
}

/////////////////////////////////////////////// вспомогательные функции
int irandom(int m) { return (int)(random(m) + 0.5); }
int irandom(int mn, int mx) { return (int)(random(mn, mx) + 0.5); }
int zrandom() { return 1 - 2 * irandom(1); }

void circle(float x, float y, float r, color c) { fill(c); ellipse(x, y, r * 2, r * 2); }
