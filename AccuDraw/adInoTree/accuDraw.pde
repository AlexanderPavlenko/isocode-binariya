///////////////////////////////////////////////////////////////////////////////////
//////////// Accurate Draw 2D Library prototype // fully free for use and modify //
//////////// completely compatible with fill and stroke style`s /////////////////// 
//////////// Igor Kriulin // nemehanika@gmail.com /////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////

//////////// Some Service
float drawXS = 0, drawYS = 0, drawXL, drawYL;
boolean drawNow = false; 

class c_drawUse
{
  float x1, y1, x2, y2, cx, cy, sx, sy, vx, vy, dx, dy, d, scale, ix, iy;
  float arr1[], arr2[], arr3[], arr4[];

  c_drawUse() { arr1 = new float[368]; arr2 = new float[368]; arr3 = new float[368]; arr4 = new float[368]; scale = 1.0; }
  void snap() { scale = sqrt(sq(screenX(10000.0, 0.0) - screenX(0.0, 0.0)) + sq(screenY(10000.0, 0.0) - screenY(0.0, 0.0))) / 10000;
                if (drawNow) { drawXS = -0.5; drawYS = -0.5; drawXL = width - 0.5; drawYL = height - 0.5; 
                             } else { drawXS = 0; drawYS = 0; drawXL = width; drawYL = height; }
              }
  boolean out(float x, float y, float r)
  { 
    float xx = screenX(x, y), yy = screenY(x, y); 
    if (g.stroke) r += g.strokeWeight / 2;
    r *= scale;
    return (((xx + r) < drawXS) || ((xx - r) > drawXL) || ((yy + r) < drawYS) || ((yy - r) > drawYL));
  }
  boolean out(float x1, float y1, float x2, float y2, float r)
  { 
    if (g.stroke) r += g.strokeWeight / 2;
    r *= 1.5 * scale; 
    float xx1 = screenX(x1, y1), yy1 = screenY(x1, y1),
          xx2 = screenX(x2, y2), yy2 = screenY(x2, y2);
    return ((max(xx1, xx2) + r) < drawXS) || ((min(xx1, xx2) - r) > drawXL) || ((max(yy1, yy2) + r) < drawYS) || ((min(yy1, yy2) - r) > drawYL);
  }
  boolean out()
  { 
    float r;
    if (sx > sy) { r = sx - sy; return out(cx - r, cy, cx + r, cy, sy);
                 } else { r = sy - sx; return out(cx, cy - r, cx, cy + r, sx);
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
    { if (fy < 0.00000001) return 0;
      a = atan(fx / fy);
      if (y > 0) { if (x > 0) a += 3*PI/2; else a = 3*PI/2 - a; } else if (x < 0) a += PI/2; else a = PI/2 - a; 
    } else
    { if (fx < 0.00000001) return 0;
      a = atan(fy / fx);
      if (y > 0) { if (x > 0) a = 2*PI - a; else a += PI; } else if (x < 0) a = PI - a; else a = a;  
    }
    return a;
  }
  boolean calcDxDy(float x1, float y1, float x2, float y2)
  {
    vx = x2 - x1; vy = y2 - y1; d = vx * vx + vy * vy;
    if (d < 0.00000001) return false;
    d = sqrt(d); dx = vx / d; dy = vy / d;
    return true;
  }
  boolean calcDxDy(float x1, float y1, float x2, float y2, float x3, float y3)
  {
    vx = (x2 - x1 + x3 - x2) / 2; vy = (y2 - y1 + y3 - y2); d = vx * vx + vy * vy;
    if (d < 0.00000001) return false;
    d = sqrt(d); dx = vx /  d; dy = vy / d;
    return true;
  }
  void cross(float x1, float y1, float x11, float y11, float x2, float y2, float x22, float y22)
  {
    float vx1 = x11 - x1, vy1 = y11 - y1, vx2 = x22 - x2, vy2 = y22 - y2, t;
    
    t = vy2 * vx1 - vx2 * vy1; if (abs(t) < 0.00000001) { ix = x11; iy = y11; return; }
    t = (vx2 * (y1 - y2) - vy2 * (x1 - x2)) / t;
    ix = x1 + vx1 * t;
    iy = y1 + vy1 * t;
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
  float wr = g.strokeWeight / 2;
  if (!gs || (wr * drawUse.scale < 0.0015)) { popStyle(); return; }
  fill(g.strokeColor);
  r += wr;
  int i, c = drawUse.cSegs(r) / 4, c1;
  float aD = 0.5 * PI / c, a = aD;
  float[] sg = drawUse.arr1;
  for (i = 1; i <= c; i++) { sg[i] = sin(a); a += aD; };
  beginShape();
  vertex(x - r, y);
  for (i = 1; i < c; i++) vertex(x - sg[c - i] * r, y + sg[i] * r);
  vertex(x, y + r);
  for (i = 1; i < c; i++) vertex(x - (-sg[i]) * r, y + sg[c - i] * r);
  vertex(x + r, y);
  for (i = 1; i < c; i++) vertex(x - (-sg[c - i]) * r, y + (-sg[i]) * r);
  vertex(x, y - r);
  for (i = 1; i < c; i++) vertex(x - sg[i] * r, y + (-sg[c - i]) * r);
  vertex(x - r, y);
  r -= g.strokeWeight;
  if (r * drawUse.scale > 0.0015)
  { c1 = drawUse.cSegs(r) / 4; 
    if ((c - c1) > c / 8 + 1) { c = c1; c1--; aD = 0.5 * PI / c; a = aD;
                                for (i = 1; i <= c; i++) { sg[i] = sin(a); a += aD; };
                              } else c1 = c - 1;
    vertex(x - r, y);
    for (i = c1; i > 0; i--) vertex(x - sg[i] * r, y + (-sg[c - i]) * r);
    vertex(x, y - r);
    for (i = c1; i > 0; i--) vertex(x - (-sg[c - i]) * r, y + (-sg[i]) * r);
    vertex(x + r, y);
    for (i = c1; i > 0; i--) vertex(x - (-sg[i]) * r, y + sg[c - i] * r);
    vertex(x, y + r);
    for (i = c1; i > 0; i--) vertex(x - sg[c - i] * r, y + sg[i] * r);
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
  float rrx = rx, rry = ry, rmx, rmn, wr, x1 = 0, y1 = 0, x2, y2, x3, y3, xx, yy;
  rmx = max(rx, ry); rmn = min(rx, ry);
  if ((rmx * drawUse.scale < 0.001) || drawUse.out(x, y, rmx)) return;
  boolean gs = g.stroke;
  pushStyle();
  noStroke(); ellipseMode(RADIUS);
  if (g.fill) { fill(g.fillColor); ellipse(x, y, rx, ry); }
  wr = g.strokeWeight / 2;
  if (!gs || (wr * drawUse.scale < 0.0015)) { popStyle(); return; }
  fill(g.strokeColor);
  int i, c = drawUse.cSegs(rmx + wr) / 4, c1;
  float aD = 0.5 * PI / c, a = aD;
  float[] sg = drawUse.arr1;
  for (i = 1; i <= c; i++) { sg[i] = sin(a); a += aD; };
  beginShape();
  vertex((x2 = x - rx) - wr, y2 = y);
  for (i = 1; i < c; i++) { x3 = x - sg[c - i] * rx; y3 = y + sg[i] * ry;
                            if (i > 1) { drawUse.calcDxDy(x1, y1, x2, y2, x3, y3); 
                                         vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);
                                       }  
                            x1 = x2; y1 = y2; x2 = x3; y2 = y3;
                          }
  drawUse.calcDxDy(x1, y1, x2, y2, x3 = x, y3 = y + ry); 
  vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);  
  vertex(x2 = x3, (y2 = y3) + wr);
  for (i = 1; i < c; i++) { x3 = x - (-sg[i]) * rx; y3 = y + sg[c - i] * ry;
                            if (i > 1) { drawUse.calcDxDy(x1, y1, x2, y2, x3, y3); 
                                         vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);
                                       }  
                            x1 = x2; y1 = y2; x2 = x3; y2 = y3;
                          } 
  drawUse.calcDxDy(x1, y1, x2, y2, x3 = x + rx, y3 = y); 
  vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);  
  vertex((x2 = x3) + wr, y2 = y3);
  for (i = 1; i < c; i++) { x3 = x - (-sg[c - i]) * rx; y3 = y + (-sg[i]) * ry;
                            if (i > 1) { drawUse.calcDxDy(x1, y1, x2, y2, x3, y3); 
                                         vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);
                                       }  
                            x1 = x2; y1 = y2; x2 = x3; y2 = y3;
                          }
  drawUse.calcDxDy(x1, y1, x2, y2, x3 = x, y3 = y - ry); 
  vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);  
  vertex(x2 = x3, (y2 = y3) - wr);
  for (i = 1; i < c; i++) { x3 = x - sg[i] * rx; y3 = y + (-sg[c - i]) * ry;
                            if (i > 1) { drawUse.calcDxDy(x1, y1, x2, y2, x3, y3); 
                                         vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);
                                       }  
                            x1 = x2; y1 = y2; x2 = x3; y2 = y3;
                          }
  drawUse.calcDxDy(x1, y1, x2, y2, x3 = x - rx, y3 = y); 
  vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);
  if (rmn > wr)
  { vertex(x3 - wr, y3);
    c1 = drawUse.cSegs(rmx - wr) / 4; 
    if ((c - c1) > c / 8 + 1) { c = c1; c1--; aD = 0.5 * PI / c; a = aD;
                                for (i = 1; i <= c; i++) { sg[i] = sin(a); a += aD; };
                              } else c1 = c - 1;
    vertex((x2 = x - rx) + wr, y2 = y);
    for (i = c1; i > 0; i--) { x3 = x - sg[i] * rx; y3 = y + (-sg[c - i]) * ry;
                               if (i < c1) { drawUse.calcDxDy(x1, y1, x2, y2, x3, y3);
                                             vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);
                                           }  
                               x1 = x2; y1 = y2; x2 = x3; y2 = y3;
                             }
    drawUse.calcDxDy(x1, y1, x2, y2, x3 = x, y3 = y - ry); 
    vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);
    vertex(x2 = x3, (y2 = y3) + wr);
    for (i = c1; i > 0; i--) { x3 = x - (-sg[c - i]) * rx; y3 = y + (-sg[i]) * ry;
                               if (i < c1) { drawUse.calcDxDy(x1, y1, x2, y2, x3, y3);
                                             vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);
                                           }  
                               x1 = x2; y1 = y2; x2 = x3; y2 = y3;
                             }
    drawUse.calcDxDy(x1, y1, x2, y2, x3 = x + rx, y3 = y); 
    vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);
    vertex((x2 = x3) - wr, y2 = y3);
    for (i = c1; i > 0; i--) { x3 = x - (-sg[i]) * rx; y3 = y + sg[c - i] * ry;
                               if (i < c1) { drawUse.calcDxDy(x1, y1, x2, y2, x3, y3);
                                             vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);
                                           }  
                               x1 = x2; y1 = y2; x2 = x3; y2 = y3;
                             }
    drawUse.calcDxDy(x1, y1, x2, y2, x3 = x, y3 = y + ry); 
    vertex(x2 - drawUse.dy * wr, y2 + drawUse.dx * wr);
    vertex(x2 = x3, (y2 = y3) - wr);
    for (i = c1; i > 0; i--) { x3 = x - sg[c - i] * rx; y3 = y + sg[i] * ry; 
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
  if (r * drawUse.scale < 0.0015) return; 
  if (drawUse.out(x1, y1, x2, y2, 0)) return;
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
  if (!gs || (r * drawUse.scale < 0.0015)) { popStyle(); return; } 
  fill(g.strokeColor);
  beginShape();
  if (g.strokeJoin == ROUND)
  { float[] sg = drawUse.arr1;
    c = drawUse.cSegs(r) / 4; aD = 0.5 * PI / c; a = aD;
    for (i = 1; i < c; i++) { sg[i] = sin(a); a += aD; };
    vertex(drawUse.cx, (y = drawUse.y1) - r); vertex(x = drawUse.x1, y - r);
    for (i = 1; i < c; i++) vertex(x - sg[i] * r, y + (-sg[c - i]) * r);
    vertex(x - r, drawUse.y1);                vertex(x - r, y = drawUse.y2);
    for (i = 1; i < c; i++) vertex(x - sg[c - i] * r, y + sg[i] * r);
    vertex(x, (y = drawUse.y2) + r);          vertex((x = drawUse.x2), y + r);
    for (i = 1; i < c; i++) vertex(x - (-sg[i]) * r, y + sg[c - i] * r);
    vertex(x + r, y);                         vertex(x + r, y = drawUse.y1);
    for (i = 1; i < c; i++) vertex(x - (-sg[c - i]) * r, y + (-sg[i]) * r);
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
  if ((drawUse.sx > 2 * r) && (drawUse.sy > 2 * r))
  { vertex(drawUse.cx, drawUse.y1 + r);     vertex(drawUse.x2 - r, drawUse.y1 + r);
    vertex(drawUse.x2 - r, drawUse.y2 - r); vertex(drawUse.x1 + r, drawUse.y2 - r);
    vertex(drawUse.x1 + r, drawUse.y1 + r); vertex(drawUse.cx, drawUse.y1 + r);
  }  
  endShape(CLOSE);
  popStyle();  
}

////////////
void drawRect (float x, float y, float w, float h, float r)
{ 
  drawUse.snap();
  if (r * drawUse.scale < 0.001) { pushStyle(); strokeJoin(ROUND); drawRect(x, y, w, h); popStyle(); return; }
  drawUse.place(g.rectMode, x, y, w, h); if (drawUse.out()) return;
  int i, c = 0, c1;
  float x1, y1, x2, y2, rx, ry, aD = 0, a = 0, wr = g.strokeWeight / 2;
  float[] sg = drawUse.arr1; 
  r = min(min(rx = drawUse.sx / 2, ry = drawUse.sy / 2), r); rx -= r; ry -= r;
  x1 = drawUse.cx - rx; y1 = drawUse.cy - ry; x2 = drawUse.cx + rx; y2 = drawUse.cy + ry;
  boolean gs = g.stroke, gf = g.fill, rc = false;
  pushStyle(); noStroke();
  if (gf)
  { fill(g.fillColor);
    c = drawUse.cSegs(r) / 4; aD = 0.5 * PI / c; a = aD;
    for (i = 1; i < c; i++) { sg[i] = sin(a); a += aD; };
    beginShape();
    vertex(x1, drawUse.y1); 
    for (i = 1; i < c; i++) vertex(x1 - sg[i] * r, y1 + (-sg[c - i]) * r);
    vertex(drawUse.x1, y1); vertex(drawUse.x1, y2);
    for (i = 1; i < c; i++) vertex(x1 - sg[c - i] * r, y2 + sg[i] * r);
    vertex(x1, drawUse.y2); vertex(x2, drawUse.y2);
    for (i = 1; i < c; i++) vertex(x2 - (-sg[i]) * r, y2 + sg[c - i] * r);
    vertex(drawUse.x2, y2); vertex(drawUse.x2, y1);
    for (i = 1; i < c; i++) vertex(x2 - (-sg[c - i]) * r, y1 + (-sg[i]) * r);
    vertex(x2, drawUse.y1);
    endShape(CLOSE);
  }
  if (!gs || (wr * drawUse.scale < 0.0015)) { popStyle(); return; } 
  fill(g.strokeColor);
  r += wr;
  c1 = drawUse.cSegs(r) / 4;
  if (c1 - c > c / 8 + 1) { c = c1; aD = 0.5 * PI / c; a = aD; rc = true;
                            for (i = 1; i <= c; i++) { sg[i] = sin(a); a += aD; };
                          }
  beginShape();
  vertex(drawUse.cx, y1 - r); vertex(x1, y1 - r);
  for (i = 1; i < c; i++) vertex(x1 - sg[i] * r, y1 + (-sg[c - i]) * r);
  vertex(x1 - r, y1);         vertex(x1 - r, y2);
  for (i = 1; i < c; i++) vertex(x1 - sg[c - i] * r, y2 + sg[i] * r);
  vertex(x1, y2 + r);         vertex(x2, y2 + r);
  for (i = 1; i < c; i++) vertex(x2 - (-sg[i]) * r, y2 + sg[c - i] * r);
  vertex(x2 + r, y2);         vertex(x2 + r, y1);
  for (i = 1; i < c; i++) vertex(x2 - (-sg[c - i]) * r, y1 + (-sg[i]) * r);
  vertex(x2, y1 - r);         vertex(drawUse.cx, y1 - r);
  r -= g.strokeWeight;
  if ((drawUse.sx > 2 * r) && (drawUse.sy > 2 * r))
  if (r * drawUse.scale > 0.01)
  { if (rc) { c = c1 = drawUse.cSegs(r) / 4; c1--; aD = 0.5 * PI / c; a = aD;
              for (i = 1; i <= c; i++) { sg[i] = sin(a); a += aD; };
            } else c1 = c - 1;
    vertex(drawUse.cx, y1 - r); vertex(x2, y1 - r); 
    for (i = c1; i > 0; i--) vertex(x2 - (-sg[c - i]) * r, y1 + (-sg[i]) * r);
    vertex(x2 + r, y1);         vertex(x2 + r, y2);
    for (i = c1; i > 0; i--) vertex(x2 - (-sg[i]) * r, y2 + sg[c - i] * r);
    vertex(x2, y2 + r);         vertex(x1, y2 + r);         
    for (i = c1; i > 0; i--) vertex(x1 - sg[c - i] * r, y2 + sg[i] * r);
    vertex(x1 - r, y2);         vertex(x1 - r, y1);
    for (i = c1; i > 0; i--) vertex(x1 - sg[i] * r, y1 + (-sg[c - i]) * r);
    vertex(x1, y1 - r);         vertex(drawUse.cx, y1 - r);
  } else { vertex(drawUse.cx, drawUse.y1 + wr);     vertex(drawUse.x2 - wr, drawUse.y1 + wr);
           vertex(drawUse.x2 - wr, drawUse.y2 - wr); vertex(drawUse.x1 + wr, drawUse.y2 - wr);
           vertex(drawUse.x1 + wr, drawUse.y1 + wr); vertex(drawUse.cx, drawUse.y1 + wr);
         }  
  endShape(CLOSE);
  popStyle();  
}

//////////// Additional primitives
void drawRay(float x1, float y1, float x2, float y2, float w1, float w2)
{
  drawUse.snap();
  float sc = drawUse.scale, dx1, dy1, dx2, dy2, rm, xx1, yy1, xx2, yy2, xx3, yy3, xx4, yy4;
  if (w1 * sc < 0.0015) w1 = 0.0015 / sc;
  if (w2 * sc < 0.0015) w2 = 0.0015 / sc;
  w1 *= 0.5; w2 *= 0.5; rm = max(w1, w2);
  if (drawUse.out(x1, y1, x2, y2, rm)) return;
  if (!drawUse.calcDxDy(x1, y1, x2, y2)) return;
  dx1 = drawUse.dy * w1; dy1 = drawUse.dx * w1;
  dx2 = drawUse.dy * w2; dy2 = drawUse.dx * w2;
  xx1 = x1 - dx1; yy1 = y1 + dy1; xx2 = x2 - dx2; yy2 = y2 + dy2;
  xx3 = x2 + dx2; yy3 = y2 - dy2; xx4 = x1 + dx1; yy4 = y1 - dy1;
  boolean gs = g.stroke, gf = g.fill;
  
  pushStyle(); noStroke();
  if (gf) { fill(g.fillColor);
            beginShape();
            vertex(xx1, yy1); vertex(xx2, yy2);
            vertex(xx3, yy3); vertex(xx4, yy4);
            endShape(CLOSE);
          }
  int i, s, s1, s2;
  float r = g.strokeWeight / 2, a1, ad1, a2, ad2;
  if (!gs || (r * sc < 0.0015)) { popStyle(); return; } 
  fill(g.strokeColor);
  float x3, y3, x4, y4, x5, y5, x6, y6, x7, y7, x8, y8,
        xi1, yi1, xi2, yi2, xi3, yi3, xi4, yi4, xi5, yi5, xi6, yi6, xi7, yi7, xi8, yi8;  
  drawUse.calcDxDy(xx1, yy1, xx2, yy2);
  x1 = xx1 - (drawUse.dy *= r); y1 = yy1 + (drawUse.dx *= r);  xi1 = xx1 + drawUse.dy; yi1 = yy1 - drawUse.dx;
  x2 = xx2 - drawUse.dy; y2 = yy2 + drawUse.dx;                xi2 = xx2 + drawUse.dy; yi2 = yy2 - drawUse.dx; 
  drawUse.calcDxDy(xx2, yy2, xx3, yy3);
  x3 = xx2 - (drawUse.dy *= r); y3 = yy2 + (drawUse.dx *= r);  xi3 = xx2 + drawUse.dy; yi3 = yy2 - drawUse.dx;
  x4 = xx3 - drawUse.dy; y4 = yy3 + drawUse.dx;                xi4 = xx3 + drawUse.dy; yi4 = yy3 - drawUse.dx;
  drawUse.calcDxDy(xx3, yy3, xx4, yy4);
  x5 = xx3 - (drawUse.dy *= r); y5 = yy3 + (drawUse.dx *= r);  xi5 = xx3 + drawUse.dy; yi5 = yy3 - drawUse.dx;
  x6 = xx4 - drawUse.dy; y6 = yy4 + drawUse.dx;                xi6 = xx4 + drawUse.dy; yi6 = yy4 - drawUse.dx;
  drawUse.calcDxDy(xx4, yy4, xx1, yy1);
  x7 = xx4 - (drawUse.dy *= r); y7 = yy4 + (drawUse.dx *= r);  xi7 = xx4 + drawUse.dy; yi7 = yy4 - drawUse.dx;
  x8 = xx1 - drawUse.dy; y8 = yy1 + drawUse.dx;                xi8 = xx1 + drawUse.dy; yi8 = yy1 - drawUse.dx;
  beginShape();
  if (g.strokeJoin == ROUND)
  { s = drawUse.cSegs(r); 
    a1 = drawUse.xyAngle(x8 - xx1, y8 - yy1);
    ad1 = drawUse.xyAngle(x1 - xx1, y1 - yy1) - a1;
    s1 = ceil(s * ad1 / TWO_PI); 
    ad1 = ad1 / s1; a1 += ad1;
    vertex(x8, y8);
    for (i = 1; i < s1; i++) { vertex(xx1 + r * cos(a1),  yy1 - r * sin(a1)); a1 += ad1; };
    vertex(x1, y1);
    a2 = drawUse.xyAngle(x2 - xx2, y2 - yy2);
    ad2 = drawUse.xyAngle(x3 - xx2, y3 - yy2) - a2;
    s2 = ceil(s * ad2 / TWO_PI);
    ad2 = ad2 / s2; a2 += ad2;
    vertex(x2, y2);
    for (i = 1; i < s1; i++) { vertex(xx2 + r * cos(a2),  yy2 - r * sin(a2)); a2 += ad2; };
    vertex(x3, y3);
    a2 = drawUse.xyAngle(x4 - xx3, y4 - yy3); a2 += ad2;
    vertex(x4, y4);
    for (i = 1; i < s1; i++) { vertex(xx3 + r * cos(a2),  yy3 - r * sin(a2)); a2 += ad2; };
    vertex(x5, y5);
    a1 = drawUse.xyAngle(x6 - xx4, y6 - yy4); a1 += ad1;
    vertex(x6, y6);
    for (i = 1; i < s1; i++) { vertex(xx4 + r * cos(a1),  yy4 - r * sin(a1)); a1 += ad1; };
    vertex(x7, y7);
    vertex(x8, y8);
  } else { if (g.strokeJoin == MITER) 
           { drawUse.cross(x7, y7, x8, y8, x1, y1, x2, y2);
             vertex(xx1 = drawUse.ix, yy1 = drawUse.iy);
             drawUse.cross(x1, y1, x2, y2, x3, y3, x4, y4);
             vertex(drawUse.ix, drawUse.iy);
             drawUse.cross(x3, y3, x4, y4, x5, y5, x6, y6);
             vertex(drawUse.ix, drawUse.iy);
             drawUse.cross(x5, y5, x6, y6, x7, y7, x8, y8);
             vertex(drawUse.ix, drawUse.iy);
             vertex(xx1, yy1);
           } else { vertex(x1, y1); vertex(x2, y2);
                    vertex(x3, y3); vertex(x4, y4);
                    vertex(x5, y5); vertex(x6, y6);
                    vertex(x7, y7); vertex(x8, y8);
                    vertex(x1, y1);
                  }
         }
  if ((w1 > r) || (w2 >  r))
  { drawUse.cross(xi2, yi2, xi1, yi1, xi8, yi8, xi7, yi7);
    vertex(xx1 = drawUse.ix, yy1 = drawUse.iy);
    drawUse.cross(xi8, yi8, xi7, yi7, xi6, yi6, xi5, yi5);
    vertex(drawUse.ix, drawUse.iy);
    drawUse.cross(xi6, yi6, xi5, yi5, xi4, yi4, xi3, yi3);
    vertex(drawUse.ix, drawUse.iy);
    drawUse.cross(xi4, yi4, xi3, yi3, xi2, yi2, xi1, yi1);
    vertex(drawUse.ix, drawUse.iy);
    vertex(xx1, yy1);
  }  
  endShape(CLOSE);
  popStyle();    
}

//////////// Additional primitives
void drawRoundRay(float x1, float y1, float x2, float y2, float w1, float w2)
{
  drawUse.snap();
  int i, s, s1, s2, mr = 0;
  float sc = drawUse.scale, sw, dx, dy, d, x, y, a, a1, a2, a3, a4, b, ad1, ad2,
        dx1, dy1, dx2, dy2, rm;
  if (w1 * sc < 0.0015) w1 = 0.0015 / sc;
  if (w2 * sc < 0.0015) w2 = 0.0015 / sc;
  w1 *= 0.5; w2 *= 0.5; rm = max(w1, w2);
  if (drawUse.out(x1, y1, x2, y2, rm)) return;

  dx = x2 - x1; dy = y2 - y1; 
  d = dx * dx + dy * dy;
  if (d > 0.00000001) d = sqrt(d);
  boolean gs = g.stroke, gf = g.fill, rc1 = false, rc2 = false;
  if ((w2 + d) <= w1) { drawCirc(x1, y1, w1); return;
                      } else if ((w1 + d) <= w2) { drawCirc(x2, y2, w2); return; }
  pushStyle(); noStroke(); ellipseMode(RADIUS);
  if (gf) fill(g.fillColor); 
  if (w2 > w1) { sw = x1; x1 = x2; x2 = sw; sw = y1; y1 = y2; y2 = sw; sw = w1; w1 = w2; w2 = sw; dx = -dx; dy = -dy; }
  if (x2 < x1) { mr = 1; x1 = -x1; x2 = -x2; dx = -dx; };
  a = PI / 2 - asin((w1 - w2) / d) + atan(dy / dx);
  dx1 = w1 * cos(a); dy1 = w1 * sin(a);
  dx2 = w2 * cos(a); dy2 = w2 * sin(a);
  if (mr == 1) { x1 = -x1; x2 = -x2; dx1 = -dx1; dx2 = -dx2;
                 sw = x1;  x1 = x2;   x2 = sw;  sw = y1;  y1 = y2;   y2 = sw;  sw = w1; w1 = w2; w2 = sw;
                 sw = dx1; dx1 = dx2; dx2 = sw; sw = dy1; dy1 = dy2; dy2 = sw; dy = - dy;
               }
  b = 2 * acos((dx * dx1 + dy * dy1) / (d * sqrt(dx1 * dx1 + dy1 * dy1))); a = TWO_PI - b;
  float[] d1x = drawUse.arr1, d1y = drawUse.arr2, d2x = drawUse.arr3, d2y = drawUse.arr4;       
  x = x1 + (d1x[0] = dx1); y = y1 + (d1y[0] = dy1);
  if (gf) { beginShape();
            vertex(x, y);
          }  
  s1 = ceil(a * drawUse.cSegs(w1) / TWO_PI);
  ad1 = a / s1; a1 = drawUse.xyAngle(dx1, dy1); a2 = a1 - ad1;
  for (i = 1; i <= s1; i++) { x = x1 + (d1x[i] = w1 * cos(a2)); y = y1 + (d1y[i] = - w1 * sin(a2));
                              if (gf) vertex(x, y); 
                              a2 -= ad1;
                            }
  a3 = b + drawUse.xyAngle(dx2, dy2);
  x = x2 + (d2x[0] = dx2 = w2 * cos(a3)); y = y2 + (d2y[0] = dy2 = -w2 * sin(a3));
  if (gf) vertex(x, y);
  s2 = ceil(b * drawUse.cSegs(w2) / TWO_PI);
  ad2 = b / s2; a4 = a3 - ad2;
  for (i = 1; i <= s2; i++) { x = x2 + (d2x[i] = w2 * cos(a4)); y = y2 + (d2y[i] = - w2 * sin(a4));      
                              if (gf) vertex(x, y);
                              a4 -= ad2;
                            }
  if (gf) endShape(CLOSE);
  float dr, r, wr = g.strokeWeight / 2;
  if (!gs || (wr * sc < 0.0015)) { popStyle(); return; } 
  fill(g.strokeColor);
  beginShape();
  dr = 1.0 + wr / w1; r = w1 + wr;
  s = ceil(a * drawUse.cSegs(r) / TWO_PI); 
  vertex(x = x1 + dx1 * dr, y = y1 + dy1 * dr);
  if ((s - s1) > s1 / 8 + 1)
  { s1 = s; ad1 = a / s1; a2 = a1 - ad1; rc1 = true;
    for (i = 1; i <= s1; i++) { vertex (x1 + r * cos(a2), y1 - r * sin(a2)); a2 -= ad1; }
  } else for (i = 1; i <= s1; i++) vertex(x1 + d1x[i] * dr, y1 + d1y[i] * dr);
  dr = 1 + wr / w2; r = w2 + wr;
  s = ceil(b * drawUse.cSegs(r) / TWO_PI); 
  if ((s - s2) > s2 / 8 + 1)
  { vertex(x2 + dx2 * dr, y2 + dy2 * dr);
    s2 = s; ad2 = b / s2; a4 = a3 - ad2; rc2 = true;
    for (i = 1; i <= s2; i++) { vertex (x2 + r * cos(a4), y2 - r * sin(a4)); a4 -= ad2; }
  } else for (i = 0; i <= s2; i++) vertex(x2 + d2x[i] * dr, y2 + d2y[i] * dr);
  if ((w1 > wr) || (w2 >  wr))
  { vertex(x, y);
    d = 1.0 - wr / w1;
    vertex(x = x1 + dx1 * d, y = y1 + dy1 * d);
    dr = 1.0 - wr / w2; r = w2 - wr;
    if (rc2)
    { a4 += ad2;
      for (i = s2; i >= 0; i--) { vertex (x2 + r * cos(a4), y2 - r * sin(a4)); a4 += ad2; }
    } else for (i = s2; i >= 0; i--) vertex(x2 + d2x[i] * dr, y2 + d2y[i] * dr);
    dr = d; r = w1 - wr;
    if (rc1)
    { a2 += ad1;
      for (i = s1; i > 0; i--) { vertex (x1 + r * cos(a2), y1 - r * sin(a2)); a2 += ad1; }
    } else for (i = s1; i > 0; i--) vertex(x1 + d1x[i] * dr, y1 + d1y[i] * dr);/**/     
    vertex(x, y);       
  }
  endShape(CLOSE);
  popStyle();    
}

//////////// Service
void drawSnap() { drawUse.snap(); };
float drawScale() { drawUse.snap(); return drawUse.scale; };

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