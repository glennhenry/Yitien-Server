package com.yiTian.view.modules.role
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class View_role_base extends Sprite
   {
      
      protected var dis_bg:DisplayObject;
      
      public function View_role_base()
      {
         super();
      }
      
      public function Init() : void
      {
         throw new Error("抽象方法");
      }
   }
}

