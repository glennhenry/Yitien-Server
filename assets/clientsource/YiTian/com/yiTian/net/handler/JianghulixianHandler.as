package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_Jianghulixian;
   import com.yiTian.data.model.Model_Jianghulixian;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.view.modules.jianghulixian.View_Jianghulixian_menu;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   
   public class JianghulixianHandler
   {
      
      private static var t_level:int;
      
      public function JianghulixianHandler()
      {
         super();
      }
      
      private static function upgradeTo34() : void
      {
         if(GameUnitManager.hero.level >= 34)
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,upgradeTo34);
            GC_Jianghulixian_UPDATE_MENU(t_level);
         }
      }
      
      public static function GC_Jianghulixian_UPDATE_MENU(_leftTimes:int) : void
      {
         if(GameUnitManager.hero.level < 34)
         {
            t_level = _leftTimes;
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,upgradeTo34);
            return;
         }
         Model_Jianghulixian.leftTimes = _leftTimes;
         Global.control.sendNotification(Enum_mainUIBtn_hide.SET_COUNT,[Enum_mainUIBtn_hide.JiangHuLiXian,_leftTimes]);
      }
      
      public static function GC_Jianghulixian_SET_RESULT(_leftTimes:int, _typy:int, _cardArr:Array, _cardType:Array) : void
      {
         Model_Jianghulixian.leftTimes = _leftTimes;
         Global.control.sendNotification(Enum_mainUIBtn_hide.SET_COUNT,[Enum_mainUIBtn_hide.JiangHuLiXian,_leftTimes]);
         if(_leftTimes < 0)
         {
            return;
         }
         if(!View_Jianghulixian_menu.inGame)
         {
            View_Jianghulixian_menu.instance.visible = false;
            View_Jianghulixian_menu.instance.outPutPrizeTips(_cardType);
         }
         else
         {
            switch(_typy)
            {
               case 1:
                  Model_Jianghulixian.cardArr = _cardArr;
                  Model_Jianghulixian.cardTypeArr = _cardType;
                  Global.control.sendNotification(Enum_Jianghulixian.Jianghulixian_GAME_START,null);
                  break;
               case 2:
                  View_Jianghulixian_menu.instance.GameOver();
                  break;
               case 3:
                  Model_Jianghulixian.cardArr = _cardArr;
                  Model_Jianghulixian.cardTypeArr = _cardType;
                  View_Jianghulixian_menu.instance.OneKeyHandler();
            }
         }
      }
      
      public static function GC_Jianghulixian_CHANGE_CARD_RESULT(_cardArr:Array, _cardType:Array) : void
      {
         Model_Jianghulixian.cardArr = _cardArr;
         Model_Jianghulixian.cardTypeArr = _cardType;
         View_Jianghulixian_menu.instance.changeCard();
      }
   }
}

