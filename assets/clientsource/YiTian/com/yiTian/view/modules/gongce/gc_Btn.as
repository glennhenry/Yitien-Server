package com.yiTian.view.modules.gongce
{
   import com.yiTian.Global;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import com.yiTian.view.modules.mainUIBtnContainer.View_mainUiBtn_container;
   import flash.events.MouseEvent;
   
   public class gc_Btn
   {
      
      public var gcBtn:MainUIBtn;
      
      private var _eff:Effect;
      
      public function gc_Btn()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
      }
      
      public function eff(v:Boolean) : void
      {
         if(v && !this._eff)
         {
            this._eff = EffectManager.addEffect("35343",this.gcBtn,1000,32,29,true);
         }
         else if(!v && Boolean(this._eff))
         {
            EffectManager.removeEffect(this._eff);
            this._eff = null;
         }
      }
      
      public function show(see:int) : void
      {
         this.gcBtn = new MainUIBtn("resource/image/gongce/gcBtn.png");
         this.eff(true);
         if(Boolean(see))
         {
            UIManager.mainUiBtnContainer.addBTN(this.gcBtn);
            this.gcBtn.addEventListener(MouseEvent.CLICK,this.gcBtnClick);
            this.checkAndRemoveCaiBiaoBtn();
            Global.control.registerCallBack(View_mainUiBtn_container.ADD_BTN,this.checkAndRemoveCaiBiaoBtn);
         }
         else
         {
            UIManager.mainUiBtnContainer.removeBTN(this.gcBtn);
            this.gcBtn.removeEventListener(MouseEvent.CLICK,this.gcBtnClick);
            Global.control.removeCallBack(View_mainUiBtn_container.ADD_BTN,this.checkAndRemoveCaiBiaoBtn);
         }
      }
      
      private function checkAndRemoveCaiBiaoBtn() : void
      {
         UIManager.mainUiBtnContainer.removeBTN(UIManager.paoBiaoPanel.icon2);
      }
      
      private function gcBtnClick(e:MouseEvent) : void
      {
         if(Boolean(this._eff))
         {
            this.eff(false);
         }
         Global.delegate.dosomething(UIManager.gongCe,UIManager.gongCe.show);
      }
   }
}

