package com.yiTian.view.modules.guaji
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class Child_processStar extends Sprite
   {
      
      private var _starMask:DisplayObject;
      
      private var _percent:Number;
      
      private var _starMask2:DisplayObject;
      
      public function Child_processStar()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this._starMask = ComponentUtil.getBitmap("StartFull",this,null,Global.Img_Cdm);
         this._starMask2 = ComponentUtil.getBitmap("StartEmpty",this,null,Global.Img_Cdm);
         this.percent = 0;
      }
      
      public function set percent(value:Number) : void
      {
         if(value >= 100)
         {
            value = 100;
            this._starMask2.visible = false;
            this._starMask.visible = true;
         }
         else if(value <= 0)
         {
            value = 0;
            this._starMask2.visible = true;
            this._starMask.visible = false;
         }
         else
         {
            value = 0;
            this._starMask2.visible = true;
            this._starMask.visible = false;
         }
         this._percent = value;
      }
   }
}

