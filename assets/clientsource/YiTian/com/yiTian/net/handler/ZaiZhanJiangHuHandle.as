package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.zaiZhanJiangHu.View_ZaiZhanJiangHu_Panel;
   import com.yiTian.view.modules.zaiZhanJiangHu.View_ZaiZhanJiangHu_icon;
   import flash.events.MouseEvent;
   
   public class ZaiZhanJiangHuHandle
   {
      
      public function ZaiZhanJiangHuHandle()
      {
         super();
      }
      
      public static function IconSwitch(flag:int = 1) : void
      {
         if(flag == 0)
         {
            UIManager.mainUiBtnContainer.removeBTN(View_ZaiZhanJiangHu_icon.instance);
            View_ZaiZhanJiangHu_icon.instance.effectEnd();
         }
         else if(flag == 1)
         {
            UIManager.mainUiBtnContainer.addBTN(View_ZaiZhanJiangHu_icon.instance);
            View_ZaiZhanJiangHu_icon.instance.effectBegin();
         }
         else if(flag == 2)
         {
            UIManager.mainUiBtnContainer.addBTN(View_ZaiZhanJiangHu_icon.instance);
            View_ZaiZhanJiangHu_icon.instance.effectBegin();
            View_ZaiZhanJiangHu_icon.instance.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      public static function ReadAwardBtnState(dataA:Array) : void
      {
         View_ZaiZhanJiangHu_Panel.data_arr = dataA;
         Global.delegate.dosomething(View_ZaiZhanJiangHu_Panel.instance,function():void
         {
            if(View_ZaiZhanJiangHu_icon.instance.visible)
            {
               View_ZaiZhanJiangHu_Panel.instance.update();
            }
            else
            {
               View_ZaiZhanJiangHu_Panel.instance.visible = false;
            }
         });
      }
      
      public static function AwardResultShow(result:int, btnIndex:int) : void
      {
         var num:int = 0;
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("领取成功");
            if(View_ZaiZhanJiangHu_Panel.instance.visible)
            {
               View_ZaiZhanJiangHu_Panel.instance.getPanelItem(btnIndex - 1);
               --View_ZaiZhanJiangHu_Panel._awardNum;
               if(View_ZaiZhanJiangHu_Panel.getNum >= 3)
               {
                  UIManager.mainUiBtnContainer.removeBTN(View_ZaiZhanJiangHu_icon.instance);
                  View_ZaiZhanJiangHu_icon.instance.effectEnd();
               }
               else
               {
                  num = View_ZaiZhanJiangHu_Panel.getNum + View_ZaiZhanJiangHu_Panel.unReach;
                  if(num >= 3)
                  {
                     UIManager.mainUiBtnContainer.removeBTN(View_ZaiZhanJiangHu_icon.instance);
                     View_ZaiZhanJiangHu_icon.instance.effectEnd();
                  }
               }
            }
         }
         else if(result == 0)
         {
            UIManager.centerBroadcast.addMsg("领取失败");
         }
      }
   }
}

