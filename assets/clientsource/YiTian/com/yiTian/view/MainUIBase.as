package com.yiTian.view
{
   import com.yiTian.scene.GameScene;
   
   public class MainUIBase extends UIBase
   {
      
      public function MainUIBase()
      {
         super();
         bindParent = GameScene.uiLayer;
         GameScene.uiLayer.addChild(this);
      }
   }
}

