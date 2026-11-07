package com.yiTian.view.modules.yellowDiamond.newAct
{
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.YelloDiaCGMessage;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class NewYearActTip
   {
      
      private static var _instance:NewYearActTip;
      
      private var tipBtn:MainUIBtn;
      
      private var eff:Effect;
      
      public function NewYearActTip()
      {
         super();
      }
      
      public static function get instance() : NewYearActTip
      {
         if(!_instance)
         {
            _instance = new NewYearActTip();
         }
         return _instance;
      }
      
      public function show(value:Boolean = false) : void
      {
         if(Global.pf != Enum_SPStr.QQ3366 && Global.pf != Enum_SPStr.QQGAME)
         {
            return;
         }
         if(value)
         {
            if(!this.tipBtn)
            {
               this.tipBtn = new MainUIBtn("resource/image/shouchong/festival.png");
               UIManager.mainUiBtnContainer.addBTN(this.tipBtn);
               this.tipBtn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
               {
                  YelloDiaCGMessage.CG_APPLAY_TO_PAN();
               });
            }
            else if(!UIManager.mainUiBtnContainer.hasBTN(this.tipBtn))
            {
               UIManager.mainUiBtnContainer.addBTN(this.tipBtn);
            }
         }
         else
         {
            this.remove();
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

