package com.yiTian.view.modules.boatChall
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class EnterBtn extends MainUIBtn
   {
      
      public static var isStarting:Boolean;
      
      public static const iconUrl:String = "resource/image/boat/longzhou.png";
      
      private var eff:Effect;
      
      public function EnterBtn()
      {
         super(iconUrl);
      }
      
      public static function get instance() : EnterBtn
      {
         return Singleton.getInstance(EnterBtn);
      }
      
      public function show() : void
      {
         isStarting = true;
         if(GameUnitManager.hero.level < 55)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,this.show);
            return;
         }
         Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,this.show);
         UIManager.mainUiBtnContainer.addBTN(this);
         addEventListener(MouseEvent.CLICK,this.clickEvent);
         if(!this.eff)
         {
            this.eff = EffectManager.addEffect("35343",this,1000,32,29,true);
         }
      }
      
      public function hide() : void
      {
         isStarting = false;
         UIManager.mainUiBtnContainer.removeBTN(this);
         removeEventListener(MouseEvent.CLICK,this.clickEvent);
         EffectManager.removeEffect(this.eff);
         this.eff = null;
      }
      
      public function clickEvent(e:MouseEvent = null) : void
      {
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(P_enterGamePanel.instance,P_enterGamePanel.instance.show);
      }
   }
}

