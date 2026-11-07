package com.yiTian.view
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.BattleManager;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.scene.GameScene;
   import flash.display.Sprite;
   
   public class Panel2 extends Panel
   {
      
      public function Panel2()
      {
         super();
      }
      
      override public function set visible(value:Boolean) : void
      {
         this.setDynamic(value);
         if(value)
         {
            bindParent = BattleManager.isPlaying ? GameScene.battleLayer : GameScene.uiLayer;
         }
         super.visible = value;
      }
      
      public function setDynamic(value:Boolean) : void
      {
         if(value)
         {
            Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_START,this.bStartHd);
            Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,this.bEndHd);
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_START,this.bStartHd);
            Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_END,this.bEndHd);
         }
      }
      
      protected function bStartHd() : void
      {
         GameScene.battleLayer.addChild(this);
         bindParent = GameScene.battleLayer;
      }
      
      protected function bEndHd() : void
      {
         if(Boolean(_tmpParent) && ModalUIManager.isShow)
         {
            bindParent = _tmpParent;
            _tmpParent.addChild(this);
         }
         else
         {
            bindParent = GameScene.uiLayer;
            GameScene.uiLayer.addChild(this);
         }
      }
   }
}

