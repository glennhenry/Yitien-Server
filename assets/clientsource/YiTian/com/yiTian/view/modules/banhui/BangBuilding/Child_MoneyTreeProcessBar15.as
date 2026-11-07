package com.yiTian.view.modules.banhui.BangBuilding
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class Child_MoneyTreeProcessBar15 extends Sprite
   {
      
      private static var isInit:Boolean = false;
      
      private var _count:int;
      
      private var back:Bitmap;
      
      private var bar:Bitmap;
      
      private var bmask:Bitmap;
      
      public function Child_MoneyTreeProcessBar15()
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
         if(isInit)
         {
            this.count = 0;
         }
      }
      
      public function init() : void
      {
         if(isInit)
         {
            return;
         }
         isInit = true;
         this.back = new Bitmap();
         this.bar = new Bitmap();
         this.bmask = new Bitmap();
         this.back = ComponentUtil.getBitmap("Back_Garden_Progress",this,null,Global.Bang_Imgsdm);
         this.bar = ComponentUtil.getBitmap("Garden_Progress",this,null,Global.Bang_Imgsdm);
         this.bmask = ComponentUtil.getBitmap("Mas_Garden_Progress",this,null,Global.Bang_Imgsdm);
      }
      
      public function set count(value:int) : void
      {
         this._count = value;
         var persent:Number = this._count / 15;
         persent = persent > 1 ? 1 : persent;
         if(Boolean(this.bar) && Boolean(this.back))
         {
            this.bar.width = this.back.width * persent;
         }
      }
      
      public function get count() : int
      {
         return this._count;
      }
   }
}

