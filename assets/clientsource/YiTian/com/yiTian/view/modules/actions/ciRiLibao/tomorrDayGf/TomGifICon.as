package com.yiTian.view.modules.actions.ciRiLibao.tomorrDayGf
{
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class TomGifICon
   {
      
      private static var _instance:TomGifICon;
      
      private var btn:MainUIBtn;
      
      private var eff:Effect;
      
      public function TomGifICon()
      {
         super();
      }
      
      public static function get instance() : TomGifICon
      {
         return _instance = _instance || new TomGifICon();
      }
      
      public static function dealWidData(data:Array) : void
      {
         var status:int = 0;
         if(!data)
         {
            return;
         }
         var len:int = int(data.length);
         var bool:Boolean = false;
         var i:int = 0;
         while(i < len)
         {
            status = int(data[i]);
            if(status == 0)
            {
               bool = true;
               break;
            }
            i++;
         }
         if(bool)
         {
            instance.showEff();
         }
         else
         {
            instance.removeEff();
         }
      }
      
      public function show() : void
      {
         if(!this.btn)
         {
            this.btn = new MainUIBtn("resource/image/ciRiGift/testCiriGift.png");
            UIManager.mainUiBtnContainer.addBTN(this.btn);
            this.btn.addEventListener(MouseEvent.CLICK,this.clickHd);
         }
      }
      
      public function showEff() : void
      {
         if(Boolean(this.btn) && !this.eff)
         {
            this.eff = EffectManager.addEffect("35060",this.btn,1000,28,29,true);
         }
      }
      
      public function removeEff() : void
      {
         if(Boolean(this.eff))
         {
            EffectManager.removeEffect(this.eff);
            this.eff = null;
         }
      }
      
      public function remove() : void
      {
         if(Boolean(this.btn) && UIManager.mainUiBtnContainer.hasBTN(this.btn))
         {
            UIManager.mainUiBtnContainer.removeBTN(this.btn);
            if(this.btn.hasEventListener(MouseEvent.CLICK))
            {
               this.btn.removeEventListener(MouseEvent.CLICK,this.clickHd);
            }
            this.btn = null;
            this.removeEff();
         }
      }
      
      public function clickHd(e:MouseEvent = null) : void
      {
         var pan:TomDayGift = null;
         if(GameUnitManager.hero.level < 20)
         {
            UIManager.centerBroadcast.addMsg("该系统20级开放",1);
            return;
         }
         if(!this.btn)
         {
            UIManager.centerBroadcast.addMsg("您已领取完了该奖励");
            return;
         }
         pan = TomDayGift.instance;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pan,function():void
         {
            pan.visible = !pan.visible;
         });
      }
   }
}

