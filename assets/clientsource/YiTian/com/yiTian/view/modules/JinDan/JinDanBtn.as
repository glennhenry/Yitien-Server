package com.yiTian.view.modules.JinDan
{
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.JinDanCGMessage;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class JinDanBtn
   {
      
      private var GoldEggBtn:MainUIBtn;
      
      public function JinDanBtn()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.GoldEggBtn = new MainUIBtn("resource/image/JinDan/zajindan.png");
      }
      
      public function show() : void
      {
         if(JinDanVO.see == 1)
         {
            UIManager.mainUiBtnContainer.addBTN(this.GoldEggBtn);
            this.GoldEggBtn.addEventListener(MouseEvent.CLICK,this.GoldEggBtnClick);
         }
         else if(JinDanVO.see == 0)
         {
            UIManager.mainUiBtnContainer.removeBTN(this.GoldEggBtn);
            this.GoldEggBtn.removeEventListener(MouseEvent.CLICK,this.GoldEggBtnClick);
         }
      }
      
      public function GoldEggBtnClick(e:MouseEvent = null) : void
      {
         if(GameUnitManager.hero.level >= 30)
         {
            JinDanCGMessage.CG_GOLD_EGG();
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("60465",6));
         }
      }
   }
}

