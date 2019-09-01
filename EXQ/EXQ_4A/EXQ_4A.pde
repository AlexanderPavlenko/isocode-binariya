float s = 100;

void setup() { size(800, 600); noStroke(); noLoop(); }

void draw() { background(255); fill(155, 215, 0); ellipse(mouseX, mouseY, s, s); }
                                            // функции событий: 
void mouseMoved() { s = 100; redraw(); }    // движение мышки
void mouseDragged() { s = 200; redraw(); }  // движение с нажатой кнопкой
void mousePressed() { s = 200; redraw(); }  // нажатие кнопки
void mouseReleased() { s = 100; redraw(); } // отпускание
