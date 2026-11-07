package com.yiTian.view.modules.actions.huoYueDu
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ActionsCGMessage;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class HuoYueDuTip
   {
      
      private static var ins:HuoYueDuTip;
      
      public static var isFirstApplay:Boolean = true;
      
      private var tipBtn:MainUIBtn;
      
      private var eff:Effect;
      
      public function HuoYueDuTip()
      {
         super();
      }
      
      public static function get instance() : HuoYueDuTip
      {
         if(!ins)
         {
            ins = new HuoYueDuTip();
         }
         return ins;
      }
      
      public function show() : void
      {
         if(GameUnitManager.hero.level >= 30)
         {
            this.showTip();
         }
         else
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,this.showTip);
         }
      }
      
      private function firstApplay() : void
      {
      }
      
      public function handle(arr:Array) : void
      {
         var _b:Boolean = false;
         var bool:Boolean = this.match(arr);
         if(bool)
         {
            if(Boolean(this.tipBtn))
            {
               this.addEff();
            }
         }
         else
         {
            this.removeEff();
            _b = this.matchT(arr);
            if(!_b)
            {
               this.removeTip();
            }
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
      
      public function removeTip() : void
      {
         if(UIManager.mainUiBtnContainer.hasBTN(this.tipBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(this.tipBtn);
         }
      }
      
      public function addEff() : void
      {
         if(!this.eff)
         {
            this.eff = EffectManager.addEffect("35343",this.tipBtn,1000,32,29,true);
         }
      }
      
      private function match(_arr:Array) : Boolean
      {
         var _res:int = 0;
         if(!_arr || !_arr.length)
         {
            return false;
         }
         var i:int = 0;
         while(i < _arr.length)
         {
            _res = int(_arr[i]);
            if(_res == 1)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      private function matchT(_arr:Array) : Boolean
      {
         var _res:int = 0;
         if(!_arr || !_arr.length)
         {
            return true;
         }
         var i:int = 0;
         while(i < _arr.length)
         {
            _res = int(_arr[i]);
            if(_res != 2)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      private function showTip() : void
      {
         if(GameUnitManager.hero.level >= 30)
         {
            if(!this.tipBtn)
            {
               this.tipBtn = new MainUIBtn("resource/image/huoYueDu/huoYueDuIcon.png");
               this.tipBtn.addEventListener(MouseEvent.CLICK,this.cliHd);
            }
            if(!UIManager.mainUiBtnContainer.hasBTN(this.tipBtn))
            {
               UIManager.mainUiBtnContainer.addBTN(this.tipBtn);
            }
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,this.showTip);
         }
      }
      
      private function cliHd(e:MouseEvent) : void
      {
         ActionsCGMessage.CG_HUOYUEDU_APPLY();
      }
   }
}

