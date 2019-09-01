void setup() { size(800, 800); noLoop(); noStroke(); background(255); }

void draw()
{   
  float p = 2 * PI,     
        h = p / 2,        
        r = 250,        
        rm = 20,        
        cx = width / 2, cy = height / 2, a, as, aa;

  fill(225); circ(cx, cy, r); fill(155);

  aa = 0; as = h / 2;     // эти переменные и...
  for (int i = 0; i < 4; i++)
  { for (a = aa; a < p; a += as) circ(cx - r * cos(a), cy + r * sin(a), rm);
    if (i == 0) { aa = h / 4; as = h / 2;   // ... и это условие, как раз и позволяют
                } else { aa /= 2; as /= 2;  // "обрулить" то, что первый цикл из прошлого  
                       }                    // примера, был не совсем подобен
    rm *= 0.5;                              // трем остальным циклам
  }  
}

void circ(float x, float y, float r) { ellipse(x, y, r * 2, r * 2); }

