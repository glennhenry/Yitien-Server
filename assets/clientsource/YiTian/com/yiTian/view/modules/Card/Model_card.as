package com.yiTian.view.modules.Card
{
   import com.yiTian.Global;
   
   public class Model_card
   {
      
      public static var isZhanBuGetCard:Boolean;
      
      public static var leftTimes:int;
      
      private static var _countDown:int;
      
      public static var haveUseTimes:int;
      
      public static var haveUseMoneyZhanBuTimes:int;
      
      public static var curXingZuo:int;
      
      public static var ZhanBuCardID:int;
      
      private static var _equipGridOpen:int;
      
      public static var dragType:int;
      
      public static var dragCard:View_card_small;
      
      public static var dragCardGridID:int;
      
      public static var canUndress:Boolean;
      
      public static var firstPlay:Boolean = false;
      
      public static var isPlaying:Boolean = false;
      
      private static var _exp:int = -1;
      
      private static var _piece:int = -1;
      
      public static var ZhanBuCardArray:Array = [];
      
      public static var bagCardVoArray:Array = [];
      
      public static var equipCardVoArray:Array = [];
      
      public static var totalAttribute:Array = [];
      
      public function Model_card()
      {
         super();
      }
      
      public static function get exp() : int
      {
         return _exp;
      }
      
      public static function set exp(value:int) : void
      {
         _exp = value;
         Global.control.sendNotification(CardEvent.EXP,null);
      }
      
      public static function get piece() : int
      {
         return _piece;
      }
      
      public static function set piece(value:int) : void
      {
         _piece = value;
         Global.control.sendNotification(CardEvent.PIECE,null);
      }
      
      public static function get equipGridOpen() : int
      {
         return _equipGridOpen;
      }
      
      public static function set equipGridOpen(value:int) : void
      {
         _equipGridOpen = value;
         Global.control.sendNotification(CardEvent.EQUIP_GRID_OPEN,null);
      }
      
      public static function get countDown() : int
      {
         return _countDown;
      }
      
      public static function set countDown(value:int) : void
      {
         _countDown = value;
         Global.control.sendNotification(CardEvent.UPDATE_COUNT_DOWN,null);
      }
   }
}

