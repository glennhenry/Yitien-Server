package com.yiTian.view.modules.mainUIBtnContainer
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.view.MainUIBase;
   import flash.display.Shape;
   import flash.utils.Dictionary;
   
   public class ViewNextSys extends MainUIBase
   {
      
      private var tf:MyTextField;
      
      private var shape:Shape;
      
      public function ViewNextSys()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.shape = ComponentUtil.getShape(240,25,0,0.5);
         addChild(this.shape);
         this.tf = ComponentUtil.getTextField("武林大会活动在20:15开始（每二、四、六）",this,{
            "x":5,
            "y":3
         });
         mouseChildren = false;
         visible = false;
      }
      
      public function update(index:int) : void
      {
         var dic:Dictionary = Data_lib.next_sys;
         var arr:Array = Data_lib.next_sys[index];
         this.tf.text = Data_lib.next_sys[index][0];
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth - 240;
         y = 445;
      }
   }
}

