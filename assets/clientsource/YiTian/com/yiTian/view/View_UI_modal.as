package com.yiTian.view
{
   import com.yiTian.Global;
   import com.yiTian.manager.KeyboardManager;
   import com.yiTian.scene.GameScene;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   
   public class View_UI_modal extends UIBase
   {
      
      private static var shape:Shape;
      
      protected var dis_bg:DisplayObject;
      
      public function View_UI_modal()
      {
         super();
         if(shape == null)
         {
            shape = new Shape();
            shape.graphics.beginFill(0,0.1);
            shape.graphics.drawRect(0,0,Global.stage.stageWidth,Global.stage.stageHeight);
            shape.graphics.endFill();
            GameScene.modalLayer.addChild(shape);
         }
         GameScene.modalLayer.addChild(this);
         super.visible = false;
         shape.visible = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            super.visible = true;
            shape.visible = true;
            KeyboardManager.isEnabled = false;
            this.resetPosition();
         }
         else
         {
            super.visible = false;
            shape.visible = false;
            KeyboardManager.isEnabled = true;
         }
      }
   }
}

