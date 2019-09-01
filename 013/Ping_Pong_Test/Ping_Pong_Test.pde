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
    if (x - r < G || x + r > resX - G) dx = -dx;
    if (y - r < G || y + r > resY - G) dy = -dy;
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
  fill(10, 35, 50, 40);                                          // плавно стираем бордюр, 
  rect (0, 0, resX, G); rect (0, resY - G, resX, resY);          // так, что бы не затронуть
  rect (0, G, G, resY - G); rect (resX - G, G, resX, resY - G);  // поле для мячика   
  fill(0); rect (G, G, resX - G, resY - G);                      // а это как раза поле  
  b1.regenerate();                                               // а это мячик 
}