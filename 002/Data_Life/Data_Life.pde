int xs = 50, ys = 50;  

void settings() { size(xs * 5 + 5, ys * 5 + 5); } // теперь (начиная с версии 3.0), если необходимо задать размер окна с помощью 
void setup() { noStroke(); frameRate(20); }       // переменных - надо использовать новую, предопределенную функцию settings()

void draw()
{ 
  background(0, 0, 0);
  for (int y = 0; y < ys; y++)
  for (int x = 0; x < xs; x++)
  { float r = random(5);
    fill(0, 155, 255); ellipse(5 + x * 5, 5 + y * 5, r, r);
  }
}                                            