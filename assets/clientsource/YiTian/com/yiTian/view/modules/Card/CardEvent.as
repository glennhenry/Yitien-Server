package com.yiTian.view.modules.Card
{
   import flash.events.Event;
   
   public class CardEvent extends Event
   {
      
      public static const EXP:String = "CardEvent_EXP";
      
      public static const PIECE:String = "CardEvent_PIECE";
      
      public static const EXP_EFFECT:String = "CardEvent_EXP_EFFECT";
      
      public static const LEFT_TIME:String = "CardEvent_LEFT_TIME";
      
      public static const UPDATE_COUNT_DOWN:String = "CardEvent_UPDATE_COUNT_DOWN";
      
      public static const RESET_CURRENT_XingZuo:String = "CardEvent_RESET_CURRENT_XingZuo";
      
      public static const UPDATE_BAG:String = "CardEvent_UPDATE_BAG";
      
      public static const UPDATE_ZhanBu:String = "CardEvent_UPDATE_ZhanBu";
      
      public static const UPDATE_HAVE_USE_TIME:String = "CardEvent_UPDATE_HAVE_USE_TIME";
      
      public static const UPDATE_HAVE_USE_MONEY_TIME:String = "CardEvent_UPDATE_HAVE_USE_MONEY_TIME";
      
      public static const EQUIP_GRID_OPEN:String = "CardEvent_EQUIP_GRID_OPEN";
      
      public static const UPDATE_EQUIP_CARD:String = "CardEvent_UPDATE_EQUIP_CARD";
      
      public static const START_DRAG:String = "CardEvent_START_DRAG";
      
      public static const BAG_PANEL_SELECT_CARD:String = "CardEvent_BAG_PANEL_SELECT_CARD";
      
      public static const EQUIP_PANEL_SELECT_CARD:String = "CardEvent_EQUIP_PANEL_SELECT_CARD";
      
      public static const TunShi_CARD_SUCCESS:String = "CardEvent_TunShi_CARD_SUCCESS";
      
      public static const ShengXing_CARD_SUCCESS:String = "CardEvent_ShengXing_CARD_SUCCESS";
      
      public static const TOTAL_ATTRIBUTE:String = "CardEvent_TOTAL_ATTRIBUTE";
      
      public static const LOCK:String = "CardEvent_LOCK";
      
      public static const CLICK:String = "CardEvent_CLICK";
      
      public var card:View_card_small;
      
      public function CardEvent(type:String, card:View_card_small)
      {
         super(type);
         this.card = card;
      }
   }
}

