//////////////// Ping Pong прототип

//////////////// общие параметры 
int resX = 640, resY = 480;   // размер изображения
float D = 7;                  // D - некая общая мера приращения
int hit = 0;                  // признаки соударения с левой (-1) и правой (1) тележкой. 

///////////////// переменные через которые шарик "видит" тележеки 
float L_x, L_yU, L_yD;                  // левая тележка: граница столкновения по x, границы по у
float R_x, R_yU, R_yD;                  // правая ...

///////////////// Объекты
class c_ball   // Мячик
{
  float x, y, dx, dy, r;                       // положение, приращения, радиус 

  c_ball(float rr)                             // конструктор объекта - инициализация начальных параметров
  { 
    x = resX / 2; y = resY / 2; dx = D * 1.13; dy = D * 0.933; r = rr;
  }                               
  void regenerate()                            // перемещение и отрисовка  
  {                                               
    float xr, d, px = x;
    x += dx; y += dy;                          
    if (dx < 0)
    { xr = x - r; d = xr - L_x;
      if ((y < L_yD) && (y > L_yU) && ((px - r) > L_x) && (d < 0))        // столкновение с левой тележкой?
      { x -= 2 * d; dx = -dx; hit = -1;
      } else { d = xr;
               if (d < 0) { x -= 2 * d; dx = -dx; }                       // с левой границей?
             }
    } else { xr = x + r; d = xr - R_x;
             if ((y < R_yD) && (y > R_yU) && ((px + r) < R_x) && (d > 0)) // с правой тележкой?
             { x -= 2 * d; dx = -dx; hit = 1;
             } else { d = xr - resX;
                      if (d > 0) { x -= 2 * d; dx = -dx; }                // с правой границей?
                    }
           }              
    if (dy < 0)
    { d = y - r;
      if (d < 0) { y -= 2 * d; dy = -dy; }
    } else { d = y + r - resY;
             if (d > 0) { y -= 2 * d; dy = -dy; }
           }
    fill(0, 155, 255); ellipse(x, y, r * 2, r * 2); 
  }  
}

class c_ramp                                     // Тележка
{
  float x, y, dy, dfy, xH,                       // положение, приращение, коэфф. затухания, смешение при ударе
  w, t;                                          // ширина, толщина
  int side;                                      // признак левой (-1) или правой (1) тележки 

  c_ramp(int xx, int ww, int tt, int sd)         // конструктор объекта - инициализация начальных параметров
  { 
    x = xx; y = resY / 2; dy = 0; dfy = 0.9; w = ww; t = tt; side = sd;
  }                                               // заносим положение границ тележки как для расположенной на поле слева или справа
  void setL() { L_yU = y - w / 2 - t / 4; L_yD = y + w / 2 + t / 4; L_x = x + t / 2; }
  void setR() { R_yU = y - w / 2 - t / 4; R_yD = y + w / 2 + t / 4; R_x = x - t / 2; }
  void regenerate(float d)                       // перемещение и отрисовка 
  {                                            
    dy = constrain(dy + d, -D * 1.5, D * 1.5);           // d – теперь фактически ускорение 
    if (y < 0) dy += D * 0.5; else if (y > resY) dy -= D * 0.5; // а тут "выталкиваем" тележку когда она уезжает за край экрана сверху или снизу
    y += dy; dy *= dfy;                          // "приращаем", а само приращение "затухаем"                        
    if (side == hit) {xH = side * 5; hit = 0; }  // если был удар - тележка вздрагивает
    fill(255, 125, 0); rect(x + xH, y, t, w, 5);
    xH *= 0.85;  
  }
}

////////////////// создаём
c_ball b1 = new c_ball(30);
c_ramp r1 = new c_ramp(25, 110, 20, -1), r2 = new c_ramp(resX - 25, 110, 20, 1);

////////////////// опрос клавиатуры
float d1, d2;

void keyPressed()
{
  if (keyCode == 'A') d1 = -D * 0.25;
  if (keyCode == 'Z') d1 = D * 0.25;
  if (keyCode == UP) d2 = -D * 0.25; 
  if (keyCode == DOWN) d2 = D * 0.25;
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
  r1.regenerate(d1); r1.setL();                // левая тележка
  r2.regenerate(d2); r2.setR();                // правая 
  b1.regenerate();                             // мячик 
}