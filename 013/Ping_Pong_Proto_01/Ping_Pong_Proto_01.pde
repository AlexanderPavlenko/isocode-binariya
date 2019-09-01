//////////////// Ping Pong прототип

//////////////// общие параметры 
int resX = 640, resY = 480;                    // размер изображения
float D = 7, rampD = 8;                        // общее приращения перемещения и шаг разгона тележек

///////////////// Объекты
class c_ball   // Мячик
{
  float x, y, dx, dy, r;                       // положение, приращения, радиус 

  c_ball(float rr)                             // конструктор объекта - инициализация начальных параметров
  { 
    x = resX / 2; y = resY / 2; dx = D; dy = D; r = rr;
  }                               
  void regenerate()                            // перемещение и отрисовка  
  {                                               
    x += dx; y += dy;                          
    if (x - r < 0 || x + r > resX) dx = -dx;
    if (y - r < 0 || y + r > resY) dy = -dy;
    fill(0, 155, 255); ellipse(x, y, r * 2, r * 2); 
  }  
}

class c_ramp   // Тележка
{
  float x, y, w, t;                            // положение, ширина, толщина

  c_ramp(int xx, int ww, int tt)               // конструктор объекта - инициализация начальных параметров
  { 
    x = xx; y = resY / 2; w = ww; t = tt;
  } 
  void regenerate(float d)                     // перемещение и отрисовка 
  {                                            
    y = constrain(y + d, 0, resY);             
    fill(255, 125, 0); rect(x, y, t, w, 5);    
  }
}

////////////////// создаём
c_ball b1 = new c_ball(30);
c_ramp r1 = new c_ramp(20, 110, 20), r2 = new c_ramp(resX - 20, 110, 20);

////////////////// опрос клавиатуры
float d1, d2;

void keyPressed()
{
  if (keyCode == 'A') d1 = -rampD;
  if (keyCode == 'Z') d1 = rampD;
  if (keyCode == UP) d2 = -rampD; 
  if (keyCode == DOWN) d2 = rampD;
}

void keyReleased()
{
  if (keyCode == 'A') d1 = 0;
  if (keyCode == 'Z') d1 = 0;
  if (keyCode == UP) d2 = 0; 
  if (keyCode == DOWN) d2 = 0;
}

//////////////// Инициализация и цикл рисования
void settings() { size(resX, resY); }

void setup() { noStroke(); frameRate(30); rectMode(CENTER); }

void draw()
{
  background(0);
  b1.regenerate();
  r1.regenerate(d1); r2.regenerate(d2);
}