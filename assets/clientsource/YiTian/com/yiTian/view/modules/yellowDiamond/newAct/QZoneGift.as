package com.yiTian.view.modules.yellowDiamond.newAct
{
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class QZoneGift
   {
      
      private static var _instance:QZoneGift;
      
      private var tipBtn:MainUIBtn;
      
      private var eff:Effect;
      
      public function QZoneGift()
      {
         super();
      }
      
      public static function get instance() : QZoneGift
      {
         if(!_instance)
         {
            _instance = new QZoneGift();
         }
         return _instance;
      }
      
      public function show() : void
      {
         if(!this.tipBtn)
         {
            this.tipBtn = new MainUIBtn("resource/image/shouchong/xsGift.png",{"y":5});
            UIManager.mainUiBtnContainer.addBTN(this.tipBtn);
            if(!this.eff)
            {
               this.eff = EffectManager.addEffect("35343",this.tipBtn,1000,32,29,true);
            }
            this.tipBtn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
            {
               UIManager.xshdPan.visible = !UIManager.xshdPan.visible;
            });
         }
      }
      
      public function remove() : void
      {
         if(UIManager.mainUiBtnContainer.hasBTN(this.tipBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(this.tipBtn);
         }
         if(Boolean(this.eff))
         {
            EffectManager.removeEffect(this.eff);
            this.eff = null;
         }
      }
   }
}

