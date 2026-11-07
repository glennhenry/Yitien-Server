package com.utils
{
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class BitmapUtils
   {
      
      public static const AAA:int = 1;
      
      public function BitmapUtils()
      {
         super();
      }
      
      public static function fillBitmapData(g:Graphics, bmd:BitmapData, x:int, y:int, width:int, height:int, sx:Number = 1, sy:Number = 1, tx:Number = 0, ty:Number = 0) : void
      {
         var matr:Matrix = new Matrix();
         matr.scale(sx,sy);
         matr.translate(tx,ty);
         g.beginBitmapFill(bmd,matr,false);
         g.drawRect(x,y,width,height);
         g.endFill();
      }
      
      public static function scale9Fill(g:Graphics, bmd:BitmapData, s9Top:int, s9Right:int, s9Left:int, s9Bottom:int, x:int, y:int, width:int, height:int) : void
      {
         var rectx:Number = NaN;
         var recty:Number = NaN;
         var w:Number = NaN;
         var h:Number = NaN;
         var drawW:Number = NaN;
         var drawH:Number = NaN;
         var cy:int = 0;
         var grid9:Rectangle = new Rectangle(s9Left,s9Top,s9Right - s9Left,s9Bottom - s9Top);
         var right:Number = bmd.width - grid9.right;
         var bottom:Number = bmd.height - grid9.bottom;
         var rows:Array = [0,s9Top,s9Bottom,bmd.height];
         var cols:Array = [0,s9Left,s9Right,bmd.width];
         var sx:Number = 1;
         var sy:Number = 1;
         var startx:Number = 0;
         var starty:Number = 0;
         var cx:int = 0;
         while(cx < 3)
         {
            cy = 0;
            while(cy < 3)
            {
               rectx = Number(cols[cx]);
               recty = Number(rows[cy]);
               w = cols[cx + 1] - cols[cx];
               h = rows[cy + 1] - rows[cy];
               if(cx == 1 && cy == 0 || cx == 1 && cy == 2)
               {
                  drawW = width - (right + s9Left);
                  drawH = h;
                  sx = drawW / w;
                  sy = 1;
               }
               else if(cx == 0 && cy == 1 || cx == 2 && cy == 1)
               {
                  drawW = w;
                  drawH = height - (bottom + s9Top);
                  sx = 1;
                  sy = drawH / h;
               }
               else if(cx == 1 && cy == 1)
               {
                  drawW = width - (right + s9Left);
                  drawH = height - (bottom + s9Top);
                  sx = drawW / w;
                  sy = drawH / h;
               }
               else
               {
                  drawW = w;
                  drawH = h;
                  sy = 1;
                  sx = 1;
               }
               fillBitmapData(g,bmd,startx,starty,drawW,drawH,sx,sy,startx - rectx * sx,starty - recty * sy);
               starty += drawH;
               cy++;
            }
            startx += drawW;
            starty = 0;
            cx++;
         }
      }
   }
}

