void setup() { size(800, 600); noLoop(); }

void draw()
{
  drawBegin(); // use a classical system of coordinates, where the coordinate nodes are disposed at the centers of pixels 
               // используем классическую систему координат, в которой узлы координатной сетки расположены в центрах пикселей
               
  //---------------------------------------------------------------------------------------------------------------------------------
  rectMode(CORNERS); noStroke(); fill(0, 100, 130); drawRect(drawXS, drawYS, drawXL, drawYL);
  // rectangle exactly the size of window (analogue of background(...)), same drawRect(-0.5, -0.5, width - 0.5, height - 0.5);
  // прямоугольник размером ровно в размер окна (аналог background(...)), тоже самое drawRect(-0.5, -0.5, width - 0.5, height - 0.5);
  
  fill(0, 60, 80); drawRect(drawXS + 4, drawYS + 4, drawXL - 4, drawYL - 4);
  // rectangle 4+4 pixels closer
  // прямоугольник на 4+4 пикселе уже.

  //---------------------------------------------------------------------------------------------------------------------------------
  fill(255); text("1)", 8, 18);

  fill(255, 155, 0); drawRect(29.5, 14.5, 30.5, 15.5);
  // rectangle exactly a pixel size
  // прямоугольник размером ровно в пиксель
  
  rectMode(CORNER); drawRect(39.5, 14.5, 1, 1);
  // same, more to right and in "usual style" (through CORNER)
  // такой же, правее и в "обычном стиле" (через CORNER) 

  rectMode(RADIUS); drawRect(50, 15, 0.5, 0.5);
  // one more, through RADIUS
  // ещё один, через RADIUS

  rectMode(CENTER); drawRect(60, 15, 1, 1);
  // through CENTER
  // через CENTER

  //---------------------------------------------------------------------------------------------------------------------------------
  fill(255); text("2)", 8, 39);

  fill(50, 155, 255); drawCirc(30, 35, 1);
  // circle a pixel size and the pixel location exactly  
  // круг размером в пиксель и положением точно в пикселе 

  drawCirc(40.5, 35.5, 1);
  // same, but between pixels 
  // тем же размером, но "попавший между пикселями"
  
  drawCirc(50, 35, 2);
  // circle a 2 pixels size 
  // круг размером в 2 пикселя

  ellipseMode(RADIUS); drawCirc(60, 35, 1);
  // some, but through RADIUS
  // такой же, но через RADIUS

  //---------------------------------------------------------------------------------------------------------------------------------
  fill(255); text("3)", 8, 74);

  strokeCap(ROUND); strokeWeight(10); noFill(); stroke(70, 150, 170); drawLine(50, 70, 150, 120);
  // thick line with rounded ends 
  // толстая линия с закругленными концами

  strokeCap(PROJECT); strokeWeight(10); drawLine(195, 120, 310, 70);
  // with PROJECT-ed ends
  // с прямоугольными PROJECT(удлиненными на размер половины толщины) концами

  strokeCap(SQUARE); strokeWeight(10); drawLine(360, 70, 470, 120); 
  // with rectangular chopped-off (on line length) ends
  // с прямоугольными, "обрубленными" (по длине линии)

  //---------------------------------------------------------------------------------------------------------------------------------
  fill(255); text("4)", 8, 203);

  ellipseMode(RADIUS); noStroke(); fill(255, 175, 125); drawCirc (100, 200, 50); 
  // circle with radius 100 pixels
  // круг радиусом 100 пикселей

  noFill(); stroke(255, 175, 125); strokeWeight(5); drawCirc (250, 200, 50);
  // some, but as thick stroke
  // такой же, но в виде толстого абриса (обводки)
  
  fill(155, 125, 100); stroke(255, 175, 125); drawCirc (400, 200, 50);
  // with fill and stroke
  // и с закраской и с обводкой
  
  //---------------------------------------------------------------------------------------------------------------------------------
  fill(255); text("5)", 8, 329);

  rectMode(CORNER); noStroke(); fill(0, 35, 55); drawRect(40.5, 300.5, 100, 50);
  // rectangle have sharp edges, if its borders are located exactly between pixels. 
  // in classic coordinate system (between drawBegin()-drawEnd()), otherwise - all the way around
  // прямоугольник имеет четкие края, если его границы расположились точно между пикселями.
  // в классической системе координат (между drawBegin()-drawEnd()), иначе - всё наоборот

  drawRect(150, 300, 100, 50);
  // that rectangle - have no sharp edges
  // это прямоугольник - нечеткий
   
  drawRect(270.5, 300.5, 100, 50, 15);
  // sharp rectangle with rounded corners
  // чёткий и c закруглёнными углами
  
  fill(0, 35, 55); stroke(0, 100, 125); drawRect(382, 300, 100, 50, 15);
  // with fill and stroke
  // с закраской и обводкой

  //---------------------------------------------------------------------------------------------------------------------------------
  fill(255); text("6)", 8, 478);

  noStroke(); fill(200, 50, 75); drawEllipse(140, 475, 100, 40);
  // ellipse
  // эллипс

  stroke(255, 175, 125); strokeWeight(25); drawEllipse(370, 475, 100, 40);
  // with thick stroke
  // с толстой обводкой

  //---------------------------------------------------------------------------------------------------------------------------------
  fill(255); text("7)", 580, 80);
  
  noStroke(); fill(55, 155, 175); drawRay(540, 140, 750, 60, 25, 100);
  //additional 2D-primitive: ray (as line with the different thickness of the ends, but with fill and stroke parameters)
  //дополнительный 2D-примитив: луч (как линия с разной толщиной концов, но с параметрами закраски и обводки)
  
  stroke(105, 205, 235); strokeWeight(10); strokeJoin(ROUND);
  fill(55, 125, 155); drawRay(560, 240, 750, 180, 100, 35);
  //ray with fill and stroke
  //луч с закраской и обводкой

  //---------------------------------------------------------------------------------------------------------------------------------
  fill(255); text("8)", 580, 360);
  
  noStroke(); fill(255, 175, 105);
  drawRoundRay(580, 400, 720, 360, 25, 100);
  //ray with rounded ends
  //луч с закруглёнными концами

  noFill(); stroke(55, 125, 155); strokeWeight(20);
  drawRoundRay(600, 500, 735, 465, 100, 60);  
  //with stroke and without fills
  //с обводкой и без закраски
  
  drawEnd();  // обязательно надо вызвать, если был вызван drawBegin(); 
}  

