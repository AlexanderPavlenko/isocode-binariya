///////////////////////////////////////////////////////////////////////////////////
//////////// Accurate Draw 2D Library prototype // fully free for use and modify //
//////////// completely compatible with fill and stroke style`s /////////////////// 
//////////// Igor Kriulin // nemehanika@gmail.com /////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////

//////////// Some Service
float drawXS = -0.5, drawYS = -0.5, drawXL, drawYL;
float drawXL() { return width - 0.5; }
float drawYL() { return height - 0.5; }
void drawSize(int sx, int sy) { size(sx, sy); drawXL = width - 0.5; drawYL = height - 0.5; }
void drawSize(int sx, int sy, String ren) { size(sx, sy, ren); drawXL = width - 0.5; drawYL = height - 0.5; }

class c_drawUse
{
  float x1, y1, x2, y2, cx, cy, rx, ry, dx, dy, d, scale;
  float seg[];

  c_drawUse() { seg = new float[91]; scale = 1.0; }
  void snap()
  {
    scale = sqrt(sq(screenX(10000.0, 0.0) - screenX(0.0, 0.0)) + sq(screenY(10000.0, 0.0) - screenY(0.0, 0.0))) / 10000;
    drawXL = width - 0.5; drawYL = height - 0.5;
  }
  boolean out(float x, float y, float r)
  { 
    float xx = screenX(x, y), yy = screenY(x, y); r *= scale;
    if (g.stroke) { r += g.strokeWeight / 2 * scale; }
    return (((xx + r) < drawXS) || ((xx - r) > drawXL) || ((yy + r) < drawYS) || ((yy - r) > drawYL));
  }
  boolean out(float x1, float y1, float x2, float y2, float r)
  { 
    r *= 1.5 * scale; 
    float xx1 = screenX(x1, y1), yy1 = screenY(x1, y1),
          xx2 = screenX(x2, y2), yy2 = screenY(x2, y2);
    return ((max(xx1, xx2) + r) < drawXS) || ((min(xx1, xx2) - r) > drawXL) || ((max(yy1, yy2) + r) < drawYS) || ((min(yy1, yy2) - r) > drawYL);
  }
  boolean out()
  { 
    float wr, r;
    if (g.stroke) wr = g.strokeWeight / 2; else wr = 0;
    if (rx > ry) { r = rx - ry; return out(cx - r, cy, cx + r, cy, ry + wr);
                 } else { r = ry - rx; return out(cx, cy - r, cx, cy + r, rx + wr);
                        } 
  }
  void place(int mode, float a, float b, float c, float d)
  {
    switch (mode)
    { case CENTER: cx = a; cy = b; rx = c; ry = d; break;
      case RADIUS: cx = a; cy = b; rx = c * 2; ry = d * 2; break;
      case CORNER: cx = a + (rx = c) / 2; cy = b + (ry = d) / 2; break;
      case CORNERS: cx = a + (rx = (c - a)) / 2; cy = b + (ry = (d - b)) / 2; rx = abs(rx); ry = abs(ry); break;
    }
    x1 = cx - rx / 2; y1 = cy - ry / 2; x2 = cx + rx / 2; y2 = cy + ry / 2;
  }
  int cSegs(float r)
  { 
    r *= scale;
    if (r < 4) return 12; else
    if (r < 7) return 16; else
    if (r > 2000) return 360; else return (int)(16 + 344 * power((r - 7) / 1993, 0.75) + 4) & 0xfffffffc;
  }
  float xyAngle(float x, float y)
  {
    float a, fx = abs(x), fy = abs(y);  
    if (fx < fy)
    { if (fy < 0.0000001) return 0;
      a = atan(fx / fy);
      if (y > 0) { if (x > 0) a += 3*PI/2; else a = 3*PI/2 - a; } else if (x < 0) a += PI/2; else a = PI/2 - a; 
    } else
    { if (fx < 0.0000001) return 0;
      a = atan(fy / fx);
      if (y > 0) { if (x > 0) a = 2*PI - a; else a += PI; } else if (x < 0) a = PI - a; else a = a;  
    }
    return a;
  }
  boolean calcDxDy(float x1, float y1, float x2, float y2)
  {
    dx = x2 - x1; dy = y2 - y1; d = dx * dx + dy * dy;
    if (d < 0.001) return false;
    d = sqrt(d); dx /= d; dy /= d;
    return true;
  }
  float power(float t, float p) { return p = t / (t + (1 - t) * (1 - p)); }
}

c_drawUse drawUse = new c_drawUse();

//////////// Primitive`s
void drawCirc(float x, float y, float r)
{
  drawUse.snap();
  float rr = r;
  if ((g.ellipseMode == CENTER) || (g.ellipseMode == CORNERS)) r /= 2;
  if (r * drawUse.scale < 0.001) return;
  if (drawUse.out(x, y, r)) return;
  boolean gs = g.stroke;
  pushStyle(); noStroke();
  if (g.fill) { fill(g.fillColor);
                pushMatrix(); translate(0.5, 0.5);
                ellipse(x, y, rr, rr);
                popMatrix();
              }
  if (!gs) { popStyle(); return; }
  fill(g.strokeColor);
  r += g.strokeWeight / 2;
  int i, c = drawUse.cSegs(r) / 4, c1;
  float aD = 0.5 * PI / c, a = aD;
  for (i = 1; i <= c; i++) { drawUse.seg[i] = sin(a); a += aD; };
  drawBeginShape();
  vertex(x - r, y);
  for (i = 1; i < c; i++) vertex(x - drawUse.seg[c - i] * r, y + drawUse.seg[i] * r);
  vertex(x, y + r);
  for (i = 1; i < c; i++) vertex(x - (-drawUse.seg[i]) * r, y + drawUse.seg[c - i] * r);
  vertex(x + r, y);
  for (i = 1; i < c; i++) vertex(x - (-drawUse.seg[c - i]) * r, y + (-drawUse.seg[i]) * r);
  vertex(x, y - r);
  for (i = 1; i < c; i++) vertex(x - drawUse.seg[i] * r, y + (-drawUse.seg[c - i]) * r);
  vertex(x - r, y);
  r -= g.strokeWeight;
  if (r > 0.0000001)
  { c1 = drawUse.cSegs(r) / 4; 
    if ((c - c1) > c / 4) { c = c1; c1--; aD = 0.5 * PI / c; a = aD;
                            for (i = 1; i <= c; i++) { drawUse.seg[i] = sin(a); a += aD; };
                          } else c1 = c - 1;
    vertex(x - r, y);
    for (i = c1; i > 0; i--) vertex(x - drawUse.seg[i] * r, y + (-drawUse.seg[c - i]) * r);
    vertex(x, y - r);
    for (i = c1; i > 0; i--) vertex(x - (-drawUse.seg[c - i]) * r, y + (-drawUse.seg[i]) * r);
    vertex(x + r, y);
    for (i = c1; i > 0; i--) vertex(x - (-drawUse.seg[i]) * r, y + drawUse.seg[c - i] * r);
    vertex(x, y + r);
    for (i = c1; i > 0; i--) vertex(x - drawUse.seg[c - i] * r, y + drawUse.seg[i] * r);
    vertex(x - r, y);
  }  
  drawEndShape(CLOSE); 
  popStyle();
}

void drawEllipse(float x, float y, float rx, float ry)
{
  boolean gs = g.stroke;
  pushStyle(); noStroke();
  if (g.fill) { fill(g.fillColor);
                pushMatrix(); translate(0.5, 0.5);
                ellipse(x, y, rx, ry);
                popMatrix();
              }
  if (!gs) { popStyle(); return; } 
}

////////////
void drawLine(float x1, float y1, float x2, float y2)
{
  if (!g.stroke) return;
  drawUse.snap();
  float r = g.strokeWeight / 2;
  if (r * drawUse.scale < 0.001) return; 
  if (drawUse.out(x1, y1, x2, y2, r)) return;
  if (!drawUse.calcDxDy(x1, y1, x2, y2)) { if (g.strokeCap == ROUND) drawCirc(x1, y1, r); return; }
  int s, i;
  float dx = drawUse.dx * r, dy = drawUse.dy * r, a, ad;
  pushStyle(); noStroke(); fill(g.strokeColor);
  drawBeginShape();
  if (g.strokeCap == ROUND)
  { s = drawUse.cSegs(r) / 2; ad = PI / s;
    vertex(x1 - dy,  y1 + dx); vertex(x2 - dy,  y2 + dx);
    a = drawUse.xyAngle(-dy, dx);
    for (i = 1; i < s; i++) { vertex(x2 + r * cos(a),  y2 - r * sin(a)); a += ad; };
    vertex(x2 + dy,  y2 - dx); vertex(x1 + dy,  y1 - dx);
    a = drawUse.xyAngle(dy, -dx);
    for (i = 1; i < s; i++) { vertex(x1 + r * cos(a),  y1 - r * sin(a)); a += ad; };
  } else { if (g.strokeCap == PROJECT) 
           { vertex(x1 - dy - dx,  y1 + dx - dy); vertex(x2 - dy + dx,  y2 + dx + dy);
             vertex(x2 + dy + dx,  y2 - dx + dy); vertex(x1 + dy - dx,  y1 - dx - dy);
           } else { vertex(x1 - dy,  y1 + dx); vertex(x2 - dy,  y2 + dx);
                    vertex(x2 + dy,  y2 - dx); vertex(x1 + dy,  y1 - dx);
                  }
         }
  drawEndShape(CLOSE);
  popStyle();       
}

////////////
void drawRect (float x, float y, float w, float h)
{
  drawUse.snap();
  drawUse.place(g.rectMode, x, y, w, h); if (drawUse.out()) return;
  boolean gs = g.stroke;
  pushStyle(); noStroke();
  if (g.fill) { fill(g.fillColor);
                drawBeginShape();
                vertex(drawUse.x1, drawUse.y1); vertex(drawUse.x1, drawUse.y2);
                vertex(drawUse.x2, drawUse.y2); vertex(drawUse.x2, drawUse.y1);
                drawEndShape(CLOSE);
              }
  int i, c;
  float r = g.strokeWeight / 2, aD, a;
  if (!gs || (r < 0.0000001)) { popStyle(); return; } 
  fill(g.strokeColor);
  drawBeginShape();
  if (g.strokeJoin == ROUND)
  { c = drawUse.cSegs(r) / 4; aD = 0.5 * PI / c; a = aD;
    for (i = 1; i < c; i++) { drawUse.seg[i] = sin(a); a += aD; };
    vertex(drawUse.cx, (y = drawUse.y1) - r); vertex(x = drawUse.x1, y - r);
    for (i = 1; i < c; i++) vertex(x - drawUse.seg[i] * r, y + (-drawUse.seg[c - i]) * r);
    vertex(x - r, drawUse.y1);                vertex(x - r, y = drawUse.y2);
    for (i = 1; i < c; i++) vertex(x - drawUse.seg[c - i] * r, y + drawUse.seg[i] * r);
    vertex(x, (y = drawUse.y2) + r);          vertex((x = drawUse.x2), y + r);
    for (i = 1; i < c; i++) vertex(x - (-drawUse.seg[i]) * r, y + drawUse.seg[c - i] * r);
    vertex(x + r, y);                         vertex(x + r, y = drawUse.y1);
    for (i = 1; i < c; i++) vertex(x - (-drawUse.seg[c - i]) * r, y + (-drawUse.seg[i]) * r);
    vertex(x, y - r);                         vertex(drawUse.cx, y - r);
  } else { if (g.strokeJoin == MITER) 
           { vertex(drawUse.cx, y = drawUse.y1 - r);
             vertex(x = drawUse.x1 - r, y); vertex(x, y = drawUse.y2 + r);
             vertex(x = drawUse.x2 + r, y); vertex(x, y = drawUse.y1 - r); 
             vertex(drawUse.cx, y);
           } else { vertex(drawUse.cx, y = drawUse.y1 - r);
                    vertex(x = drawUse.x1, y);       vertex(x - r, drawUse.y1);
                    vertex(x - r, y = drawUse.y2);   vertex(x, (y = drawUse.y2) + r); 
                    vertex((x = drawUse.x2), y + r); vertex(x + r, y);
                    vertex(x + r, y = drawUse.y1);   vertex(x, y - r);
                    vertex(drawUse.cx, y - r);
                  }
         }
  if ((drawUse.rx > r) && (drawUse.ry > r))
  { vertex(drawUse.cx, drawUse.y1 + r);     vertex(drawUse.x2 - r, drawUse.y1 + r);
    vertex(drawUse.x2 - r, drawUse.y2 - r); vertex(drawUse.x1 + r, drawUse.y2 - r);
    vertex(drawUse.x1 + r, drawUse.y1 + r); vertex(drawUse.cx, drawUse.y1 + r);
  }  
  drawEndShape(CLOSE);
  popStyle();  
}

void drawRect (float x, float y, float w, float h, float r)
{ 
  drawUse.snap();
  if (r * drawUse.scale < 0.001) { pushStyle(); strokeJoin(ROUND); drawRect(x, y, w, h); popStyle(); return; }
  drawUse.place(g.rectMode, x, y, w, h); if (drawUse.out()) return;
  int i, c = 0, c1;
  float x1, y1, x2, y2, rx, ry, aD = 0, a = 0, wr = g.strokeWeight / 2;
  r = min(min(rx = drawUse.rx / 2, ry = drawUse.ry / 2), r); rx -= r; ry -= r;
  x1 = drawUse.cx - rx; y1 = drawUse.cy - ry; x2 = drawUse.cx + rx; y2 = drawUse.cy + ry;
  boolean gs = g.stroke, gf = g.fill;
  pushStyle(); noStroke();
  if (gf)
  { fill(g.fillColor);
    c = drawUse.cSegs(r) / 4; aD = 0.5 * PI / c; a = aD; println(r);
    for (i = 1; i < c; i++) { drawUse.seg[i] = sin(a); a += aD; };
    drawBeginShape();
    vertex(x1, drawUse.y1); 
    for (i = 1; i < c; i++) vertex(x1 - drawUse.seg[i] * r, y1 + (-drawUse.seg[c - i]) * r);
    vertex(drawUse.x1, y1); vertex(drawUse.x1, y2);
    for (i = 1; i < c; i++) vertex(x1 - drawUse.seg[c - i] * r, y2 + drawUse.seg[i] * r);
    vertex(x1, drawUse.y2); vertex(x2, drawUse.y2);
    for (i = 1; i < c; i++) vertex(x2 - (-drawUse.seg[i]) * r, y2 + drawUse.seg[c - i] * r);
    vertex(drawUse.x2, y2); vertex(drawUse.x2, y1);
    for (i = 1; i < c; i++) vertex(x2 - (-drawUse.seg[c - i]) * r, y1 + (-drawUse.seg[i]) * r);
    vertex(x2, drawUse.y1);
    drawEndShape(CLOSE);
  }
  r += wr;
  if (!gs || (r < 0.0000001)) { popStyle(); return; } 
  fill(g.strokeColor);
  drawBeginShape();
  c1 = drawUse.cSegs(r) / 4;
  if (c1 > c) { c = c1; c1--; aD = 0.5 * PI / c; a = aD;
                for (i = 1; i <= c; i++) { drawUse.seg[i] = sin(a); a += aD; };
              } else c1 = c - 1;
  vertex(drawUse.cx, y1 - r); vertex(x1, y1 - r);
  for (i = 1; i < c; i++) vertex(x1 - drawUse.seg[i] * r, y1 + (-drawUse.seg[c - i]) * r);
  vertex(x1 - r, y1);         vertex(x1 - r, y2);
  for (i = 1; i < c; i++) vertex(x1 - drawUse.seg[c - i] * r, y2 + drawUse.seg[i] * r);
  vertex(x1, y2 + r);         vertex(x2, y2 + r);
  for (i = 1; i < c; i++) vertex(x2 - (-drawUse.seg[i]) * r, y2 + drawUse.seg[c - i] * r);
  vertex(x2 + r, y2);         vertex(x2 + r, y1);
  for (i = 1; i < c; i++) vertex(x2 - (-drawUse.seg[c - i]) * r, y1 + (-drawUse.seg[i]) * r);
  vertex(x2, y1 - r);         vertex(drawUse.cx, y1 - r);
  r -= g.strokeWeight;
  if (r > 0.0000001)
  { vertex(drawUse.cx, y1 - r); vertex(x2, y1 - r); 
    for (i = c1; i > 0; i--) vertex(x2 - (-drawUse.seg[c - i]) * r, y1 + (-drawUse.seg[i]) * r);
    vertex(x2 + r, y1);         vertex(x2 + r, y2);
    for (i = c1; i > 0; i--) vertex(x2 - (-drawUse.seg[i]) * r, y2 + drawUse.seg[c - i] * r);
    vertex(x2, y2 + r);         vertex(x1, y2 + r);         
    for (i = c1; i > 0; i--) vertex(x1 - drawUse.seg[c - i] * r, y2 + drawUse.seg[i] * r);
    vertex(x1 - r, y2);         vertex(x1 - r, y1);
    for (i = c1; i > 0; i--) vertex(x1 - drawUse.seg[i] * r, y1 + (-drawUse.seg[c - i]) * r);
    vertex(x1, y1 - r);         vertex(drawUse.cx, y1 - r);
  } else if ((drawUse.rx > r) && (drawUse.ry > r))
         { vertex(drawUse.cx, drawUse.y1 + wr);     vertex(drawUse.x2 - wr, drawUse.y1 + wr);
           vertex(drawUse.x2 - wr, drawUse.y2 - wr); vertex(drawUse.x1 + wr, drawUse.y2 - wr);
           vertex(drawUse.x1 + wr, drawUse.y1 + wr); vertex(drawUse.cx, drawUse.y1 + wr);
         }  
  drawEndShape(CLOSE);
  popStyle();  
}

void drawRect (float x, float y, float w, float h, float r1, float r2, float r3, float r4)
{
}

//////////// Shape
void drawBeginShape() { pushMatrix(); translate(0.5, 0.5); beginShape(); }

// use starndart vertex(...);

void drawEndShape(int c) { endShape(c); popMatrix(); }
void drawEndShape() { endShape(0); popMatrix(); }

//////////// Service
void drawSnap() { drawUse.snap(); };

