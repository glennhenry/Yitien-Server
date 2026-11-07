package com.yiTian.view.modules.tip.tips
{
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import flash.display.Sprite;
   
   public class View_tip extends Sprite
   {
      
      protected var border:ScaleBitmap;
      
      public function View_tip()
      {
         super();
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      public function Show(obj:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         throw new Error("abstract function must override");
      }
      
      public function Init() : void
      {
         throw new Error("abstract function must override");
      }
      
      final protected function addBorder(str:String = "Back_Floating") : void
      {
         if(!this.border)
         {
            this.border = ComponentUtil.getScaleBitmap(str,[8,9,4,2],this,{
               "x":0,
               "y":0,
               "width":87,
               "height":95
            },Global.Img_Cdm);
            addChild(this.border);
         }
      }
      
      final protected function removeBorder() : void
      {
         if(Boolean(this.border))
         {
            removeChild(this.border);
            this.border = null;
         }
      }
      
      override public function get width() : Number
      {
         if(Boolean(this.border))
         {
            return this.border.width;
         }
         return super.width;
      }
      
      override public function get height() : Number
      {
         if(Boolean(this.border))
         {
            return this.border.height;
         }
         return super.height;
      }
   }
}

