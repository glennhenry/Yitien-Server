package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.HZXianGou.View_HZXianGou_Panel;
   import com.yiTian.view.modules.HZXianGou.View_HZXianGou_icon;
   import com.yiTian.view.modules.zaiZhanJiangHu.View_ZaiZhanJiangHu_icon;
   
   public class HuangZuanXianGouHandle
   {
      
      public function HuangZuanXianGouHandle()
      {
         super();
      }
      
      public static function IconSwitch(flag:int, isLight:int) : void
      {
         if(flag == 0)
         {
            UIManager.mainUiBtnContainer.removeBTN(View_HZXianGou_icon.instance);
            View_ZaiZhanJiangHu_icon.instance.effectEnd();
         }
         else if(flag == 1)
         {
            if(Global.pf == Enum_SPStr.QZONE || Global.pf == Enum_SPStr.PENGYOU || Enum_SPStr.isIwan(Global.pf))
            {
               UIManager.mainUiBtnContainer.addBTN(View_HZXianGou_icon.instance);
               if(isLight == 1)
               {
                  View_ZaiZhanJiangHu_icon.instance.effectBegin();
               }
            }
         }
      }
      
      public static function showPanel(isSuper:int, data:Array) : void
      {
         if(Boolean(data))
         {
            Global.delegate.dosomething(View_HZXianGou_Panel.instance,function():void
            {
               View_HZXianGou_Panel.instance.update(isSuper,data);
            });
         }
      }
      
      public static function getAward(arr:Array) : void
      {
         var index:int = 0;
         var flag:int = 0;
         var leftNum:int = 0;
         if(Boolean(arr))
         {
            index = int(arr[0]);
            flag = int(arr[1]);
            leftNum = int(arr[2]);
            if(Boolean(View_HZXianGou_Panel.instance))
            {
               View_HZXianGou_Panel.instance.showResult(index,flag,leftNum);
            }
         }
      }
   }
}

