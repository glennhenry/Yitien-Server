package com.yiTian.data.config
{
   import com.yiTian.Global;
   
   public class Enum_Jianghulixian
   {
      
      private static var _GameStatus:int;
      
      public static const Jianghulixian_UPDATE_LEFT_TIME:String = "Jianghulixian_updateLeftTime";
      
      public static const Jianghulixian_GAME_START:String = "jianghulixian_gameStart";
      
      public static const Jianghulixian_GAME_CHANGE_STATUS:String = "jianghulixian_gameChangeStatus";
      
      public static const Jianghulixian_CHECK_CHANGE_CARD:String = "jianghulixianCheckChangeCard";
      
      public static const Jianghulixian_CARD_OPENED:String = "jianghulixianCardOpened";
      
      public static const Jianghulixian_UPDATE_Yueli:String = "Jianghulixian_updateYueli";
      
      public static var NamePrizeArray:Array = [];
      
      public static var MoneyPrizeArray:Array = [];
      
      public static var YueliPrizeArrar:Array = [];
      
      public function Enum_Jianghulixian()
      {
         super();
      }
      
      public static function get GameStatus() : int
      {
         return _GameStatus;
      }
      
      public static function set GameStatus(value:int) : void
      {
         _GameStatus = value;
         Global.control.sendNotification(Enum_Jianghulixian.Jianghulixian_GAME_CHANGE_STATUS,null);
      }
   }
}

