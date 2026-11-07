package com.yiTian.view.modules.baby
{
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   
   public class Ibaby extends Sprite
   {
      
      public static var tiaoZheng:int = 0;
      
      protected var back:ScaleBitmap;
      
      public var isInit:Boolean = false;
      
      public function Ibaby(_p:DisplayObjectContainer)
      {
         super();
         var back:ScaleBitmap = ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],_p,{
            "width":258,
            "height":318
         },Global.Img_Cdm);
         ComponentUtil.setPropertie(back,{"x":tiaoZheng});
      }
      
      public function show(obj:* = null) : void
      {
      }
      
      public function hide(obj:* = null) : void
      {
      }
      
      public function update(obj:* = null) : void
      {
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         this.isInit = true;
      }
   }
}

