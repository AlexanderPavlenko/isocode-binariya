float a = 0;                                                         // общий угол вращения

void setup() { size(800, 800); frameRate(30); ellipseMode(RADIUS); } // drawCirc(...) подчиняется ellipseMode(...) 

void draw()
{ 
  float x = width / 2 + random(-1, 1), y = height / 2 + random(-1, 1), r = x + random(-3, 3);
  background(0);                                                      // чёрный космос
  noStroke(); fill(255, 155, 0); drawCirc(x, y,  r * 0.25);           // солнце
  
  noFill(); stroke(40); drawCirc(x, y, r * 0.75);                     // орбита планеты
  translate(x, y); rotate(a);                                         // перемещаем и вращаем систему координат
  noStroke(); fill(175, 0, 55); drawCirc(r * 0.75, 0, r * 0.05);      // планета
  
  r += random(-7, 7);                                                 // если стереть все random(), то настанет...                                                  
  
  noFill(); stroke(40); drawCirc(r * 0.75, 0, r * 0.125);             // орбита луны
  translate(r * 0.75, 0); rotate(a * 2.5);                            // перемещаем и вращаем   
  noStroke(); fill(100, 90, 105); drawCirc(r * 0.125, 0, r * 0.0125); // луна
  
  a -= 0.0025;                                                        // наращиваем угол 
}


