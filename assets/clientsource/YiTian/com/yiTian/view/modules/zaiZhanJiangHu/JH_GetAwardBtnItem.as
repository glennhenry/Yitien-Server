package com.yiTian.view.modules.zaiZhanJiangHu
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ZaiZhanJiangHuCGMessage;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class JH_GetAwardBtnItem extends Sprite
   {
      
      private var _getAwardBtn:Button;
      
      private var _btnTextArr:Array = ["领取奖励","一天后可领取","两天后可领取"];
      
      private var _days:int;
      
      private var _itemNum:int;
      
      public function JH_GetAwardBtnItem(len:int)
      {
         super();
         this._itemNum = len;
         this._getAwardBtn = ComponentUtil.getButton("领取奖励","Button_TwoBule91",this,{
            "x":410,
            "y":21
         },Global.Img_Cdm);
         this._getAwardBtn.callBack = this.getAward;
         this._getAwardBtn.label = this._btnTextArr[0];
      }
      
      private function getAward(event:MouseEvent = null) : void
      {
         var _n1:int = CommandManager.get_bag_canUse();
         var _n2:int = CommandManager.get_bag_used();
         if(_n1 - _n2 < this._itemNum)
         {
            UIManager.centerBroadcast.addMsg("请清空背包再领取");
            return;
         }
         ZaiZhanJiangHuCGMessage.CG_ZZJH_ClickAwardButton(this._days);
      }
      
      public function dispose() : void
      {
         this.reset();
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
      }
      
      public function setBtnState(str:String, status:Boolean) : void
      {
         if(Boolean(this._getAwardBtn))
         {
            this._getAwardBtn.label = str;
            this._getAwardBtn.enabled = status;
         }
      }
      
      private function reset() : void
      {
         this._getAwardBtn.visible = false;
      }
      
      public function update(days:int, status:int, day:int) : void
      {
         this.reset();
         var btnText:String = "";
         this._days = days;
         this._getAwardBtn.visible = true;
         if(status == 0)
         {
            if(day > 0)
            {
               btnText = this._btnTextArr[day];
               this._getAwardBtn.enabled = false;
               this._getAwardBtn.label = btnText;
            }
            else
            {
               btnText = "未达条件";
               this._getAwardBtn.enabled = false;
               this._getAwardBtn.label = btnText;
               ++View_ZaiZhanJiangHu_Panel.unReach;
            }
         }
         else if(status == 1)
         {
            btnText = this._btnTextArr[0];
            this._getAwardBtn.enabled = true;
            this._getAwardBtn.label = btnText;
         }
         else if(status == 2)
         {
            btnText = "已领取";
            this._getAwardBtn.enabled = false;
            this._getAwardBtn.label = btnText;
         }
      }
   }
}

