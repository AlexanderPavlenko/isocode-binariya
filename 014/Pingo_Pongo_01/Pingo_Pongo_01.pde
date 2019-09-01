//////////////// Ping Pong почти готовый...

//////////////// организация звука 
import ddf.minim.*;                           // подключаем аудио-библиотеку                      

Minim minim;                                  // основной управляющий объект аудио-библиотеки
AudioSample s_in, s_out;                      // объекты звуков(аудио-сэмплов)

///////////////// общие параметры и вспомогательные объекты 
int resX = 800, resY = 540;                   // размер изображения
float sc = resY / 480.0, scx = resX / 800.0;  // общий масштаб и по х - отдельно 
float D = 5 * resX / 640.0, SD = D, K = 0.35; // общее приращения, запомнили его начальное значение, коэфициент передачи движения от тележек - мячику 

boolean start = true;                         // признак того, что игра только стартовала(для отображения заставки) 
PFont fontS, fontB;                           // объекты для загрузки шрифтов 
int hit = 0;                                  // признаки соударения с левой (-1) и правой (1) тележкой. 

///////////////// переменные через которые шарик "видит" тележеки 
float L_x, L_yU, L_yD, L_dy;                  // левая тележка: граница столкновения по x, границы и скорость движения (в знаке - направление) по у
float R_x, R_yU, R_yD, R_dy;                  // правая ...

///////////////// Мячик
class c_ball                     
{
  float x, y, dx, dy, r;                       // положение, приращения, радиус
  color c, cL, cI;                             // цвет, цвет вспышки и цвет отметки попадания 
  float tL, tx, ty, tM;                        // затухание вспышки мячика при ударе об границы, координаты отметки при попадании и ее затухание... 

  c_ball(float rr)                             // конструктор объекта - инициализация начальных параметров
  { 
    reset(resX * 0.5, resY * 0.5); r = rr; c = color(0, 155, 225); cL = color(200, 225, 255); cI = color(0, 200, 255); tL = 0;
  }                               
  void reset(float xx, float yy)               // сброс мячика в новую позицию  
  {
    x = xx; y = yy; dx = SD * zrandom(); dy = random(SD / 2, SD) * zrandom();
  }
  int regenerate()                             // перемещение и отрисовка, возвращает -1 если ударился об левую границу, 1 если об правую и 0 если не ударялся 
  {
    int p = 0;                                 // считаем
    float px = x, xr, yr;
    x += constrain(dx * sqrt(D / abs(dy)), -D * 2, D * 2);  // некоторая имитация физики соударений, для большей играбельности 
    y += constrain(dy * sqrt(D / abs(dx)), -D * 2, D * 2);
    //x += dx; y += dy;                                     // раньше было проще
    if (dx < 0)
    { xr = x - r;                              // проверки на соударения с тележками и вертикальными(по x) границами  
      if (((px - r) > L_x) && (xr < L_x) && ((y + r / 2) >= L_yU) && ((y - r / 2) <= L_yD))
      { x -= 2 * (xr - L_x); dx = -dx; dy += L_dy * K; s_in.trigger(); hit = -1;
      } else if (xr < 0) { x -= 2 * xr; dx = -dx; tM = tL = 1; tx = 0; ty = y; p = -1; s_out.trigger(); } 
    } else { xr = x + r;
             if (((px + r) < R_x) && (xr > R_x) && ((y + r / 2) >= R_yU) && ((y - r / 2) <= R_yD))
             { x -= 2 * (xr - R_x); dx = -dx; dy += R_dy * K; s_in.trigger(); hit = 1;
             } else if (xr > resX) { x -= 2 * (xr - resX); dx = -dx; tM = tL = 1; tx = resX; ty = y; p = 1; s_out.trigger(); }
           }  
    if (!start) dy *= 0.995;                   // "выполащиваем" траекторию по чу-чуть 
    dy = constrain(dy, -D * 1.5, D * 1.5);
    if (dy < 0)                                // проверки на соударения с горизонтальными(по y) границами
    { yr = (y - r) - 4 * sc;                   
      if (yr < 0) { y -= 2 * yr; dy = -dy; s_in.trigger(); }
    } else { yr = (y + r) - (resY - 4 * sc);
             if (yr > 0) { y -= 2 * yr; dy = -dy; s_in.trigger(); }
           }  
    if (tM > 0.025) { fill(lerpColor(black, cI, tM)); rect(tx, ty, r / 2, r * 2 + r / 2, r / 4); tM *= 0.95; }
    color cc = lerpColor(c, cL, tL); tL *= 0.9;
    fill(cc); circle(x, y, r); 
    fill(overcoL(cc)); circle(x, y, r * 0.7);
    return p;
  }  
}

////////////////// Тележка
class c_ramp                      
{
  float x, y, dy, dm, df, xH,                  // положение, приращение, его максимум, затухание и смещение при ударе
        w, t;                                  // ширина и толщина
  int l, ml;                                   // количество жизней и запомненное начальное их количество
  color c, cL;                                 // просто цвет и цвет вспышки  
  float tL;                                    // затухание вспышки при ударе об границы 
  int side;                                    // признак левой (-1) или правой (1) тележки 

  c_ramp(float xx, float ww, float tt, int ll, int sd) // конструктор
  { 
    x = xx; y = resY / 2; dy = 0; df = 0.9; c = color(255, 145, 0); cL = color(255, 255, 200); xH = 0;
    w = ww; t = tt; ml = l = ll; side = sd;
  }                                            // заносим данные тележки как для расположенной на поле слева или справа 
  void setL() { L_yU = y - w / 2 - t / 2; L_yD = y + w / 2 + t / 2; L_x = x + t / 2; L_dy = dy; }
  void setR() { R_yU = y - w / 2 - t / 2; R_yD = y + w / 2 + t / 2; R_x = x - t / 2; R_dy = dy; }
  void regenerate(float d)                     // перемещение и отрисовка 
  {                                            // перемещаем
    dy = constrain(dy + d, -D * 1.5, D * 1.5); 
    if (y + t / 2 > resY) dy -= D * 0.5; else if (y - t / 2 < 0) dy += D * 0.5;
    y += dy;                                   // рисуем
    if (side == hit) {xH = side * 5; hit = 0; }// если был удар тележка взрагивает(смещается)
    float xs = x + xH, ws = w * 0.97;
    color cc = lerpColor(c, cL, tL), cc2 = overcoD(cc);
    fill(cc); rect(xs, y, t, w + t, t / 2); xs += side * t / 4;
    fill(cc2); rect(xs, y, t / 2 * 0.77, w + t / 4, t / 4);
    fill(cc);  for (int i = 0; i < l; i++) circle(xs, y + ws / 2 - i * ws / (ml - 1), t / 15); // рисуем количество жизней
    dy *= df; xH *= 0.85; tL *= 0.9;           // затухание движения, смещения тележки от удара и вспышки
  }
  void lifeDec() { if (l > 0) l--; tL = 1; }   // отнять одну жизнь
  void lifeInc() { if (l < ml) l++; }          // прибавить одну жизнь
}

////////////////// объекты и переменные
c_ball b1 = new c_ball(30 * sc);
c_ramp r1 = new c_ramp(30 * sc, 110 * sc, 30 * sc, 10, -1), r2 = new c_ramp(resX - 30 * sc, 110 * sc, 30 * sc, 10, 1);

////////////////// опрос клавиатуры
float d1, d2;                                  // переменные разгона тележек в зависимости от нажатия клавиш

void keyPressed()                              // нажали, тележки разгонятся
{
  if (start) { r1.l = r1.ml; r2.l = r2.ml; start = false; }
  if (keyCode == 'A') d1 = -D * 0.25;
  if (keyCode == 'Z') d1 = D * 0.25;
  if (keyCode == UP) d2 = -D * 0.25; 
  if (keyCode == DOWN) d2 = D * 0.25;
}

void keyReleased()                             // отпустили, тележки останавливаются, не сразу  
{                                              // они же инерционные
  if (keyCode == 'A') d1 = 0;
  if (keyCode == 'Z') d1 = 0;
  if (keyCode == UP) d2 = 0; 
  if (keyCode == DOWN) d2 = 0;
}

//////////////// Инициализация основных параметров отображения и общих переменных
void settings() { size(resX, resY); }

void setup()
{ 
  noStroke(); frameRate(30);
  rectMode(CENTER); textAlign(CENTER); // смотрим Reference
  
  minim = new Minim(this);                          // инициализируем управление звуком
  s_in = minim.loadSample("data\\s_in.mp3");        // загружаем звуки
  s_out = minim.loadSample("data\\s_out.mp3");

  fontS = loadFont("data\\FiraSans-Italic-16.vlw"); // загружаем шрифты 
  fontB = loadFont("data\\NeuropolMedium-48.vlw");
} 

////////////////// Цикл рисования
void draw()
{
  background(0, 0, 0);
  fill(165, 185, 100); rect(resX / 2, 0, width - 100 * sc, 8 * sc, 4 * sc); 
                       rect(resX / 2, resY, width - 100 * sc, 8 * sc, 4 * sc); 
  r1.regenerate(d1); r1.setL();
  r2.regenerate(d2); r2.setR();
  int b = b1.regenerate();
  if (b < 0) { r1.lifeDec(); r2.lifeInc(); D = (SD + D) / 2; }
  if (b > 0) { r2.lifeDec(); r1.lifeInc(); D = (SD + D) / 2; }
  if (start)
  { fill(155, 215, 0); textFont(fontB, 48 * scx); text("Pingo Pongo", resX / 2, resY / 2 - 15);
    fill(0, 175, 255); textFont(fontS, 16 * scx); text("< A-Z <------------------------ Controls ------------------------> Up-Down >", resX / 2, resY / 2 + 12);
  } else D += 0.02 * sc;
}

void stop()                                 // если описана такая функция, то она вызывается при выходе из программы
{                                          
  s_in.close(); s_out.close();              // если в программе использовался звук через minim
  minim.stop(); super.stop();               // то всё это надо сделать при выходе из неё
}

/////////////// Вспомогательные переменные и функции
color black = color(0, 0, 0, 255);          // черный, непрозрачный цвет

int irandom (int m) { return (int)random(m + 1.0); }
int irandom (int mn, int mx) { return (int)random(mn, mx + 1.0); }
int zrandom () { return 1 - 2 * irandom(1); }

void circle(float x, float y, float r) { ellipse(x, y, r * 2, r * 2); }
float arcin(float t) { t = t * 2 - 1; return t * t;  }
color overcoL(color c) {return lerpColor(c, color((red(c) - 200) * 4,(green(c) - 200) * 4,(blue(c) - 200) * 4), 0.25); }
color overcoD(color c) {return lerpColor(c, color((red(c) - 200) * 2,(green(c) - 200) * 2,(blue(c) - 200) * 2), 0.32); }

///////////////// Вот и все