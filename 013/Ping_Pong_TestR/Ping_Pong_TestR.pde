//////////////// Ping Pong прототип

//////////////// общие параметры 
int resX = 640, resY = 480;   // размер изображения
float G = 40;                 // граница

///////////////// Объекты
class c_ball   // Мячик
{
  float x, y, dx, dy, r;                       // положение, приращения, радиус 

  c_ball(float rr)                             // конструктор объекта - инициализация начальных параметров
  { 
    x = resX / 2; y = resY / 2; dx = 12.137; dy = 10.538; r = rr;
  }                               
  void regenerate()                            // перемещение и отрисовка  
  {                                               
    x += dx; y += dy;      
    float d = (x - r) - G;
    if (d < 0)
    { x -= 2 * d; dx = -dx;
    } else { d = (x + r) - (resX - G);
             if (d > 0) { x -= 2 * d; dx = -dx; }
           }  
    d = (y - r) - G;
    if (d < 0)
    { y -= 2 * d; dy = -dy;
    } else { d = (y + r) - (resY - G);
             if (d > 0) { y -= 2 * d; dy = -dy; }
           }         
    fill(0, 155, 255); ellipse(x, y, r * 2, r * 2); 
  }  
}

////////////////// создаём
c_ball b1 = new c_ball(30);

//////////////// Инициализация и цикл рисования
void settings() { size(resX, resY); }

void setup() { noStroke(); frameRate(30); rectMode(CORNERS); background(10, 35, 50); } 

void draw()
{
  fill(0); rect (G, G, resX - G, resY - G);                        
  b1.regenerate();                                                
}