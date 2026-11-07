package com.yiTian.view.modules.yellowDiamond
{
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class BaoshiQingYuanTip
   {
      
      private static var _ins:BaoshiQingYuanTip;
      
      private var tipBtn:MainUIBtn;
      
      private var eff:Effect;
      
      public function BaoshiQingYuanTip()
      {
         super();
      }
      
      public static function get instance() : BaoshiQingYuanTip
      {
         if(!_ins)
         {
            _ins = new BaoshiQingYuanTip();
         }
         return _ins;
      }
      
      public function show() : void
      {
      }
      
      private function cliHd(e:MouseEvent) : void
      {
         var tip:BaoshiQYTips = Singleton.getInstance(BaoshiQYTips) as BaoshiQYTips;
         tip.visible = true;
         this.removeEff();
      }
      
      public function removeEff() : void
      {
         if(Boolean(this.eff))
         {
            EffectManager.removeEffect(this.eff);
         }
         this.eff = null;
      }
      
      public function remove() : void
      {
         if(UIManager.mainUiBtnContainer.hasBTN(this.tipBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(this.tipBtn);
         }
      }
   }
}

