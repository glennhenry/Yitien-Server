package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_ChongChuJiangHu;
   import com.yiTian.data.model.Model_ChongChuJiangHu;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ChongChuJinagHuCGMessage;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.view.modules.ChongChuJiangHu.View_ChongChuJiangHu_Icon;
   import com.yiTian.view.modules.ChongChuJiangHu.View_ChongChuJiangHu_menu;
   
   public class ChongChuJiangHuHandle
   {
      
      public function ChongChuJiangHuHandle()
      {
         super();
      }
      
      public static function IconHandle(flag:int) : void
      {
         if(flag == 1)
         {
            if(!UIManager.mainUiBtnContainer.hasBTN(View_ChongChuJiangHu_Icon.instance))
            {
               UIManager.mainUiBtnContainer.addBTN(View_ChongChuJiangHu_Icon.instance);
            }
            View_ChongChuJiangHu_Icon.instance.effectBegin();
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP_2,onLevelLimitHandel);
            checkBattleJump();
         }
         else if(flag == 0)
         {
            if(UIManager.mainUiBtnContainer.hasBTN(View_ChongChuJiangHu_Icon.instance))
            {
               UIManager.mainUiBtnContainer.removeBTN(View_ChongChuJiangHu_Icon.instance);
            }
            View_ChongChuJiangHu_Icon.instance.effectEnd();
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,onLevelLimitHandel);
            Enum_ChongChuJiangHu.CAN_JUMP = false;
            View_ChongChuJiangHu_menu.instance.visible = false;
            UIManager.centerBroadcast.addMsg("活动结束");
         }
      }
      
      public static function OpenMenuHandle(arr:Array) : void
      {
         Model_ChongChuJiangHu.getPrizeStatus = arr;
         var i:int = 0;
         while(i < arr.length)
         {
            if(arr[i] == 1)
            {
               View_ChongChuJiangHu_Icon.instance.effectBegin();
               break;
            }
            if(arr[arr.length - 1] != 1)
            {
               View_ChongChuJiangHu_Icon.instance.effectEnd();
            }
            i++;
         }
         View_ChongChuJiangHu_menu.instance.UpdateGetPrizeStatus();
      }
      
      public static function GetPrizeHandle(flag:int) : void
      {
         if(flag == 0)
         {
            UIManager.centerBroadcast.addMsg("领取成功");
            View_ChongChuJiangHu_menu.instance.FlyToBag();
         }
         else if(flag == 1)
         {
            UIManager.centerBroadcast.addMsg("领取失败");
         }
      }
      
      private static function onLevelLimitHandel(e:Number) : void
      {
         trace("level>>>>>>>>",e);
         if(e as Number > 32)
         {
            Enum_ChongChuJiangHu.CAN_JUMP = false;
         }
         ChongChuJinagHuCGMessage.OpenMenu();
         if(e as Number >= Data_lib.ChongChuJiangHu[5][0])
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,onLevelLimitHandel);
         }
      }
      
      private static function checkBattleJump() : void
      {
         if(GameUnitManager.hero.level < 33)
         {
            Enum_ChongChuJiangHu.CAN_JUMP = true;
            MassLoader.add("lang/ch/jumpCG.swf",loadCom);
         }
         else
         {
            Enum_ChongChuJiangHu.CAN_JUMP = false;
         }
      }
      
      private static function loadCom(info:Object) : void
      {
         Global.jumpCG_dm = info.applicationDomain;
         trace("loaded swf");
      }
   }
}

