package com.yiTian.view.modules.wuyi
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class wuyiBtn
   {
      
      private var wyBtn:MainUIBtn;
      
      private var _eff:Effect;
      
      public function wuyiBtn()
      {
         super();
         this.init();
      }
      
      public function eff(v:Boolean) : void
      {
         if(v && !this._eff)
         {
            this._eff = EffectManager.addEffect("35343",this.wyBtn,1000,32,29,true);
         }
         else if(!v && Boolean(this._eff))
         {
            EffectManager.removeEffect(this._eff);
            this._eff = null;
         }
      }
      
      private function init() : void
      {
         this.wyBtn = new MainUIBtn("resource/image/wuyi/wyBtn.png");
         this.eff(true);
      }
      
      public function show(see:int) : void
      {
         if(Boolean(see))
         {
            this.showBtn();
         }
         else
         {
            this.removeBtn();
         }
      }
      
      private function showBtn() : void
      {
         if(GameUnitManager.hero.level < 30)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,this.showBtn);
         }
         else
         {
            UIManager.mainUiBtnContainer.addBTN(this.wyBtn);
            this.wyBtn.addEventListener(MouseEvent.CLICK,this.wyBtnClick);
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,this.showBtn);
         }
      }
      
      private function removeBtn() : void
      {
         if(UIManager.mainUiBtnContainer.hasBTN(this.wyBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(this.wyBtn);
         }
      }
      
      private function wyBtnClick(e:MouseEvent) : void
      {
         if(Boolean(this._eff))
         {
            this.eff(false);
         }
         Global.delegate.dosomething(UIManager.wuyi,UIManager.wuyi.show);
      }
   }
}

