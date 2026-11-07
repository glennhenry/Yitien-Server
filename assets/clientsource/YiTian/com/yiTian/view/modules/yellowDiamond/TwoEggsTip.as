package com.yiTian.view.modules.yellowDiamond
{
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class TwoEggsTip
   {
      
      private static var _ins:TwoEggsTip;
      
      private var tipBtn:MainUIBtn;
      
      private var eff:Effect;
      
      public function TwoEggsTip()
      {
         super();
      }
      
      public static function get instance() : TwoEggsTip
      {
         if(!_ins)
         {
            _ins = new TwoEggsTip();
         }
         return _ins;
      }
      
      public function show() : void
      {
         if(GameUnitManager.hero.level >= 30)
         {
            if(!this.tipBtn)
            {
               this.tipBtn = new MainUIBtn("resource/image/twoEggs/twoEggs.png");
               UIManager.mainUiBtnContainer.addBTN(this.tipBtn);
               this.tipBtn.addEventListener(MouseEvent.CLICK,this.cliHd);
               if(!this.eff)
               {
                  this.eff = EffectManager.addEffect("35343",this.tipBtn,1000,32,29,true);
               }
            }
         }
      }
      
      private function cliHd(e:MouseEvent) : void
      {
         var pan:View_twoEggs = null;
         pan = Singleton.getInstance(View_twoEggs) as View_twoEggs;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pan,function():void
         {
            pan.visible = !pan.visible;
         });
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

