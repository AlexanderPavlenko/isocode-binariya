int c = 30, max = 99;
color c1 = color(155, 0, 55), c2 = color(255, 155, 55);
int[] a;

void setup()
{ 
  size(400, 400); frameRate(60); noStroke();
  a = new int[c];
  for (int i = 0; i < c; i++) a[i] = max * (c - i) / c; //(int)random(1, max);
}

int si = 1, co = 0, pc = c, p = 0; 

void draw()
{
  if (a[si - 1] > a[si]) { int s = a[si - 1]; a[si - 1] = a[si]; a[si] = s; p = si; }
  co++;
  drawSort(co, si);
  si++;  
  if (si == pc) { if (p <= 1) noLoop();  
                  si = 1; pc = p; p = 0;   
                }                                                          
}  

void drawSort(int co, int si)
{
  background(0);
  float dx = (float)(width - 40) / c, wx = dx * 0.75, dy = height - 40, py = height - 20; 
  for (int i = 0; i < c; i++)
  { fill(lerpColor(c1, c2, (float)a[i] / max));  
    rect(20 + dx * i, py - dy * a[i] / max, wx, dy * a[i] / max);
  }  
  fill(255); rect(20 + dx * si, py + 5, wx, 10); text(co, 20, 30);
}
