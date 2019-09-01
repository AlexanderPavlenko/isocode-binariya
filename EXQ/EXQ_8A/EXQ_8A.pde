void setup() { size(800, 800); noLoop(); noStroke(); background(255); }

void draw()
{   
  float p = 2 * PI,     // полный оборот: 360 градусов = 2 * PI радиан
        h = p / 2,      // половина полного оборота  
        r = 250,        // радиус большого круга
        rm = 20,        // стартовый радиус для маленьких кругов
        cx = width / 2, cy = height / 2, a;

  fill(225); circ(cx, cy, r); fill(155);

  for (a = 0; a < p; a += h / 2) circ(cx - r * cos(a), cy + r * sin(a), rm);  
  rm *= 0.5;

  for (a = h / 4; a < p; a += h / 2) circ(cx - r * cos(a), cy + r * sin(a), rm);  
  rm *= 0.5;

  for (a = h / 8; a < p; a += h / 4) circ(cx - r * cos(a), cy + r * sin(a), rm);  
  rm *= 0.5;

  for (a = h / 16; a < p; a += h / 8) circ(cx - r * cos(a), cy + r * sin(a), rm);  
}

void circ(float x, float y, float r) { ellipse(x, y, r * 2, r * 2); }

