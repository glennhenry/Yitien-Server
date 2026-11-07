package com.yiTian.view.modules.baby.babyPan
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class PaoPao extends Sprite
   {
      
      public static var nowIndex:uint = 1;
      
      public static var stop:Boolean = false;
      
      private var bm1:Bitmap;
      
      private var bm2:Bitmap;
      
      private var bm3:Bitmap;
      
      private var bm4:Bitmap;
      
      public function PaoPao()
      {
         super();
         this.bm4 = ComponentUtil.getBitmap("MP_MaoPao4",this,{
            "x":4,
            "y":0
         },Global.ZNdm);
         this.bm3 = ComponentUtil.getBitmap("MP_MaoPao3",this,{
            "x":19,
            "y":60
         },Global.ZNdm);
         this.bm2 = ComponentUtil.getBitmap("MP_MaoPao2",this,{
            "x":10,
            "y":75
         },Global.ZNdm);
         this.bm1 = ComponentUtil.getBitmap("MP_MaoPao1",this,{
            "x":0,
            "y":85
         },Global.ZNdm);
         this.bm1.visible = this.bm2.visible = this.bm3.visible = this.bm4.visible = false;
      }
      
      public function play(index:uint) : void
      {
         var n:int = 0;
         var m:int = 0;
         nowIndex = index;
         if(stop)
         {
            return;
         }
         this["bm" + index].visible = true;
         if(index == 4)
         {
            m = int(setTimeout(function():void
            {
               var mm:* = undefined;
               clearTimeout(m);
               bm1.visible = bm2.visible = bm3.visible = bm4.visible = false;
               mm = setTimeout(function():void
               {
                  clearTimeout(mm);
                  play(1);
               },200);
            },2000));
            return;
         }
         n = int(setTimeout(function():void
         {
            clearTimeout(n);
            play(++index);
         },500));
      }
      
      public function update_bm4(index:uint = 0) : void
      {
         if(index == 0)
         {
            this.bm4.bitmapData = ComponentUtil.getBitmapData("MP_MaoPao4",Global.ZNdm);
         }
         else
         {
            this.bm4.bitmapData = ComponentUtil.getBitmapData("MP_MaoPao6",Global.ZNdm);
         }
      }
   }
}

