////////////////// опрос клавиатуры
int keyP[] = new int[8], keyR[] = new int[8];

void keyPressed()
{
  if (keyCode == SHIFT) keyP[0]++;
  if (keyCode == CONTROL) keyP[1]++;
  if (keyCode == ENTER) keyP[2]++; 
  if (keyCode == 'A') keyP[3]++;
  if (keyCode == 'S') keyP[4]++;
  if (keyCode == 'D') keyP[5]++;
  if (keyCode == 'F') keyP[6]++;
  if (keyCode == 'G') keyP[7]++;
  redraw();
}
void keyReleased()
{
  if (keyCode == SHIFT) keyR[0]++;
  if (keyCode == CONTROL) keyR[1]++;
  if (keyCode == ENTER) keyR[2]++; 
  if (keyCode == 'A') keyR[3]++;
  if (keyCode == 'S') keyR[4]++;
  if (keyCode == 'D') keyR[5]++;
  if (keyCode == 'F') keyR[6]++;
  if (keyCode == 'G') keyR[7]++;
  if (keyCode == BACKSPACE) for (int i = 0; i < 8; i++) keyP[i] = keyR[i] = 0; 
  redraw();
}

//////////////// Инициализация и цикл рисования
PFont font;

void setup()
{ 
  size(640, 200); noStroke(); noLoop();
  font = createFont("Consolas", 14); textFont(font); textAlign(RIGHT, CENTER);
}

void draw()
{
  background(0); fill(255, 125, 0);
  text("Shift:", 90, 22); 
  text("Ctrl:", 90, 42);
  text("Enter:", 90, 62);
  text("A:", 90, 82);
  text("S:", 90, 102);
  text("D:", 90, 122);
  text("F:", 90, 142);
  text("G:", 90, 162);
  fill(0, 120, 155); text("Press BackSpace кеу for сlear", width - 40, 182);
  for (int i = 0; i < 8; i++)
  { fill(0, 175, 255);
    for (int j = 0; j < keyP[i]; j++) rect (100 + j * 10, 20 + i * 20, 8, 3);
    fill(255, 145, 0);
    for (int j = 0; j < keyR[i]; j++) rect (100 + j * 10, 25 + i * 20, 8, 3);
  }
}
 
