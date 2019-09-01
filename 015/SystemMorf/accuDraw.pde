///////////////////////////////////////////////////////////////////////////////////
//////////// Accurate Draw 2D Library prototype // fully free for use and modify //
//////////// completely compatible with fill and stroke style`s /////////////////// 
//////////// Igor Kriulin // nemehanika@gmail.com /////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////

//////////// Some Service
float drawXS = 0, drawYS = 0, drawXL, drawYL;
void drawSize(int sx, int sy) { size(sx, sy); drawXL = width; drawYL = height; }
void drawSize(int sx, int sy, String ren) { size(sx, sy, ren); drawXL = width; drawYL = height; }
boolean drawNow = false;

class c_drawUse
{
  float x1, y1, x2, y2, cx, cy, sx, sy, dx, dy, d, scale;
  float seg[];

  c_drawUse() { seg = new float[91]; scale = 1.0; }
  void snap() { scale = sqrt(sq(screenX(10000.0, 0.0) - screenX(0.0, 0.0)) + sq(screenY(10000.0, 0.0) - screenY(0.0, 0.0))) / 10000;
                if (drawNow) { drawXS = -0.5; drawYS = -0.5; drawXL = width - 0.5; drawYL = height - 0.5; 
                             } else { drawXS = 0; drawYS = 0; drawXL = width; drawYL = height; }
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
    if (sx > sy) { r = sx - sy; return out(cx - r, cy, cx + r, cy, sy + wr);
                 } else { r = sy - sx; return out(cx, cy - r, cx, cy + r, sx + wr);
                        } 
  }
  void place(int mode, float a, float b, float c, float d)
  {
    switch (mode)
    { case CENTER: cx = a; cy = b; sx = c; sy = d; break;
      case RADIUS: cx = a; cy = b; sx = c * 2; sy = d * 2; break;
      case CORNER: cx = a + (sx = c) / 2; cy = b + (sy = d) / 2; break;
      case CORNERS: cx = a + (sx = (c - a)) / 2; cy = b + (sy = (d - b)) / 2; sx = abs(sx); sy = abs(sy); break;
    }
    x1 = cx - sx / 2; y1 = cy - sy / 2; x2 = cx + sx / 2; y2 = cy + sy / 2;
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
    { if (fy < 0.000001) return 0;
      a = atan(fx / fy);
      if (y > 0) { if (x > 0) a += 3*PI/2; else a = 3*PI/2 - a; } else if (x < 0) a += PI/2; else a = PI/2 - a; 
    } else
    { if (fx < 0.000001) return 0;
      a = atan(fy / fx);
      if (y > 0) { if (x > 0) a = 2*PI - a; else a += PI; } else if (x < 0) a = PI - a; else a = a;  
    }
    return a;
  }
  boolean calcDxDy(float x1, float y1, float x2, float y2)
  {
    dx = x2 - x1; dy = y2 - y1; d = dx * dx + dy * dy;
    if (d < 0.000001) return false;
    d = sqrt(d); dx /= d; dy /= d;
    return true;
  }
  boolean calcDxDy(float x1, float y1, float x2, float y2, float x3, float y3)
  {
    dx = (x2 - x1 + x3 - x2) / 2; dy = (y2 - y1 + y3 - y2); d = dx * dx + dy * dy;
    if (d < 0.000001) return false;
    d = sqrt(d); dx /= d; dy /= d;
    return true;
  }

  float power(float t, float p) { return p = t / (t + (1 - t) * (1 - p)); }
}

c_drawUse drawUse = new c_drawUse();

void drawBegin() { pushMatrix(); translate(0.5, 0.5);
                   drawXS = -0.5; drawYS = -0.5; drawXL = width - 0.5; drawYL = height - 0.5;
                   drawNow = true;
                 }
void drawEnd() { drawNow = false; popMatrix(); }

//////////// Primitive`s
void drawCirc(float x, float y, float r)
{
  drawUse.snap();
  if ((g.ellipseMode == CENTER) || (g.ellipseMode == CORNERS)) r /= 2;
  if ((r * drawUse.scale < 0.001) || drawUse.out(x, y, r)) return;
  boolean gs = g.stroke;
  pushStyle();
  noStroke(); ellipseMode(RADIUS);
  if (g.fill) { fill(g.fillColor); ellipse(x, y, r, r); }
  if (!gs) { popStyle(); return; }
  fill(g.strokeColor);
  r += g.strokeWeight / 2;
  int i, c = drawUse.cSegs(r) / 4, c1;
  float aD = 0.5 * PI / c, a = aD;
  for (i = 1; i <= c; i++) { drawUse.seg[i] = sin(a); a += aD; };
  beginShape();
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
  if (r > 0.000001)
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
  endShape(CLOSE); 
  popStyle();
}

////////////

void drawEllipse(float x, float y, float rx, float ry)
{
  drawUse.snap();
  drawUse.place(g.ellipseMode, x, y, rx, ry); if (drawUse.out()) return;
  x = drawUse.cx; y = drawUse.cy; rx = drawUse.sx / 2; ry = drawUse.sy / 2;   
  float rrx = rx, rry = ry, rmx, rmn, rm, wr, x1 = 0, y1 = 0, x2, y2, x3, y3, xx, yy;
  rmx = max(rx, ry);
  if ((rmx * drawUse.scale < 0.001) || drawUse.out(x, y, rmx)) return;
  boolean gs = g.stroke;
  pushStyle();
  noStroke(); ellipseMode(RADIUS);
  if (g.fill) { fill(g.fillColor); ellipse(x, y, rx, ry); }
  if (!gs) { popStyle(); return; }
  fill(g.strokeColor);
  rmn = min(rx, ry); rm = rmn + (rmx - rmn) / 2; wr = g.strokeWeight / 2;
  int i, c = drawUse.cSegs(rm + wr) / 4, c1;
  float aD = 0.5 * PI / c, a = aD;
  for (i = 1; i <= c; i++) { drawUse.seg[i] = sin(a); a += aD; };
  beginShape();
  vertex((x2 = x - rx) - wr, y2 = y);
  for (i = 1; i < c; i++) { x3 = x - drawUse.seg[c - i] * rx; y3 = y + drawUse.seg[i] * ry;
                            if (i > 1) { drawUse.calcDxDy(x1, y1, x2, y2, x3, y3); 
                                         vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);
                                       }  
                            x1 = x2; y1 = y2; x2 = x3; y2 = y3;
                          }
  drawUse.calcDxDy(x1, y1, x2, y2, x3 = x, y3 = y + ry); 
  vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);  
  vertex(x2 = x3, (y2 = y3) + wr);
  for (i = 1; i < c; i++) { x3 = x - (-drawUse.seg[i]) * rx; y3 = y + drawUse.seg[c - i] * ry;
                            if (i > 1) { drawUse.calcDxDy(x1, y1, x2, y2, x3, y3); 
                                         vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);
                                       }  
                            x1 = x2; y1 = y2; x2 = x3; y2 = y3;
                          } 
  drawUse.calcDxDy(x1, y1, x2, y2, x3 = x + rx, y3 = y); 
  vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);  
  vertex((x2 = x3) + wr, y2 = y3);
  for (i = 1; i < c; i++) { x3 = x - (-drawUse.seg[c - i]) * rx; y3 = y + (-drawUse.seg[i]) * ry;
                            if (i > 1) { drawUse.calcDxDy(x1, y1, x2, y2, x3, y3); 
                                         vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);
                                       }  
                            x1 = x2; y1 = y2; x2 = x3; y2 = y3;
                          }
  drawUse.calcDxDy(x1, y1, x2, y2, x3 = x, y3 = y - ry); 
  vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);  
  vertex(x2 = x3, (y2 = y3) - wr);
  for (i = 1; i < c; i++) { x3 = x - drawUse.seg[i] * rx; y3 = y + (-drawUse.seg[c - i]) * ry;
                            if (i > 1) { drawUse.calcDxDy(x1, y1, x2, y2, x3, y3); 
                                         vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);
                                       }  
                            x1 = x2; y1 = y2; x2 = x3; y2 = y3;
                          }
  drawUse.calcDxDy(x1, y1, x2, y2, x3 = x - rx, y3 = y); 
  vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);
  vertex(x3 - wr, y3);
  if ((rm - wr) > 0.000001)
  { c1 = drawUse.cSegs(rm - wr) / 4; 
    if ((c - c1) > c / 4) { c = c1; c1--; aD = 0.5 * PI / c; a = aD;
                            for (i = 1; i <= c; i++) { drawUse.seg[i] = sin(a); a += aD; };
                          } else c1 = c - 1;
    vertex((x2 = x - rx) + wr, y2 = y);
    for (i = c1; i > 0; i--) { x3 = x - drawUse.seg[i] * rx; y3 = y + (-drawUse.seg[c - i]) * ry;
                               if (i < c1) { drawUse.calcDxDy(x1, y1, x2, y2, x3, y3);
                                             vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);
                                           }  
                               x1 = x2; y1 = y2; x2 = x3; y2 = y3;
                             }
    drawUse.calcDxDy(x1, y1, x2, y2, x3 = x, y3 = y - ry); 
    vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);
    vertex(x2 = x3, (y2 = y3) + wr);
    for (i = c1; i > 0; i--) { x3 = x - (-drawUse.seg[c - i]) * rx; y3 = y + (-drawUse.seg[i]) * ry;
                               if (i < c1) { drawUse.calcDxDy(x1, y1, x2, y2, x3, y3);
                                             vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);
                                           }  
                               x1 = x2; y1 = y2; x2 = x3; y2 = y3;
                             }
    drawUse.calcDxDy(x1, y1, x2, y2, x3 = x + rx, y3 = y); 
    vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);
    vertex((x2 = x3) - wr, y2 = y3);
    for (i = c1; i > 0; i--) { x3 = x - (-drawUse.seg[i]) * rx; y3 = y + drawUse.seg[c - i] * ry;
                               if (i < c1) { drawUse.calcDxDy(x1, y1, x2, y2, x3, y3);
                                             vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);
                                           }  
                               x1 = x2; y1 = y2; x2 = x3; y2 = y3;
                             }
    drawUse.calcDxDy(x1, y1, x2, y2, x3 = x, y3 = y + ry); 
    vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);
    vertex(x2 = x3, (y2 = y3) - wr);
    for (i = c1; i > 0; i--) { x3 = x - drawUse.seg[c - i] * rx; y3 = y + drawUse.seg[i] * ry; 
                               if (i < c1) { drawUse.calcDxDy(x1, y1, x2, y2, x3, y3);
                                             vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);
                                           }  
                               x1 = x2; y1 = y2; x2 = x3; y2 = y3; 
                             }
    drawUse.calcDxDy(x1, y1, x2, y2, x3 = x - rx, y3 = y); 
    vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);
    vertex(x3 + wr, y3);
  }  
  endShape(CLOSE); 
  popStyle();
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
  beginShape();
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
  endShape(CLOSE);
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
                beginShape();
                vertex(drawUse.x1, drawUse.y1); vertex(drawUse.x1, drawUse.y2);
                vertex(drawUse.x2, drawUse.y2); vertex(drawUse.x2, drawUse.y1);
                endShape(CLOSE);
              }
  int i, c;
  float r = g.strokeWeight / 2, aD, a;
  if (!gs || (r < 0.0000001)) { popStyle(); return; } 
  fill(g.strokeColor);
  beginShape();
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
  if ((drawUse.sx > r) && (drawUse.sy > r))
  { vertex(drawUse.cx, drawUse.y1 + r);     vertex(drawUse.x2 - r, drawUse.y1 + r);
    vertex(drawUse.x2 - r, drawUse.y2 - r); vertex(drawUse.x1 + r, drawUse.y2 - r);
    vertex(drawUse.x1 + r, drawUse.y1 + r); vertex(drawUse.cx, drawUse.y1 + r);
  }  
  endShape(CLOSE);
  popStyle();  
}

void drawRect (float x, float y, float w, float h, float r)
{ 
  drawUse.snap();
  if (r * drawUse.scale < 0.001) { pushStyle(); strokeJoin(ROUND); drawRect(x, y, w, h); popStyle(); return; }
  drawUse.place(g.rectMode, x, y, w, h); if (drawUse.out()) return;
  int i, c = 0, c1;
  float x1, y1, x2, y2, rx, ry, aD = 0, a = 0, wr = g.strokeWeight / 2;
  r = min(min(rx = drawUse.sx / 2, ry = drawUse.sy / 2), r); rx -= r; ry -= r;
  x1 = drawUse.cx - rx; y1 = drawUse.cy - ry; x2 = drawUse.cx + rx; y2 = drawUse.cy + ry;
  boolean gs = g.stroke, gf = g.fill;
  pushStyle(); noStroke();
  if (gf)
  { fill(g.fillColor);
    c = drawUse.cSegs(r) / 4; aD = 0.5 * PI / c; a = aD;
    for (i = 1; i < c; i++) { drawUse.seg[i] = sin(a); a += aD; };
    beginShape();
    vertex(x1, drawUse.y1); 
    for (i = 1; i < c; i++) vertex(x1 - drawUse.seg[i] * r, y1 + (-drawUse.seg[c - i]) * r);
    vertex(drawUse.x1, y1); vertex(drawUse.x1, y2);
    for (i = 1; i < c; i++) vertex(x1 - drawUse.seg[c - i] * r, y2 + drawUse.seg[i] * r);
    vertex(x1, drawUse.y2); vertex(x2, drawUse.y2);
    for (i = 1; i < c; i++) vertex(x2 - (-drawUse.seg[i]) * r, y2 + drawUse.seg[c - i] * r);
    vertex(drawUse.x2, y2); vertex(drawUse.x2, y1);
    for (i = 1; i < c; i++) vertex(x2 - (-drawUse.seg[c - i]) * r, y1 + (-drawUse.seg[i]) * r);
    vertex(x2, drawUse.y1);
    endShape(CLOSE);
  }
  r += wr;
  if (!gs || (r < 0.0000001)) { popStyle(); return; } 
  fill(g.strokeColor);
  beginShape();
  c1 = drawUse.cSegs(r) / 4;
  if (c1 > c) { c = c1; aD = 0.5 * PI / c; a = aD;
                for (i = 1; i <= c; i++) { drawUse.seg[i] = sin(a); a += aD; };
              }
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
  if (r > 0.000001)
  { c1 = drawUse.cSegs(r) / 4; 
    if ((c - c1) > c / 4) { c = c1; c1--; aD = 0.5 * PI / c; a = aD;
                            for (i = 1; i <= c; i++) { drawUse.seg[i] = sin(a); a += aD; };
                          } else c1 = c - 1;
    vertex(drawUse.cx, y1 - r); vertex(x2, y1 - r); 
    for (i = c1; i > 0; i--) vertex(x2 - (-drawUse.seg[c - i]) * r, y1 + (-drawUse.seg[i]) * r);
    vertex(x2 + r, y1);         vertex(x2 + r, y2);
    for (i = c1; i > 0; i--) vertex(x2 - (-drawUse.seg[i]) * r, y2 + drawUse.seg[c - i] * r);
    vertex(x2, y2 + r);         vertex(x1, y2 + r);         
    for (i = c1; i > 0; i--) vertex(x1 - drawUse.seg[c - i] * r, y2 + drawUse.seg[i] * r);
    vertex(x1 - r, y2);         vertex(x1 - r, y1);
    for (i = c1; i > 0; i--) vertex(x1 - drawUse.seg[i] * r, y1 + (-drawUse.seg[c - i]) * r);
    vertex(x1, y1 - r);         vertex(drawUse.cx, y1 - r);
  } else if ((drawUse.sx > r) && (drawUse.sy > r))
         { vertex(drawUse.cx, drawUse.y1 + wr);     vertex(drawUse.x2 - wr, drawUse.y1 + wr);
           vertex(drawUse.x2 - wr, drawUse.y2 - wr); vertex(drawUse.x1 + wr, drawUse.y2 - wr);
           vertex(drawUse.x1 + wr, drawUse.y1 + wr); vertex(drawUse.cx, drawUse.y1 + wr);
         }  
  endShape(CLOSE);
  popStyle();  
}

//////////// Service
void drawSnap() { drawUse.snap(); };

//////////// Additional Service
void drawXY(float size, color c)
{
  pushStyle();
  noFill(); stroke(c); strokeWeight(1.0); strokeCap(PROJECT); strokeJoin(MITER); rectMode(CENTER);
  drawLine(0, - size * 0.1, 0, size); 
  drawLine(- size * 0.1, 0, size, 0);
  strokeWeight(3.0);
  beginShape();
  vertex(- size * 0.05, size - size * 0.05);
  vertex(0, size);
  vertex(size * 0.05, size - size * 0.05);
  endShape();

  beginShape();
  vertex(size - size * 0.05, - size * 0.05);
  vertex(size, 0);
  vertex(size - size * 0.05, size * 0.05);
  endShape();

  strokeWeight(1.0);

  drawLine(- size * 0.025, size + size * 0.1 - size * 0.025, 0, size + size * 0.1);
  drawLine(size * 0.025, size + size * 0.1 - size * 0.025, -size * 0.025, size + size * 0.1 + size * 0.025);

  drawLine(size + size * 0.1 - size * 0.025, size * 0.025, size + size * 0.1 + size * 0.025, -size * 0.025);
  drawLine(size + size * 0.1 + size * 0.025, size * 0.025, size + size * 0.1 - size * 0.025, -size * 0.025);
  
  noStroke(); fill(c); 
  drawRect(0, 0, 5, 5);

  popStyle();  
}

